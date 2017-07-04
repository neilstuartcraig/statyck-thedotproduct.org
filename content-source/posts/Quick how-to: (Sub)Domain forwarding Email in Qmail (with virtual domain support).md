<p>As part of an ongoing Server move, today I needed to find a way to divert/forward all incoming Email from one Server (Server A) to another Server (Server B). Server A is running <a href="http://www.qmail.org/" target="_blank">Qmail</a> (on <a href="http://www.debian.org" target="_blank">Debian</a> etch) with virtual domains as part of a Plesk 8 install (alongside <a href="http://www.courier-mta.org/" target="_blank">Courier</a>). Server B is running my preferred setup of <a href="http://www.postfix.org/" target="_blank">Postfix</a> and <a href="http://www.dovecot.org/" target="_blank">Dovecot</a>.</p>
<p>After a bit of searching, I found a good article describing &#8220;<a href="http://articles.techrepublic.com.com/5100-10878_11-5033532.html" target="_blank">forwarding Email to another host</a>&#8221; using Qmail. I tried, as the article recommends setting up a Qmail config file (which didn&#8217;t exist on my server):</p>
<pre><em>/var/qmail/control/smtproutes</em></pre>
<p>Containing a Qmail Email domain forwarding rule e.g.:</p>
<pre>sourcedomain.com:destinationdomain.com
</pre>
<p>Unfortunately after restarting Qmail there was no change.</p>
<p>So I then thought a little further and realised that as part of Plesk 8, Qmail was being run with virtual domain support (i.e. Email accounts are stored in a Database rather than as system accounts/files) and spotted a Qmail config file:</p>
<pre>/var/qmail/control/virtualdomains
</pre>
<p>This config file contained the name of the domain I was trying to forward followed by a colon and a number, I assumed it was likely that the number was some sort of ID. So, I tried removing the line containing the domain I was trying to forward, restarted Qmail and bingo! Email forwarding was working in Qmail&#8230;Nice!</p>
<p>So, as a brief recap, the process is:</p>
<ol>
<li>As always: Back up all your current, working config files and if at all possible, do this using a test domain or sub-domain name so if you make mistakes you won&#8217;t be killing peoples email!</li>
<li>Set up your destination Email Server to receive Email for the relevant (sub)domain and Email account(s).</li>
<li>Ensure that the domain name you are trying to forward Email for is in the Qmail config file /var/qmail/control/rcpthosts (this ensures that Qmail will handle Email for the domain).</li>
<li>If necessary create the Qmail config file /var/qmail/control/smtproutes (this file did not exist on my server).</li>
<li>Add a forwarding rule to /var/qmail/control/smtproutes e.g.
<pre>sourcedomain.com:destinationdomain.com</pre>
<p>Note that you can use sub-domains if you want to e.g.</p>
<pre>mail.sourcedomain.com:newmail.destinationdomain.com</pre>
<p>or you can forward to an IP address e.g.</p>
<pre>sourcedomain.com:1.2.3.4</pre>
<p>If you want to forward all Email for all domains handled by your Qmail Server, you can use a wildcard config which means you omit the source domain name e.g.:</p>
<pre>:destinationdomain.com
</pre>
<p>or if you want to forward all Email being handled by your Qmail Server:</p>
<pre>:1.2.3.4</pre>
</li>
<li>If your Qmail installation is running virtual domains (as was the case with my Plesk 8 install), remove the line containing the domain you are trying to forward to which would look something like this:
<pre>yourdomain.com:52
</pre>
</li>
<li>Now you should be finished with config so you can restart Qmail:
<pre>/etc/init.d/qmail restart</pre>
</li>
<li>Check your destination Email Server which should now be receiving Email sent to Server A for the source domain.</li>
</ol>
<p>This worked fine for me using (source server) Debian Etch/Plesk 8/Qmail and destination server Debian Lenny/Postfix with virtual domains. Please be sensible though, no one likes losing Email so proceed with a little caution.</p>
<p>I assume that config file locations may vary on different installs so the path to config files may be different on your Qmail server.</p>
<p>Recommended references:<br/>
<a href="http://articles.techrepublic.com.com/5100-10878_11-5033532.html" target="_blank">TechRepublic&#8217;s article on Qmail by Vincent Danen<br/>
</a><a href="http://www.lifewithqmail.org/lwq.html" target="_blank">Life with Qmail</a> (including a very handy <a href="http://www.lifewithqmail.org/lwq.html#config-files" target="_blank">guide to Qmail config files</a>)<a href="http://www.lifewithqmail.org/lwq.html" target="_blank"><br/>
</a></p>
<p>I hope this article is useful and works for you too!</p>