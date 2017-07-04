<p>I look after a number of web servers on a day to day basis and over the last few years I have developed an on-line system to allow easy admin of those web servers. The stumbling block in us having fully web-driven administration of our servers has always been <a href="http://httpd.apache.org/" target="_blank">Apache</a> <a href="http://en.wikipedia.org/wiki/Virtual_hosting" target="_blank">Vhost</a> config because, as far as I know, there is no freely available way of drawing Apache Vhost config directly from a Database such as <a href="http://www.mysql.com/" target="_blank">MySQL</a>. The only solutions I know of involve dynamically rewriting the Apache config file(s) which has some serious potential pitfalls if you have a bug in your script which writes the config file as Apache may die, not good!</p>
<p>For a couple of years now, I have been keeping an eye on the <a href="http://www.lighttpd.net/" target="_blank">Lighttpd</a> project which is a very fast and efficient alternative to Apache and is used to <a href="http://redmine.lighttpd.net/wiki/lighttpd/PoweredByLighttpd" target="_blank">serve some major websites</a> such as Youtube. Just recently I decided to have a go at installing lighttpd on a spare <a href="http://en.wikipedia.org/wiki/Virtual_machine" target="_blank">Virtual Machine</a> we have and whilst doing that I found something amazing, you can install a Lighttpd module to allow Vhost configuration directly from Database! This is good news indeed&#8230;</p>
<p>Lighttpd works in a modular fashion and there seem to be 2 modules used to provide a MySQL interface for Vhost configuration, <a href="http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs:ModSqlVhostCore" target="_blank">mod_sql_vhost_core</a> and <a href="http://redmine.lighttpd.net/wiki/1/Docs:ModMySQLVhost" target="_blank">mod_mysql_vhost</a>. From looking at the Lighttpd documentation, it appears that mod_sql_vhost_core provides the base functionality (and is included by mod_mysql_vhost) and mod_mysql_vhost is a MySQL specific implementation though I may be wrong about that.</p>
<p>For my purposes, I installed lighttpd (version 1.4.19) and lighttpd-mod-mysql-vhost using <a href="http://wiki.debian.org/Apt" target="_blank">apt</a> (which in my opinion puts <a href="http://www.debian.org/" target="_blank">Debian</a> leagues ahead of any other Linux distribution) on our Debian Lenny Virtual Machine:</p>
<pre>apt-get install lighttpd lighttpd-mod-mysql-vhost</pre>
<p>Then you simply need to edit your lighttpd config file (which for Debian Lenny is stored in /etc/lighttpd/lighttpd.conf) &#8211; adding the new module to your existing modules (remember not to put a comma after the last module):</p>
<pre>server.modules              = (
 "mod_access",
 "mod_alias",
 "mod_accesslog",
 "mod_compress",<strong>
 "mod_mysql_vhost"</strong>
)</pre>
<p>then add the MySQL server access information and query to your lighttpd.conf file (I added mine right below the above module includes) as per the example in the <a href="http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs:ModMySQLVhost" target="_blank">Lighttpd mod_mysql_vhost documentation</a>:</p>
<pre>mysql-vhost.db             = "vhost_db"
mysql-vhost.user           = "db_user"
mysql-vhost.pass           = "db_password"
mysql-vhost.sock           = "/var/run/mysqld/mysqld.sock"
mysql-vhost.sql            = "SELECT docroot FROM domains WHERE domain='?' limit 1;"
mysql-vhost.hostname       = "localhost"
mysql-vhost.port           = 3306
</pre>
<p>I am presuming that if you are using a table whose column name for the document root is not &#8220;docroot&#8221;, you should alias the column e.g:</p>
<pre>mysql-vhost.sql            = "SELECT document_root as docroot FROM domains WHERE domain='?' limit 1;"</pre>
<p>If you have a lot of domains, make sure you add a &#8220;limit 1&#8243; at the very end of your query, otherwise your database server will keep searching through every vhost record even after it has found a match!<br />
if you are likely to have more than one possible match you may want to add an &#8220;order by&#8221; to ensure you get the correct vhost config.</p>
<p>If no match is found, Lighttpd will use the default static vhost config from your lighttpd.conf file which by default has a document root of /var/www. You could use this as a fallback to perhaps display a notice such as &#8220;Sorry, no Website found&#8221; with a relevant <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html" target="_blank">HTTP response code</a> (probably a 404).</p>
<p>You can use MySQL-style <a href="http://en.wikipedia.org/wiki/Wildcard_character" target="_blank">wildcards</a> for your domain name in your database e.g. &#8220;%.example.com&#8221; would match any sub-domain of &#8220;example.com&#8221;. If you want to use wildcards, you&#8217;ll need to amend your query to use &#8220;like&#8221; rather than &#8220;=&#8221; e.g:</p>
<pre>SELECT vhost_document_root as docroot FROM vhost WHERE '?' like vhost_domain_name and vhost_active=1 and vhost_date_deleted=0 limit 1;

