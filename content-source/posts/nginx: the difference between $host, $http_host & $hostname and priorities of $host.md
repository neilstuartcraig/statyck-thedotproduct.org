Nginx has a lot of [system variables](http://nginx.org/en/docs/http/ngx_http_core_module.html), this makes it really flexible which is great news. It also inevitably introduces some complexity, this is generally not a huge deal but in the odd place, the nginx docs are somewhat lacking which means you have to either google the issue you’re facing or investigate.

I hit this situation in my current project for something simple yet fundamental. What I needed to have some clarity on is the `$http` system variable. Let’s get one issue sorted straight off, the docs state that two similar nginx system variables [`$host`](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_host) and [`$hostname`](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_hostname) are:

>$host  
>in this order of precedence: host name from the request line, or host name from the “Host” request header field, or the server name matching a request
>
>$hostname  
>host name

So `$hostname` is a little scant on detail. It’s (at least on *nix) the FQDN machine hostname that you’d get by running (on the shell):

```
#hostname -f
```

Good. Let’s move on.

So, the more useful `$host` variable highest priority match looks to be 100% synonymous with the requested host in the HTTP request but actually, it’s a normalised version thereof. The normalisation of `$host` is to make it lowercase and to remove the port designation (e.g. :80).

It seems that there’s also another, undocumented and in fact higher priority for `$host` (I tested nginx 1.9.2, the current latest) which I found experimentally: if you’re using nginx with a proxy_pass directive to an nginx upstream, `$host` appears to take the name of the upstream as the highest priority. 

For example, I have a VM running on my laptop which is accessed from my host OS via port forwarding (:9080 on host to :80 on guest), the :80 listener on the guest is nginx which has a server block for test.example.com which does an HTTP proxy_pass to an upstream named “prx” which in this case simply listens on :9999 and serves local, static files. When I access the guest from my host OS (via a record in `/etc/hosts`: `127.0.0.1 test.example.com`) I see that `$host` contains “prx”.

```
add_header $host always;

# OUTPUT: prx
```

It’s unclear whether this is a result of my host to guest port forwarding or whether it’s a new priority which hash’t yet been documented or perhaps unintended functionality. Maybe in fact, I did something wrong. Comments are very welcome!