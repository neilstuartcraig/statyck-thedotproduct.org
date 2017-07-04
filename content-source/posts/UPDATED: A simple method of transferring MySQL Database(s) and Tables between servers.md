<p>We&#8217;ve recently been working on a Web-Server migration for a regular client at work, part of which involved transferring the MySQL Databases (or strictly the schemas) for each of their websites from their old Web-Server to the shiny new replacement. In doing this, I rediscovered a really handy method which really simplifies transferring MySQL data between servers, it goes something like this:</p>
<pre>mysqldump -u SOURCE_MYSQL_USER -pSOURCE_MYSQL_PASSWORD --opt SOURCE_DATABASE_NAME | mysql --host=DESTINATION_SERVER_IP -u DESTINATION_MYSQL_USER -pDESTINATION_MYSQL_PASSWORD -C DESTINATION_DATABASE_NAME
</pre>
<p>To use the above command, you need to shell in to the &#8220;Source&#8221; Web-Server and run the above shell command (replacing the items in capitals with the relevant details). <strong><br/>
Make sure you don&#8217;t leave a space between the &#8220;-p&#8221; and the MySQL password otherwise it won&#8217;t work!</strong></p>
<p>All the normal <a href="http://linux.die.net/man/1/mysql" target="_blank">MySQL</a> and <a href="http://dev.mysql.com/doc/refman/5.1/en/mysqldump.html" target="_blank">MySQLdump</a> parameters should work.</p>
<p>The basic principal is this: Perform a MySQL Dump (which outputs the database data as importable SQL queries) and use the UNIX pipe to redirect that output SQL to another MySQL command which logs in to the destination MySQL server and imports the SQL which was output by MySQL Dump.</p>
<p>UPDATE:<br/>
If you only have shell access to shell in to the destination server, the following is what you need:</p>
<pre>mysqldump -u SOURCE_MYSQL_USER -pSOURCE_MYSQL_PASSWORD --host=SOURCE_SERVER_IP --opt SOURCE_DATABASE_NAME | mysql -u DESTINATION_MYSQL_USER -pDESTINATION_MYSQL_PASSWORD -C DESTINATION_DATABASE_NAME</pre>
<p>Things to bear in mind:</p>
<ul>
<li>This will only work on Linux/UNIX/BSD type servers &#8211; but we don&#8217;t use Windows toy servers anyway do we?</li>
<li>You will need to have mysqldump installed and available on the server you&#8217;re shelling in on</li>
<li>This is specific to MySQL</li>
<li>The MySQL users you use must have relevant permissions on each server (the &#8220;Source&#8221; user must have select permissions on the relevant database(s)/schema(s) and table(s), the &#8220;Destination&#8221; user must have create permissions). I usually use the root MySQL user or a user with equivalent permissions.</li>
<li>Make sure you don&#8217;t leave a space between the &#8220;-p&#8221; and the password</li>
<li>You&#8217;d be wise to ensure that the Database(s)/Schema(s)/Table(s) you are transferring do not exist on the &#8220;Destination&#8221; server as I believe by default they will be overwritten</li>
<li>As ever&#8230;MAKE A BACKUP OF SOURCE <strong>AND</strong> DESTINATION BEFORE YOU START!!! I cannot emphasise that enough! Be safe or prepare to be in a world of pain!</li>
<li>Also, I&#8217;d generally recommend that if you haven&#8217;t already, you should set a password for your MySQL root user &#8211; You can do this from the Linux/UNIX/BSD using:
<pre>mysqladmin -u root password NEW_ROOT_PASSWORD</pre>
</li>
</ul>
<p>That&#8217;s it&#8230;Hopefully that&#8217;ll be useful to somebody</p>