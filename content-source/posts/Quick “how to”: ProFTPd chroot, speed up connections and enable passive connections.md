<p>This post is a really quick &#8220;how to&#8221; &#8211; working with ProFTPd on Debian Linux and will explain how to <a href="http://en.wikipedia.org/wiki/Chroot" target="_blank">chroot</a> your FTP users, speed up connections and enable passive connections which can be very handy for those behind firewalls.</p>
<p>You&#8217;ll first need to locate your main ProFTPd config file which on my system is in /etc/proftpd/proftpd.conf then you can simply add/amend (or un-comment if the line(s) already exist) the following lines:</p>
<p><strong>chroot users to their home direcory:</strong></p>
<pre>DefaultRoot ~
</pre>
<p>This simply chroots the user to their home directory. ProFTPd by default uses Unix system users so this will be the system users home directory as you specified when you created the user using e.g. useradd -d /home/ftp_user my_ftp_user. You will need to ensure that the unix user has the necessary permissions on their home directory otherwise the connection will fail.</p>
<p><strong>Speed up initial connections to the ProFTPd server:</strong></p>
<pre>IdentLookups off
</pre>
<p>This disables ProFTPd&#8217;s default behaviour of looking up information about the machine which is connecting to it and thus markedly improves the initial connection speed to the ProFTPd server.</p>
<p><strong>Enable passive FTP connections:</strong></p>
<pre>PassivePorts 49152 65534
</pre>
<p>This allows ProFTPd to use a range of ports which are most often used for passive connections. You can change the port range if you need to, the first number is the lower limit, the second is the upper limit.</p>
<p>That&#8217;s it! I hope that&#8217;ll help someone out&#8230;</p>