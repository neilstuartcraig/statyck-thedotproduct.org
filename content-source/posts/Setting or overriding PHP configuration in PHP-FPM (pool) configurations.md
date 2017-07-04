 <p>I&#8217;ve recently been working on some very different parallel projects on a development server i have and came across a situation where i needed to have one vhost/site for the LDAP GUI <a href="https://oss.gonicus.de/labs/gosa/" target="_blank">GOsa </a>on the server with the (soon to be deprecated) PHP feature <a href="http://php.net/manual/en/security.magicquotes.php" target="_blank">magic_quotes_gpc</a> enabled whilst the rest of my vhosts/sites (quite rightly) mandate that magIc_quotes_gpc is turned off.</p>
<p>My server runs what is now my default PHP stack:</p>
<ul>
<li>Debian 6 (squeeze)</li>
<li><a href="http://nginx.org/" target="_blank">Nginx</a> (currently 1.2)</li>
<li><a href="http://php-fpm.org/" target="_blank">PHP-FPM</a></li>
<li>PHP 5.3.X</li>
</ul>
<p>Nothing too unusual there for the slightly more experimental/progressive amongst us who have ditched our old pal Apache HTTPD</p>
<p>Try as i might though, i simply couldn&#8217;t override the PHP magic_quotes_gpc config variable/setting through the usual override (an entry in the Nginx vhost of fastcgi_param php_value &#8220;magic_quotes_gpc=On&#8221;; or anything even close to that). So i thought about it a bit and remembered that an often overlooked feature in PHP-FPM is &#8220;pools&#8221;&#8230;</p>
<p>PHP-FPM pools essentially allow you to more strictly isolate your hosts (or groups of vhosts), providing a simple way to use very different configurations on the same server. So a quick dive into a very nice <a href="http://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/" target="_blank">Nginx/PHP-FPM configuration/optimisation reference </a>reminded me how to configure pools. I simply created a new pool for GOsa and added the following to the pool config file:</p>
<p>php_admin_value[magic_quotes_gpc]=On</p>
<p>A restart of PHP-FPM and Nginx later and everything worked!</p>
<p>So my actions, step-by-step were:</p>
<ul>
<li><strong>In PHP-FPM config:</strong>
<ul>
<li>Duplicate the default &#8220;www&#8221; pool config file (www.conf located in /etc/php5/fpm/pool.d/ on my system) saving it as gosa.conf and changing:
<ul>
<li>the [www] label at the top of the file to [gosa]</li>
<li>The port in the &#8220;listen&#8221; directive to 9001 (from the deault of 9000)</li>
<li>Then adding a new line: <strong>php_admin_value[magic_quotes_gpc]=On</strong></li>
</ul>
</li>
</ul>
</li>
<li><strong>In Nginx config:</strong>
<ul>
<li>Duplicated the default/original PHP &#8220;<a href="http://wiki.nginx.org/HttpUpstreamModule" target="_blank">upstream</a>&#8220;, calling the new version &#8220;phpgosa&#8221; and amending it to send PHP requests via port 9001 (server 127.0.0.1:9001;) rather than the default port 9000</li>
<li>Amended my gosa vhost file to use the upstream &#8220;phpgosa&#8221;</li>
</ul>
</li>
<li>Restart PHP-FPM (on my system: /etc/init.d/php-fpm restart) and Nginx (on my system: /etc/init.d/nginx restart) and you&#8217;re done!</li>
</ul>
<p>That&#8217;s it, all very simple.</p>
<p>I realise i can override magic_quote_gpc in PHP code but since GOsa is a 3rd party app, i don&#8217;t want to mess with the source code as i&#8217;ll update it some time and forget then the whole thing will break.</p>
<p>Hope that helps</p>