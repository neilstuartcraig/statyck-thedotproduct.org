<p>Adobe Flash is still very popular despite the massive improvements in Javascript animation over recent years. However, some important devices such as the Apple IPhone lack the capability to display Flash movies. Because of this and due to my immutable desire to produce W3C compliant HTML, I&#8217;ve recently been thinking a little about the method I use to embed Adobe Flash movies in a web page so i wanted to share my thoughts.</p>
<p>There are a number of popular methods for embedding Adobe Flash in web pages. Most people will be familiar with what I&#8217;d personally consider the worst method, that is used by Dreamweaver which looks something like this:</p>
<pre> &lt;OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0" WIDTH="550" HEIGHT="400" id="myMovieName"&gt;
&lt;PARAM NAME=movie VALUE="myFlashMovie.swf"&gt;
&lt;PARAM NAME=quality VALUE=high&gt;
&lt;PARAM NAME=bgcolor VALUE=#FFFFFF&gt;
&lt;EMBED href="/support/flash/ts/documents/myFlashMovie.swf" quality=high bgcolor=#FFFFFF WIDTH="550" HEIGHT="400" NAME="myMovieName" ALIGN="" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"&gt;&lt;/EMBED&gt;
&lt;/OBJECT&gt;
</pre>
<p>(Example taken from <a href="http://kb2.adobe.com/cps/415/tn_4150.html" target="_blank">http://kb2.adobe.com/cps/415/tn_4150.html</a>)</p>
<p>However, if you use this &#8220;Dreamweaver-style&#8221; markup, your page will not pass the W3C HTML validator. This is due to the proprietary &#8220;embed&#8221; tag which is used.</p>
<p>There are a number of improved methods available, I will discuss the two which I have the most personal experience of and have settled on over the years, the <a href="http://www.alistapart.com/articles/flashsatay" target="_blank">Flash Satay</a> method which uses pure HTML markup and <a href="http://code.google.com/p/swfobject/" target="_blank">SWFObject</a> which uses Javascript.</p>
<p><strong>Method 1: Flash Satay<br/>
</strong>As previously mentioned, the Flash Satay method uses pure HTML markup which looks something like this:</p>
<pre>&lt;object type="application/x-shockwave-flash" data="c.swf?path=movie.swf" width="400" height="300"&gt;
&lt;param name="movie" value="c.swf?path=movie.swf" /&gt;
&lt;img src="noflash.gif" width="200" height="100" alt="" /&gt;
&lt;/object&gt;
</pre>
<p>You&#8217;ll no doubt immediately notice that the Flash Satay method doesn&#8217;t use an embed tag and is therefore W3C compliant.</p>
<p>Pros</p>
<ul>
<li>W3C Compliant HTML</li>
<li>Very simple</li>
<li>Offers non-Flash-capable alternative content (in the example this is demonstrated by the img tag but you can replace this with any valid HTML you wish)</li>
<li>Does not require any script libraries of any kind (and therefore no extra HTTP requests)</li>
<li>Does not require Javascript to be enabled in order to embed the Flash movie</li>
</ul>
<p>Cons</p>
<ul>
<li>No inherent Flash version checking</li>
</ul>
<p>I have personally tested the Flash Satay method on my IPhone and it works beautifully, the alternative content is displayed which means that IPhone and other non-Flash-capable browsers don&#8217;t display a nasty question mark filled box where content should be.</p>
<p><strong>Method 2: SWFObject<br/>
</strong>SWFObject is (now) a Google Code<strong> </strong>project which aims to provide a relatively simple method of using Javascript to embed a Flash movie in a web page. The basic principle is that SWFObject will replace an element on your web page with a Flash movie object. Using SWFObject is a 2-stage affair, initially you&#8217;d set out your HTML markup for example:</p>
<pre>&lt;div class="my_div" id="flash_movie_1"&gt;&lt;/div&gt;
</pre>
<p>Then, having included the SWFObject library Javascript file, you&#8217;d tell SWFObject the necessary details to allow it to replace your element with your Flash movie, for example:</p>
<pre>&lt;script type="text/javascript"&gt;
    swfobject.embedSWF("flash_movie.swf", "flash_movie_1", "800", "600", "10.0.0");
&lt;/script&gt;
</pre>
<p>Pros</p>
<ul>
<li>W3C Compliant HTML</li>
<li>Offers non-Flash-capable alternative content</li>
<li>Allows Flash player version checking</li>
</ul>
<p>Cons</p>
<ul>
<li>More complex than Flash Satay (though pretty simple all the same)</li>
<li>Requires the inclusion of a Javascript library which may require an additional HTTP request and will certainly increase bandwidth consumed</li>
<li>Requires Javascript to be enabled in order to embed the Flash movie</li>
</ul>
<p><strong>Conclusion:</strong><br/>
Flash Satay offers a slightly simpler, quicker method which fulfils the needs of most developers in most cases and as such, it&#8217;s what I personally use unless I need to perform Flash player version checking. If however, the Flash movie requires a specific version of Flashplayer, SWFObject is an excellent method.</p>