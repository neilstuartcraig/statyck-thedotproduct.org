I have just migrated from an RDS instance to a local [percona](http://www.percona.com) instance on a Debian server and encountered an odd issue...

After installation, which all appeared normal at first, I tried to start percona and there was no init script (which would usually live at /etc/init.d/mysql). Disaster!

Some googling ensued but to no avail. Then I decided to check out some likely locations and sure enough found the file I needed at /usr/share/mysql/mysql.server. Maybe this will help someone else out of the same situation!

P.S. Percona has several pre-built my.cnf files (my-huge.cnf, my-medium.cnf etc.) which are also in /usr/share/mysql but a newer development is their [configuration wizard](https://tools.percona.com/wizard) which is well worth a try!