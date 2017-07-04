<p>If like me, you have to transfer websites between servers from time to time and you use an Apple Mac, you&#8217;ll probably need to know how to flush your DNS on Mac OSX (flushing is the term used for removing of all records to force an update).</p>
<p>For all versions of OSX, the simplest way to flush your DNS cache is to start &#8220;Terminal&#8221; which you can find in &#8220;Applications&#8221; &gt; &#8220;Utilities&#8221; &gt; &#8220;Terminal&#8221;. Once you&#8217;ve done that type (or copy + paste) into the Terminal:</p>
<p><strong>OSX 10.5 (Leopard) &amp; 10.6 (Snow Leopard):</strong></p>
<pre><tt>dscacheutil -flushcache
</tt></pre>
<p><strong>OSX 10.4 (Tiger) and previous:</strong></p>
<p>Type (or copy + paste) into the Terminal:</p>
<pre>lookupd -<tt>flushcache
</tt></pre>
<p>Then hit the Enter key.</p>
<p>You may also find that you need to restart your browser &#8211; you shouldn&#8217;t really need to but I find I sometimes do.</p>
<p>If you use Firefox, you might want to consider adding the extension &#8220;<a href="https://addons.mozilla.org/en-US/firefox/addon/590/" target="_blank">ShowIP</a>&#8221; which is a very simple indicator that show the IP address(es) of the website you&#8217;re currently looking at in the Firefox status bar (at the bottom):<br />

![](/posts/assets/images/Screen_shot_2010_06_08_at_10_22_53.png)
</p>
<p>You can also use the Mac OSX Terminal (or a *nix terminal/console) to check DNS records using <a href="http://www.manpagez.com/man/1/dig/" target="_blank">dig</a>, for example to check the IP address(es) for www.thedotproduct.org you could type into the Terminal:</p>
<pre>dig a www.thedotproduct.org
</pre>
<p>Which says &#8220;dig for a DNS &#8216;A&#8217; record for &#8216;www.thedotproduct.org&#8217;&#8221;.</p>
<p>The output will look something like this:</p>
<pre>Neil-Craigs-Mac-mini:~ neilcraig$ dig a www.thedotproduct.org

; &lt;&lt;&gt;&gt; DiG 9.6.0-APPLE-P2 &lt;&lt;&gt;&gt; a www.thedotproduct.org
;; global options: +cmd
;; Got answer:
;; -&gt;&gt;HEADER&lt;&lt;- opcode: QUERY, status: NOERROR, id: 40181
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;www.thedotproduct.org.        IN    A

;; ANSWER SECTION:
www.thedotproduct.org.    7200    IN    A    80.68.94.84

;; Query time: 178 msec
;; SERVER: 192.168.1.254#53(192.168.1.254)
;; WHEN: Tue Jun  8 10:27:27 2010
;; MSG SIZE  rcvd: 55
</pre>
<p>You&#8217;ll see that the IP address is given as 80.68.94.84.</p>
<p>Other types of DNS records you can dig for include MX e.g. &#8220;dig mx thedotproduct.org&#8221; which shows which Email server(s) will be used for the domain thedotproduct.org.</p>
<p>You can read more about the use of dig <a href="http://www.manpagez.com/man/1/dig/" target="_blank">here</a>.</p>