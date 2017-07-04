tl;dr: [Secure SSL cert config for Nginx (grade A-rated on GlobalSign SSL cert checker)](https://gist.github.com/neilstuartcraig/7822514)

**UPDATE 8th July 2014: I have amended my config slightly to use [OWASP recommended ciphers](https://www.owasp.org/index.php/Transport_Layer_Protection_Cheat_Sheet#Rule_-_Only_Support_Strong_Cryptographic_Ciphers) and some updates to Debian core libs mean this configuration now produces an A+ result.**

It's been quite some time since I wrote a blog post and there are a fair number of reasons for this, not least is that I have migrated this blog from [Wordpress](http://www.wordpress.org) to [Ghost](https://ghost.org/) which took up a lot of time as it also included a platform migration to [AWS](http://aws.amazon.com). During this migration, i decided that my architecture would include [SPDY](http://www.chromium.org/spdy) so I needed an SSL certificate and thus needed to configure said certificate.

As a bit of pertinent background information, my web server runs [Nginx](http://nginx.org) which proxies requests to Ghost, a [NodeJS](http://nodejs.org) app. My Nginx install comes from the awesome [dotdeb](http://dotdeb.org) so SPDY support is really easy, as easy as installing the SSL cert and adding the "SPDY" keyword to the listen directive in Nginx:

```
server {
	listen 443 ssl spdy;
  	server_name thedotproduct.org;
    ...
}
```

So that's great, we're up an running with SPDY, tidy! 

After getting SPDY working, I wanted to check my SSL cert was working for people other than just me on my browser in my little world so I ran a test using [Globalsign's SSL cert checker](https://sslcheck.globalsign.com/en_GB) which was really helpful. I then started reading as SSL ciphers and so on are something I knew a little but not a lot about, I confess that I'm still not a hardcore expert but I have decent understanding of the basics now.

Immediately from the test results, it was clear that some basic remedial actions were needed such as disabling SSLv2 and SSLv3 since no decent, half-modern browser needs them and they contain known weaknesses. Choosing the best combination of SSL ciphers was less simple but after a number of hours reading, tweaking and testing, I came up with the following configuration which achieves a grade A rating on the GlobalSign SSL cert checker:

<script src="https://gist.github.com/neilstuartcraig/7822514.js"></script>

Here are the test results:
![thedotproduct.org SSL cert test results](/posts/assets/images/tdp-ssl-july-2014.png)

The only compromise I am left with is being vulnerable to the [BEAST attack](http://en.wikipedia.org/wiki/Transport_Layer_Security#BEAST_attack). The choice I had in this regard was using an RC4 cipher which is fairly [widely believed to have been compromised by the NSA](http://www.theregister.co.uk/2013/09/06/nsa_cryptobreaking_bullrun_analysis/) or being vulnerable to the BEAST attack and since [the BEAST attack has now been mitigated in most modern browsers](https://www.imperialviolet.org/2012/01/15/beastfollowup.html) and is by all counts extremely difficult to execute, I see that as the less nasty option. I could simply disable the older TLS versions but too many browsers [require](http://en.wikipedia.org/wiki/Transport_Layer_Security#Web_browsers) them (either because they don't support newer cryptogaphic protocols or they're for some ridiculous reason disabled by default - IE, Firefox, I'm looking at you!) so we'll have to live with them for the moment at least. Here's a rundown on what is configured (with wording according to test results):

* [SSL 2.0](http://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_2.0) Disabled
* [SSL 3.0](http://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_3.0) Disabled
* [TLS 1.0](http://en.wikipedia.org/wiki/Transport_Layer_Security#TLS_1.0) Enabled
* [TLS 1.1](http://en.wikipedia.org/wiki/Transport_Layer_Security#TLS_1.1) Enabled
* [TLS 1.2](http://en.wikipedia.org/wiki/Transport_Layer_Security#TLS_1.2) Enabled
* [Weak ciphersuites](https://www.owasp.org/index.php/Testing_for_Weak_SSL/TSL_Ciphers,_Insufficient_Transport_Layer_Protection_(OWASP-EN-002)) disabled
* Certificates configured correctly
* [Perfect forward secrecy](http://en.wikipedia.org/wiki/Forward_secrecy)
* [Secure renegotiation](http://tools.ietf.org/search/rfc5746) configured
* [Session resumption](http://tools.ietf.org/html/rfc5077) configured
* [OCSP Stapling](http://en.wikipedia.org/wiki/OCSP_stapling)
* [PCI Compliance](http://en.wikipedia.org/wiki/Payment_Card_Industry_Data_Security_Standard)
* [FIPS Compliance](http://en.wikipedia.org/wiki/Federal_Information_Processing_Standards)

If you're going for FIPS or PCI DSS compliance or a similar accreditation, you should note that this will almost certainly mandate how you handle keys and other sensitive info/files as well as the way in which your SSL certificate usage is configured.

I am pretty confident that this is the best (which is an opinion and/or requirement-specific of course) SSL config possible right now, at least under Nginx but if you know different, please let me know via a comment below.

Hopefully this'll help if you need to set up an SSL cert under Nginx. Many thanks to those who wrote the references I used, mainly these:

* [https://raymii.org/s/tutorials/Pass_the_SSL_Labs_Test_on_NGINX_(Mitigate_the_CRIME_and_BEAST_attack_-_Disable_SSLv2_-_Enable_PFS).html]()
* [https://coderwall.com/p/ebl2qa]()
* [http://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/]()
* [http://code-bear.com/bearlog/2013/06/26/nginx-ssl-config-for-forward-secrecy/]()
* [http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_session_timeout]()
* [http://unmitigatedrisk.com/?p=354]()
* [http://www.westphahl.net/blog/2012/01/03/setting-up-https-with-nginx-and-startssl/]()

Cheers!