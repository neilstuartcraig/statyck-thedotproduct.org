I have a work project which, for a variety of reasons, has a custom nginx build. We were already using the nginx compile-time option `--with-openssl-opt=enabled-weak-ciphers` (because currently, we need to support `3DES`) but we also wanted to enable TLS1.3 so we needed to add another compile-time option `--with-openssl-opt=enable-tls1_3`. We found that adding these two discretetely seemingly resulted in only the last `--with-openssl-opt=` taking effect. After a bit of tinkering/googling, we found that combining the two `--with-openssl-opt' statements into one worked, like this:

```
--with-openssl-opt='enable-weak-ssl-ciphers enable-tls1_3' 
```

There is very little information on this on the web so I wanted to document it.