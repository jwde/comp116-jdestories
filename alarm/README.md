<h1>Incident Alarm</h1>

<h3>What has been implemented</h3>
<ul>
<li>
<h4>Analyzing a live stream of network packets</h4>
<ul>
<li>Detects NULL scan</li>
<li>Detects FIN scan</li>
<li>Detects Xmas scan</li>
<li>Detects Nmap scans with the string "Nmap" anywhere in the packet</li>
<li>Detects Nikto scans with the string "Nikto" anywhere in the packet</li>
<li>Detects credit card numbers being transmitted in the clear</li>
</ul>
</li>
<li>
<h4>Analyzing a web server log</h4>
<ul>
<li>Detects log entries with the string "Nmap" anywhere</li>
<li>Detects log entries with the string "Nikto" anywhere</li>
<li>Detects log entries with the string "Masscan" anywhere</li>
<li>Detects log entries with the string "phpMyAdmin" anywhere</li>
<li>Detects log entries with a request attempting to exploit the Shellshock vulnerability</li>
<li>Detects log entries with a request containing shell code</li>
</ul>
</li>
</ul>

<h3>Collaboration</h3>
I've talked with Brad Frizzell and Jared Bronen about the assignment at a high level. I've also talked with people by the couches in Halligan about implementing arbitrary nmap scan detection. 

<h3>Time spent</h3>
Actual time spent coding is about 90 minutes.<br>
Time spent thinking about how to complete the assignment is higher and harder to measure.<br>

<h3>Are the heuristics used in this assignment to determine incidents "even that good"?</h3>
The heuristics used in this assignment will catch alot of incidents, but many will fall through the cracks. It is very difficult to come up with a comprehensive approach to this problem. We will undoubtedly also have a number of false positives where we are searching for patterns (e.g. credit card numbers) which appear in other contexts with different meaning.

<h3>Given more time, what should be improved with regard to detecting incidents?</h3>
Given more time, it would be useful to create a stateful incident alarm. If we knew what packets had arrived within some recent time window, it would be possible to detect scans/attacks that would otherwise be difficult to notice.