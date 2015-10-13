require 'packetfu'
require 'apachelogregex'

$incidents = 0

def alertIncident(incident, sourceIP, protocol, payload)
    $incidents += 1
    print "%d. ALERT: %s is detected from %s (%s) (%s)!\n" \
        % [$incidents, incident, sourceIP, protocol, payload]
end

def toBinary(s)
    return s.each_byte.map { |b|
        sprintf(" 0x%02X ", b)
    }.join
end

def inspectPacket(packet)
=begin
        If we have a packet that doesn't follow IP protocol, we can't
        report with source ip
=end
    if (packet.proto.index("IP") == nil)
        return
    end

    payload = packet.payload
    proto = packet.proto[-1]
    src = packet.ip_header.ip_src


    if payload.scan(/\x4E\x6D\x61\x70/) != []
        alertIncident("Nmap scan", src, packet.proto[-1], payload)
    end

    if payload.scan(/\x4E\x69\x6B\x74\x6F/) != []
        alertIncident("Nikto scan", src, packet.proto[-1], payload)
    end

    if (payload.index(/([45]\d{3}|6011)([- ]?)\d{4}\2\d{4}\2\d{4}|3\d{3}([- ]?)\d{6}\3\d{5}/) != nil)
        alertIncident("Credit card leak", src, packet.proto[-1], payload)
    end

    if packet.is_a?(PacketFu::TCPPacket)
        flags = packet.tcp_header.tcp_flags
        if (flags.ack == 0 and flags.fin == 0 and flags.psh == 0 and \
            flags.rst == 0 and flags.syn == 0 and flags.urg == 0)
            alertIncident("NULL scan", src, proto, payload)
        elsif (flags.ack == 0 and flags.fin == 1 and flags.psh == 0 and \
               flags.rst == 0 and flags.syn == 0 and flags.urg == 0)
            alertIncident("FIN scan", src, proto, payload)
        elsif (flags.ack == 0 and flags.fin == 1 and flags.psh == 1 and \
            flags.rst == 0 and flags.syn == 0 and flags.urg == 1)
            alertIncident("Xmas scan", src, proto, payload)
        end
    end
end

def monitorLive()
    cap = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
    cap.stream.each { |packet|
        pkt = PacketFu::Packet.parse(packet)
        inspectPacket(pkt)
    }
end

def analyzeLog(file)
    format = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
    parser = ApacheLogRegex.new(format)
    File.foreach(file) do |line|
        request = parser.parse(line)
        src = request['%h']
        req = request['%r']
        proto = "HTTP"
        if (line.match(/nmap/i))
            alertIncident("Nmap scan", src, proto, req)
        end
        if (line.match(/phpmyadmin/i))
            alertIncident("phpMyAdmin", src, proto, req)
        end
        if (line.match(/nikto/i))
            alertIncident("Nikto scan", src, proto, req)
        end
        if (line.match(/masscan/i))
            alertIncident("Masscan", src, proto, req)
        end
        if (line.match(/\(\) *\{ *: *; *\} *;/))
            alertIncident("Shellshock", src, proto, req)
        end
        if (line.match(/(\\x[1-9a-zA-Z]{2})+/))
            alertIncident("Shell code", src, proto, req)
        end
    end
end

if ARGV.length == 0
    monitorLive
elsif ARGV.length == 2 and ARGV[0] == "-r"
    analyzeLog(ARGV[1])
else
    print "Usage: sudo ruby alarm.rb (-r <web server_log>)?\n"
end
