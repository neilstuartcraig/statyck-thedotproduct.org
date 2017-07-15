# Privacy 

This is my personal website, it's not a business or a marketing exercise so I have no real need to know anything about you. I also respect your privacy and your right to stay anonymous if you choose. 
For this reason, I've chosen to do what I reasonably can to a avoid exposing your personal details and data. The measures I have (or in some cases haven't) include:

* Not using Cookies anywhere on the site
* Not storing anything in your Browser localStorage
* Not logging anything personally identifiable in server error or access logs (* more on access logging below)
* Not using a CDN (many "free" CDN accounts are effectively paid for via stats collection - some more reputably than others)
* Ensuring your web page requests and responses are encrypted via well-configured HTTPS
* Implementing additional standards-based security, for example:
    * HTTP Strict Transport Security (HSTS)
    * Framing prevention (via X-Frame-Options) to help avoid e.g. click-jacking
    * Cross-Site Scripting (XSS) prevention (via X-XSS-Protection)
    * Not leaking that you visited this website to sites I link to (via Referrer-Policy: same-origin) - only I receive "referer"

## Access logging
I will probably make use of server-side access logging (logging web page requests to a file on the server) from time to time. These logs will never include any data which 
would easily allow someone who stole the log file, such as your IP address, Cookies (this site doesn't use Cookies) etc. Access logs will rarely, if ever, be shipped to 
another service online, most likely just temporarily to my personal computer.  

In short, I will honour your right to privacy as if it were my own.