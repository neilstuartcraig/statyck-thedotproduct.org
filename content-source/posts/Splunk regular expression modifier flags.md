I use [Splunk](http://www.splunk.com) on a daily basis at work and have created a lot of searches/reports/alerts etc. A fair number of these use regular expressions (the Splunk "rex" function) and today, I absolutely had to be able to use a modifier flag, something of a rarity for me in Splunk. 

As it turns out, the regex docs in the [Splunk rex documentation](http://docs.splunk.com/Documentation/Splunk/6.0.1/SearchReference/Rex) is not described (unless I somehow missed it) so I had to do a bit of digging to find out how to do this. The upshot is that it's very simple, for example:

```
rex field=hostname "(?Ui)^(?<year>\d{4})-(?<month>\d{1,2})-(?<date>\d{1,2}) (?<hours>\d{1,2}):(?<minutes>\d{1,2}):(?<seconds>\d{1,2}).*$"
```

The flags used in this example are in the leading `(?Ui)` before the caret (`^`):

* U - ungreedy match
* i - case-insensitive match

but you can use any [PCRE modifier flags](http://php.net/manual/en/reference.pcre.pattern.modifiers.php) you want, e.g. multiline would be `(?m)`.

Splunk uses PCRE regular expressions and there's a handy [PCRE regex cheatsheet](http://courses.cs.washington.edu/courses/cse190m/12sp/cheat-sheets/php-regex-cheat-sheet.pdf) I found and also a really good [regex tester](http://regex101.com/).