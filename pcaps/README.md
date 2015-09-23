# Assignment 1: Packet Sleuth

<h3>set1.pcap</h3>
<h4>1. How many packets are there in this set?</h4>
<p>There are 861 packets in this set.</p>
<h4>2. What protocol was used to transfer files from PC to server?</h4>
<p>FTP</p>
<h4>3. Briefly describe why the protocol used to transfer the files is insecure?</h4>
<p>FTP authentication uses plaintext to transmit both usernames/passwords and files. Because it is not encrypted, anyone who intercepts the traffic can read the credentials and reconstruct the files.</p>
<h4>4. What is the secure alternative to the protocol used to transfer files?</h4>
<p>SFTP is the secure alternative to FTP for file transfers. It encrypts both credentials and content.</p>
<h4>5. What is the IP address of the server?</h4>
<p>192.168.1.8</p>
<h4>6. What was the username and password used to access the server?</h4>
<p>username: defcon<br>password: m1ngisablowhard</p>
<h4>7. How many files were transfered from PC to server?</h4>
<p>3</p>
<h4>8. What are the names of the files transferred from PC to server?</h4>
<p>CDkv69qUsAAq8zN.jpg<br>CLu-mOMWoAAgjkr.jpg<br>CJoWmoOUkAAAYpx.jpg<br>COaqQWnU8AAwX3K.jpg<br>CNsAEaYUYAARuaj.jpg<br>CKBXgmOWcAAtc4u.jpg</p>
<h4>9. Extract all the files that were transferred from PC to server.</h4>
<p>The files transmitted from the PC to the server are in this directory.</p>

<h3>set2.pcap</h3>
<h4>10. How many packets are there in this set?</h4>
<p>There are 77982 packets in this set.</p>
<h4>11. How many plaintext username-password pairs are there in this packet set? Please count any anonymous or generic accounts.</h4>
<p>There is one plaintext username-password pair in this packet set.</p>
<h4>12. Briefly describe how you found the username-password pairs.</h4>
<p>I used ettercap to print the contents of the pcap file and piped to grep, searching for familiar strings indicating credentials. The full command I used is:<br>ettercap -T -r set2.pcap | grep -E "[pP][aA][sS][sS]([wW][oO][rR][dD])?[: ]|[pP][wW][dD][: ]|[lL][oO][gG][iI][nN][: ]|[lL][gG][nN][: ]|[uU][sS][eE][rR][: ]|[uU][sS][rR][: ]"</p>
<h4>13. For each of the plaintext username-password pairs that you found, identify the protocol used, server IP, the corresponding domain name, and port number.</h4>
<p>For the username, password combination (user: larry@radsot.com, pass: Z3lenzmej), the protocol used was IMAP, the server IP was 87.120.13.118, the domain name for that server is neterra.net, and the port number for IMAP is 143.</p>
<h4>14. Of all the plaintext username-password pairs that you found, how many of them are legitimate? That is, the username-password was valid, access successfully granted? Please do not count any anonymous or generic accounts.</h4>
<p>The username-password combiation (user: larry@radsot.com, pass: Z3lenzmej) was accepted by the server ("OK LOGIN Ok.").</p>

<h3>set3.pcap</h3>
<h4>15. How many plaintext username-password pairs are the in this packet set? Please count any anonymous or generic accounts.</h4>
