I'll prefix this short article with a statement that this is not in any way a criticism of NGINX, just an observation which I have not found documented elsewhere so I wanted to write it down in case it helps anyone else.

Recently, in my day job, i've been working on a project which involves usage of [NGINX](http://nginx.org/) as a caching reverse proxy - a task at which NGINX excels. Today, I was validating some of the detail on how NGINX handles HTTP headers when caching proxied HTTP content (in this case, mainly HTML web pages) - in our case we're doing this via [proxy_cache](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache). One of the functions I wanted to validate NGINX for was correct (as per [RFC 7234](https://tools.ietf.org/html/rfc7234)) handling of the `vary` HTTP response header. 

If you're reading this, likely you know exaclty what the `vary` HTTP header does but for anyone else, the `vary` HTTP header provides cache servers/services one or more HTTP headers whose values should be used in addition to the cache server/services defined cache key. The vary HTTP header thus effectively instructs the cache server/service to keep multiple copies of the content which may be compressed and uncompressed or perhaps geographically varying content.

Test 1 was no problem, the origin for which NGINX was proxying returned HTTP headers which indicated that the the proxied content should be cached:

```
...  
Cache-Control: max-age:30, stale-while-revalidate
Vary: Accept-Encoding
...
```
All pretty typical stuff, no surpise that NGINX handles that just fine and does indeed separately cache (for example) a gzip'd and an uncompressed version of the content once requests are made for each.

Test 2 was a different page which issued a larger set of headers on which to vary, including some of our custom response headers:

```
...
Cache-Control: max-age:30, stale-while-revalidate
Vary: Accept-Encoding,Custom-Header-One,Custom-Header-Two,Custom-Header-Three
...
```

So nothing too unusual, admittedly thought some of the HTTP headers are custom, but this time, NGINX did not cache the content, despite the above HTTP headers indicating it should. Begin investigation...

So, a colleague and I ran through to try to find the issue. At first, we had nothing to go on other than NGINX not caching but after a quick comparison of test case 1 with test case 2, the only significant change was the `vary` HTTP header. I'd also seen a few fixes recently stated on the [NGINX change log](http://nginx.org/en/CHANGES) which centered around lengths of fields/values. So we went with that as a starting point and fiddled the `vary` HTTP header value, adjusting its length. Lo and behold, we quickly found that NGINX would cache the content correctly if the `vary` HTTP header value was 42 or fewer characters in length. A quick search through the [NGINX source code mirror](https://github.com/nginx/nginx) on [github](https://github.com/) for "42" showed the reason on the [very first result](https://github.com/nginx/nginx/search?utf8=%E2%9C%93&q=42):

```c
#define NGX_HTTP_CACHE_VARY_LEN      42
```

This is in [ngx\_http\_cache.h](https://github.com/nginx/nginx/blob/6612579e5a1459b05960a31bbbcfe4cd5afc319a/src/http/ngx_http_cache.h). A search for "NGX\_HTTP\_CACHE\_VARY\_LEN"  shows a little more of the logic concerned in [ngx\_http\_file\_cache.c](https://github.com/nginx/nginx/blob/6612579e5a1459b05960a31bbbcfe4cd5afc319a/src/http/ngx_http_file_cache.c):

```c
...
if (h->vary_len > NGX_HTTP_CACHE_VARY_LEN) {
        ngx_log_error(NGX_LOG_CRIT, r->connection->log, 0,
                      "cache file \"%s\" has incorrect vary length",
                      c->file.name.data);
        return NGX_DECLINED;
    }
...
```

In effect, this logic means that if the `vary` HTTP header value is > 42 characters in length, it will be treated as if it had a value of "*", i.e. the content will not be cached. The violation if logged as per the above code snippet, it'll end up in the error log (assuming you have this enabled) at `critical` level.

The current NGINX `vary` HTTP header handling is described [here](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache_valid) but makes no mention of the maximum length of the header value.

As i noted earlier, this is not a criticism but I don't believe it's in any NGINX documentation so could perhaps catch people out.

HTTP headers do not have a standardised maximum lengths but most software which handles them imposes a limit - usually several (often 8 or 16) KBytes - so 42 Bytes seems a little low (maybe it's a dev joke on the [meaning of life](http://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker%27s_Guide_to_the_Galaxy#Answer_to_the_Ultimate_Question_of_Life.2C_the_Universe.2C_and_Everything_.2842.29)? :-)). I'd personally like to see this limit raised, perhaps to 256 characters so I'll do that as a patch on our build.

I'd also like to thank [Maxim Dounin](https://twitter.com/mdounin) for his quick response on the issue and confirmation that increasing the `vary` HTTP header limit will likely have very little impact on performance.