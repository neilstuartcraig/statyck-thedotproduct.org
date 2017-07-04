<p>It&#8217;s been quite some time since I&#8217;ve had the pleasure of using <a href="http://www.google.co.uk/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;ved=0CIIBEBYwAA&amp;url=http%3A%2F%2Fbackuppc.sourceforge.net%2F&amp;ei=w33HT-uvNOa_0QXw__S4Dw&amp;usg=AFQjCNESc0ufIyua_UO6lA26b0PJGRU7Zw" target="_blank">BackupPC</a>, a delightfully simple to use yet very effective, free, open source, cross-platform backup system. My test rig was sorely overdue some proper backups&#8230;So I decided to install BackupPC on a central server to back up the others (which are all <a href="http://www.debian.org/" target="_blank">Debian </a>or <a href="http://www.ubuntu.com/" target="_blank">Ubuntu</a>).</p>
<p>I decided to use the excellent apt system to install, packages just make life easier so that means i kept it simple and put up with the ageing Apache web server (usually I opt for <a href="http://nginx.org/" target="_blank">Nginx</a>)&#8230;Here&#8217;s my brief tutorial by way of notes:</p>
<p>Install backuppc from the shell on the Debian/Ubuntu computer/server you want to be your backup server (assuming you&#8217;re root, if not, add &#8220;sudo &#8221; before this):</p>
<pre>apt-get update
apt-get install backuppc</pre>
<p>This will install BackupPC and its dependencies (including apache) whilst also creating a unix user (&#8220;backuppc&#8221;) for the application to run under. Note that if you already have a web server or something else bound to port 80, Apache will fail to start &#8211; in this case please see appendix A below.</p>
<p>Note, you&#8217;ll be able to access the web-based admin interface of BackupPC via http://SERVER-IP/backuppc as standard. If you missed the password the installer gave you, see appendix B.</p>
<p>We&#8217;re not far off being done, the next step involves allowing your backup server to authenticate with each server/computer it will back up. I am making the huge assumption that these are *nix systems too, in which case proceed exactly as follows in this order (note that this does make several large assumptions but if you&#8217;re on a modern Debian or Ubuntu system, these should be valid):</p>
<p>On your backup server, su to the backuppc user:</p>
<pre>su backuppc</pre>
<p>Now (still as user backuppc) create an RSA keypair:</p>
<pre>ssh-keygen -t rsa</pre>
<p>Accept the default installation location (the home directory of the backuppc user) and leave the passphrase blank.</p>
<p>Next, you need to copy the public RSA key (id_rsa.pub) to the authorized_keys file for the root user of each of the servers/computers you want to back up (there are several ways to achieve this):</p>
<pre>[COPY THE PUBLIC KEY]
ssh root@SERVER-IP
[ENTER PASSWORD]
cd
nano authorized_keys
[PASTE IN THE KEY AND SAVE THE FILE]</pre>
<p>Now, since we&#8217;re on the server which is to be backed up, check that rsync is installed:</p>
<pre>apt-get update
apt-get install rsync</pre>
<p>Finally, check you can now SSH from the backup server to the server you want to back up as user backuppc:</p>
<pre>su backuppc
ssh root@SERVER-~IP
[YOU WILL NEED TO ACCEPT THE ADDITION TO KNOWN_HOSTS THE FIRST TIME ONLY]</pre>
<p>You should not need to enter a password, if you do something is wrong and you should see the <a href="http://sourceforge.net/apps/mediawiki/backuppc/index.php?title=Main_Page" target="_blank">troubleshooting wiki page</a>. Make sure the permissions on your authorized_keys file are locked down to rw for root as owner only.</p>
<p>Ensure that you do SSH into each server/computer to backup</p>
<p>Simply repeat the above for each server/computer to backup the head over to your admin interface and configure&#8230;which is very simple &#8211; help links are integrated and there is plenty of <a href="http://backuppc.sourceforge.net/faq/BackupPC.html#step_9__cgi_interface" target="_blank">help on the admin gui</a> in the <a href="http://backuppc.sourceforge.net/faq/BackupPC.html" target="_blank">documentation</a>.</p>
<p>So that&#8217;s it&#8230;I hope that helped, it&#8217;s kind of tricky to explain but the above should help you avoid most of the pitfalls of installing BackupPC on Debian or Ubuntu which I have encountered.</p>
<p>Cheers!</p>
<p><strong>APPENDIX A</strong></p>
<p>If apache failed to start due to something else on your server being bound to port 80, just edit /etc/apache/ports.conf and change the NameVirtualHost and Listen ports &#8211; I have varnish running on my server so i changed it to port 9999 like so:</p>
<pre>NameVirtualHost *:<strong>9999</strong>
Listen <strong>9999</strong></pre>
<p>(I left the rest of that file as it was) You could use any free port on your system. If apache didn&#8217;t start, you can do so now:</p>
<pre>/etc/init.d/apache2 start</pre>
<p><strong>APPENDIX B</strong></p>
<p>If you missed the password the BackupPC installer have you for the admin interface, the username is by default backuppc and you can reset the password (a standard htpasswd file) like so:</p>
<pre>htpasswd /etc/backuppc/htpasswd backuppc</pre>