</pre>
<p>I&#8217;ll post back here when i&#8217;ve had a moment to create a query which selects an exact match first, then a wildcard if no exact match is found as I believe this will be the setup most people will want in practice.</p>
<p><strong>Be careful if you enter the wildcard as e.g. &#8220;%example.com&#8221; as this <em>would</em> match &#8220;www.example.com&#8221; and &#8220;secure.example.com&#8221; but would <em>also</em> match &#8220;thisisanexample.com&#8221;.</strong></p>
<p>Once you have set up your lighttpd.conf file and your database, you need to restart Lighttpd so that it picks up your new config:</p>
<pre>/etc/init.d/lighttpd restart
</pre>
<p>If you get a failure upon restart as I did when I first tried this:</p>
<pre>/etc/lighttpd# /etc/init.d/lighttpd restart
Stopping web server: lighttpd.
Starting web server: lighttpd2010-06-10 17:16:07: (plugin.c.165) dlopen() failed for: /usr/lib/lighttpd/mod_sql_vhost_core.so /usr/lib/lighttpd/mod_sql_vhost_core.so: cannot open shared object file: No such file or directory
2010-06-10 17:16:07: (server.c.621) loading plugins finally failed
 failed!
</pre>
<p>then check the Lighttpd error file which (on Debian Lenny) is in /var/log/lighttpd/error.log &#8211; I had a typo in my query.</p>
<p>I am not sure what the performance of Lighttd with the MySQL Vhost interface is like under heavy load, for instance I don&#8217;t know whether it caches the query result or relies on MySQL for that but i&#8217;ll try to find some information and post it back here.</p>
<p>Lighttpd also supports a great many features which will be well known to Apache web servers admins such as mod_rewrite (albeit with slightly different syntax) and even flash FLV streaming! I am seriously thinking about switching lock-stock to Lighttpd from Apache from just this simple experiment. I also like very much the config file syntax, it&#8217;s more like dot-notation in modern programming languages.</p>
<p>Happy configging!</p>
<p>Cheers</p>
<p>Main Lighttpd wiki documentation is here: <a href="http://redmine.lighttpd.net/projects/lighttpd/wiki" target="_blank">http://redmine.lighttpd.net/projects/lighttpd/wiki</a></p>
<p>For reference, my complete lighttpd conf file (which I have made very few changes from the standard file, MySQL access details removed) is:</p>
<pre># Debian lighttpd configuration file
#

############ Options you really have to take care of ####################

## modules to load
# mod_access, mod_accesslog and mod_alias are loaded by default
# all other module should only be loaded if neccesary
# - saves some time
# - saves memory

server.modules              = (
 "mod_access",
 "mod_alias",
 "mod_accesslog",
 "mod_compress",
 "mod_mysql_vhost",
#           "mod_rewrite",
#           "mod_redirect",
#           "mod_evhost",
#           "mod_usertrack",
#           "mod_rrdtool",
#           "mod_webdav",
#           "mod_expire",
#           "mod_flv_streaming",
#           "mod_evasive"
)

# mysql vhost config
mysql-vhost.db             = "**********"
mysql-vhost.user           = "**********"
mysql-vhost.pass           = "**********"
mysql-vhost.sock           = "/var/run/mysqld/mysqld.sock"
mysql-vhost.sql            = "SELECT vhost_document_root as docroot FROM vhost WHERE vhost_domain_name='?' and vhost_active=1 and vhost_date_deleted=0 limit 1;"
mysql-vhost.hostname       = "**********"
mysql-vhost.port           = 3306

## a static document-root, for virtual-hosting take look at the
## server.virtual-* options
server.document-root       = "/var/www/lightttpd"

## where to upload files to, purged daily.
server.upload-dirs = ( "/var/cache/lighttpd/uploads" )

## where to send error-messages to
server.errorlog            = "/var/log/lighttpd/error.log"

## files to check for if .../ is requested
index-file.names           = ( "index.php", "index.html",
 "index.htm", "default.htm" )

## Use the "Content-Type" extended attribute to obtain mime type if possible
# mimetype.use-xattr = "enable"

#### accesslog module
accesslog.filename         = "/var/log/lighttpd/access.log"

## deny access the file-extensions
#
# ~    is for backupfiles from vi, emacs, joe, ...
# .inc is often used for code includes which should in general not be part
#      of the document-root
url.access-deny            = ( "~", ".inc" )

