As many others have in the past couple of days, I've spent a fair bit of time reading about, fixing and reassuring customers about the [heartbleed](http://heartbleed.com/) bug in openSSL and GNUTLS. The openSSL, GNUTLS and Debian package maintainers acted quickly to fix the issue and most people will simply be able to run:

```
apt-get update
apt-get upgrade
```

(remember to do this via `sudo` or as root)

On standard Debian wheezy installs, this will install a patched version of openSSL 1.0.1e so despite appearances, you should then be free of heartbleed. You can test this via a variety of ways but one of the simplest is published by security consultant Filippo Valsorda [here](http://filippo.io/Heartbleed/) (inlcuding source code so you can satisfy yourself that it's friendly).

When I came to update my Debian installs on AWS which I began building a week or two ago via the [official Debian AMI (ver. 7.4)](https://aws.amazon.com/marketplace/pp/B00AA27RK4), I found that there were no security apt sources in `/etc/apt/sources.list` and thus running apt update/upgrade didn't install the patched openSSL version. All I had was:

```
deb http://cloudfront.debian.net/debian wheezy main
deb-src http://cloudfront.debian.net/debian wheezy main
deb http://cloudfront.debian.net/debian wheezy-updates main
deb-src http://cloudfront.debian.net/debian wheezy-updates main
```

So, I had to add them in:

```
deb http://security.debian.org/ wheezy/updates main contrib non-free
deb-src http://security.debian.org/ wheezy/updates main contrib non-free
```

After that, the usual:
```
apt-get update
apt-get upgrade
```
Installed the patched openSSL version and thus heartbleed is no more, happy days. All simple stuff but might perhaps help someone out who's not so familiar with these things.