In my day job, we have traditionally used [Akamai](http://www.akamai.com) as our content delivery network (CDN) of choice. For quite some time, Akamai was arguably the only true enterprise-ready CDN and our clients demand a high level of service, hence Akamai is/was a good fit in most cases. The CDN world has definitely changed over recent months and years with many new players entering the market and many existing players strengthening their offerings - [Amazon Web Services](http://aws.amazon.com/) (AWS) [Cloudfront](http://aws.amazon.com/cloudfront/) is a popular CDN amongst these newer/improved offerings and has caught my attention, not least due to it's pricing.  

AWS in general has been very disruptive in the market, offering very low cost services which are perhaps not always as comprehensive as competitors  but fit the requirements for a large number of people/companies/projects. AWS Cloudfront is very much of this ilk, currently, although expanding it is quite basic as a CDN (it lacks many features offered by companies such as Akamai e.g. DDoS insurance, WAF and so on) but is as much as an order of magnitude cheaper than major competitors so if simple object caching is what you need (HTTP or HTTPS) then Cloudfront may well work for you.

Akamai still has by far the largest CDN in terms of PoP's (Point of Presence - i.e. CDN nodes) however the newer CDN vendors typically state that they operate under a different model, going less for sheer scale and more for strategically placed so-called super-PoP's (i.e. less PoP's but used more effectively).

As I've been using AWS more and more, I wanted to have a simple but reasonably meaningful (to me at least) comparison with it and Akamai so I set up something to achieve this which is as follows.

## Test configuration  
This test is semi-scientific, i.e. it is simple but relatively logical and is as fair as I could reasonably make it (since I'm running it in my spare time). The test is not supported or endorsed by either Akamai or AWS, nor is it influenced by either company or by my employer.    

Notes are:  

* Tested against a single page (the home page) on our company website (relatively low traffic - low thousands of page views across the site per day) via 2 DNS records (both DNS records have the same TTL at 600 seconds and are served from the same authority):
	* www. which is cname'd to an Akamai edge hostname
    * cf. which is cname'd to an AWS Cloudfront config hostname
* Both CDN configs hit the same origin servers (a pair of web servers load balanced by a hardware load balancer)  
* Public/live traffic is using the Akamai (www.) hostname, only Pingdom traffic is on the Cloudfront (cf.) hostname
* From looking at IP information and physical locations, it seems that Pingdom do not host (at least not entirely) on AWS - important as this could have artifically skewed results
* Our website is hosted in London, UK in our own private virtualised environment which is very well capacity-managed and has low contention and high-performance components  
* Cloudfront config uses all edge locations
* As similar as possible Akamai and Cloudfront configs:
	* HTTP only traffic
    * Honour HTTP headers from origin with minimum cache times imposed
    * All items on the page are cached (the base HTML, CSS, JS and so on) by the CDN
* Response times tested via Pingdom, one test per DNS record (as shown above) at a 1 minute interval from February 9th 2014 to today (18th March 2014) using default settings/locations (many locations, grouped into US and Europe)
* All cacheable objects have at least 1 day maxAge and thus the cache will remain warm from Pingdom traffic alone (since tests run every minute from many locations)
* Test duration is Feb 9th 2014 to Mar 18th 2014

The results I observed under these conditions are as follows:

<table>
	<thead>
    	<tr>
        	<th>
            	Metric
            </th>
            <th>
            	All locations
            </th>
            <th>
            	Europe (all)
            </th>
            <th>
            	U.S. (all)
            </th>
        </tr>
    </thead>
    <tbody>
    	<tr>
        	<td colspan=4 class=subtitle>
            	<b>Akamai</b>
            </td>
        </tr>
    	<tr>
        	<td>
            	Overall average
            </td>
            <td>
            	772ms
            </td>
            <td>
            	572ms
            </td>
            <td>
            	976ms
            </td>
        </tr>
        <tr>
        	<td>
            	Fastest average
            </td>
            <td>
            	425ms
            </td>
            <td>
            	293ms
            </td>
            <td>
            	591ms
            </td>
        </tr>
        <tr>
        	<td>
            	Slowest average
            </td>
            <td>
            	894ms
            </td>
            <td>
            	702ms
            </td>
            <td>
            	1130ms
            </td>
        </tr>
        <tr>
        	<td colspan=4 class=subtitle>
            	<b>Cloudfront</b>
            </td>
        </tr>
    	<tr>
        	<td>
            	Overall average
            </td>
            <td>
            	772ms
            </td>
            <td>
            	462ms
            </td>
            <td>
            	982ms
            </td>
        </tr>
        <tr>
        	<td>
            	Fastest average
            </td>
            <td>
            	592ms
            </td>
            <td>
            	285ms
            </td>
            <td>
            	778ms
            </td>
        </tr>
        <tr>
        	<td>
            	Slowest average
            </td>
            <td>
            	986ms
            </td>
            <td>
            	872ms
            </td>
            <td>
            	1125ms
            </td>
        </tr>
        <tr>
        	<td colspan=4 class=subtitle>
            	<b>% Cloudfront is faster than Akamai</b>
            </td>
        </tr>
    	<tr>
        	<td>
            	Overall average
            </td>
            <td>
            	0%
            </td>
            <td>
            	19.2%
            </td>
            <td>
            	-0.6%
            </td>
        </tr>
        <tr>
        	<td>
            	Fastest average
            </td>
            <td>
            	-39.3%
            </td>
            <td>
            	2.7%
            </td>
            <td>
            	-31.6%
            </td>
        </tr>
        <tr>
        	<td>
            	Slowest average
            </td>
            <td>
            	-10.3%
            </td>
            <td>
            	-24.2%
            </td>
            <td>
            	0.4%
            </td>
        </tr>
    </tbody>
</table>

  
  
Here's a graph of these results:
![Akamai versus Cloudfront test results](/posts/assets/images/cf_vs_ak.png)


Notes:  

* negative values of % indicate that Cloudfront is *slower* than Akamai  
* averages shown are calculated on a per-day basis i.e. slowest average is the average of the slowest response time on each day  
* the pingdom accounts used are the free accounts and thus stats are as-provided, with no modifications (i.e. I did not remove the top/bottom extreme values etc.)

## Conclusion
In terms of overall average and across all locations, Cloudfront and Akamai are identical under my test conditions. Cloudfront is however a little faster on overall average in Europe.  

The fastest/slowest times are somewhat more variable than the overall, this may be a result of Akamai having a larger and potentialy more stable (under heavy load) network of PoP's or perhaps the Akamai architecture is more able of coping with heavy traffic (overall internet traffic). Akamai has an edge -> midgress -> origin architecture and to my knowledge (please correct me if I'm wrong via comments) AWS is more direct, edge -> origin. Alternatively, it may be something I haven't thought of.

## Further thoughts
It would be nice to have been able to test from more locations around the world and for more than one origin. This would perhaps better point to the reasons behind the differences

## Caveats
This is a semi-scientific but very small-scale and relatively limited test/comparison but I haven't seen another similar so wanted to put it out there in case it's helpful. Read into it what you will but you should do thorough work of your own before selecting a CDN.

Edit 1: Added duration of test info
Edit 2: Added Pingdom network location info, corrected typos, clarified network routes to origin, added TTL info for cached objects, added Cloudfront config info
Edit 3: Amended incorrect "Metric" column title order (fastest & slowest the wronf way around) - thanks [@CyrilDuprat](https://twitter.com/cyrilduprat)!