##
# which extensions should not be handle via static-file transfer
#
# .php, .pl, .fcgi are most often handled by mod_fastcgi or mod_cgi
static-file.exclude-extensions = ( ".php", ".pl", ".fcgi" )

######### Options that are good to be but not neccesary to be changed #######

## Use ipv6 only if available.
include_shell "/usr/share/lighttpd/use-ipv6.pl"

## bind to port (default: 80)
# server.port               = 81

## bind to localhost only (default: all interfaces)
## server.bind                = "localhost"

## error-handler for status 404
#server.error-handler-404  = "/error-handler.html"
#server.error-handler-404  = "/error-handler.php"

## to help the rc.scripts
server.pid-file            = "/var/run/lighttpd.pid"

##
## Format: &lt;errorfile-prefix&gt;&lt;status&gt;.html
## -&gt; ..../status-404.html for 'File not found'
#server.errorfile-prefix    = "/var/www/"

## virtual directory listings
dir-listing.encoding        = "utf-8"
server.dir-listing          = "enable"

## send unhandled HTTP-header headers to error-log
#debug.dump-unknown-headers  = "enable"

### only root can use these options
#
# chroot() to directory (default: no chroot() )
#server.chroot            = "/"

## change uid to &lt;uid&gt; (default: don't care)
server.username            = "www-data"

## change uid to &lt;uid&gt; (default: don't care)
server.groupname           = "www-data"

#### compress module
compress.cache-dir          = "/var/cache/lighttpd/compress/"
compress.filetype           = ("text/plain", "text/html", "application/x-javascript", "text/css")

#### url handling modules (rewrite, redirect, access)
# url.rewrite                 = ( "^/$"             =&gt; "/server-status" )
# url.redirect                = ( "^/wishlist/(.+)" =&gt; "http://www.123.org/$1" )

#
# define a pattern for the host url finding
# %% =&gt; % sign
# %0 =&gt; domain name + tld
# %1 =&gt; tld
# %2 =&gt; domain name without tld
# %3 =&gt; subdomain 1 name
# %4 =&gt; subdomain 2 name
#
# evhost.path-pattern = "/home/storage/dev/www/%3/htdocs/"

#### expire module
# expire.url                  = ( "/buggy/" =&gt; "access 2 hours", "/asdhas/" =&gt; "access plus 1 seconds 2 minutes")

#### rrdtool
# rrdtool.binary = "/usr/bin/rrdtool"
# rrdtool.db-name = "/var/www/lighttpd.rrd"

#### variable usage:
## variable name without "." is auto prefixed by "var." and becomes "var.bar"
#bar = 1
#var.mystring = "foo"

## integer add
#bar += 1
## string concat, with integer cast as string, result: "www.foo1.com"
#server.name = "www." + mystring + var.bar + ".com"
## array merge
#index-file.names = (foo + ".php") + index-file.names
#index-file.names += (foo + ".php")

#### external configuration files
## mimetype mapping
include_shell "/usr/share/lighttpd/create-mime.assign.pl"

## load enabled configuration files,
## read /etc/lighttpd/conf-available/README first
include_shell "/usr/share/lighttpd/include-conf-enabled.pl"

#### handle Debian Policy Manual, Section 11.5. urls
## by default allow them only from localhost
## (This must come last due to #445459)
## Note: =~ "127.0.0.1" works with ipv6 enabled, whereas == "127.0.0.1" doesn't
$HTTP["remoteip"] =~ "127.0.0.1" {
 alias.url += (
 "/doc/" =&gt; "/usr/share/doc/",
 "/images/" =&gt; "/usr/share/images/"
 )
 $HTTP["url"] =~ "^/doc/|^/images/" {
 dir-listing.activate = "enable"
 }
}
</pre>
<p>Which works with my vhost config table:</p>
<pre>CREATE TABLE `vhost`
(
 `vhost_id` int(20) unsigned NOT NULL auto_increment,
 `vhost_active` enum('1','0') NOT NULL default '1',
 `vhost_domain_name` varchar(255) NOT NULL,
 `vhost_document_root` varchar(255) NOT NULL,
 `vhost_date_added` datetime NOT NULL,
 `vhost_date_deleted` datetime NOT NULL default '0000-00-00 00:00:00',
 PRIMARY KEY  (`vhost_id`),
 UNIQUE KEY `uniq` (`vhost_domain_name`,`vhost_date_deleted`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
</pre>
<p>NOTE: I always prefix database table column names with the name of the table to which they belong and use a datetime field to indicate the deleted status of a record.</p>