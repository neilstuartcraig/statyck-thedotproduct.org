<p>I&#8217;ve recently begun to try to make a bit of time to start experimenting with some newer aspects of web-development &#8211; mainly the forthcoming HTML 5), it&#8217;s all about staying ahead of the game!</p>
<p>I&#8217;m going to document what I learn, partly for selfish reasons &#8211; I learn much better if I document the information and partly because I hope it might be helpful to someone. The advent of HTML 5 offers one of the most anticipated new features in a fair few years which I am hoping should be generally usable before too long, <a href="http://www.w3.org/TR/offline-webapps/" target="_blank">HTML 5 Offline Application Caching</a> which uses Javascript localStorage/sessionStorage and online/offline status events/indicators.</p>
<p>Javascript localStorage allows you to store any data you wish in a key/value pair &#8211; data stored persists even after the browser is closed. Javascript sessionStorage works in the same way except that it expires when the browser is closed, much in the same way a PHP session does.</p>
<p>Right now (at the time of writing) the browsers in popular use which support Javascript localStorage and sessionStorage are Firefox 3.5+, Safari 4+, Internet Explorer 8 and Google Chrome 4+ (Wikipedia has a <a href="http://en.wikipedia.org/wiki/Comparison_of_layout_engines_(HTML_5)#APIs" target="_blank">compatibility table of Browsers which support Javascript local/session storage</a> will hopefully be maintained &#8211; &#8220;Web Storage&#8221; is the row you&#8217;ll be looking for in that table).</p>
<p>So, on to the syntax for localStorage/sessionStorage, it&#8217;s really, really simple:</p>
<p><strong>Javascript localStorage</strong>:<br/>
Setter: window.localStorage.setItem(KEY, VALUE)<br/>
Getter: window.localStorage.getItem(KEY)<br/>
Remove: window.localStorage.removeItem(KEY)</p>
<p><strong>Javascript sessionStorage</strong>:<br/>
Setter: window.sessionStorage.setItem(KEY, VALUE)<br/>
Getter: window.sessionStorage.getItem(KEY)<br/>
Remove: window.sessionStorage.removeItem(KEY)</p>
<p>UPDATE: In working on my next HTML5 experiment into Geo Location, I found a <a href="http://hacks.mozilla.org/2009/06/localstorage/" target="_self">handy article on mozilla.org</a> which also states that you can use simpler, dot-syntax notation e.g.:</p>
<p><strong>Javascript localStorage</strong>:<br/>
Setter: window.localStorage.KEY=VALUE<br/>
Getter: window.localStorage.KEY<br/>
Remove: delete window.localStorage.KEY</p>
<p><strong>Javascript sessionStorage</strong>:<br/>
Setter: window.sessionStorage.KEY=VALUE<br/>
Getter: window.sessionStorage.KEY<br/>
Remove: delete window.sessionStorage.KEY</p>
<p>I&#8217;ve just done a simple test and it works fine for me on FireFox 3.6.3 on OSX.</p>
<p>It is worth noting that window.localStorage stores only strings&#8230;and explicitly strings so you must use a cast such as window.localStorage.KEY.toInt() if you want to use the stored value as an integer.<br/>
</p>
<p>I have put together a really, really simple, reasonably <a href="/experiments/offline_storage/" target="_blank">complete example of Javascript localStorage</a> (please don&#8217;t mock, it was put together in minimal time!) which is really uninspiring but demonstrates:</p>
<ul>
<li><strong>JavaScript localStorage</strong> (which is identical in usage to <strong>JavaScript sessionStorage</strong>) &#8211; my example above is reasonably complete</li>
<li>On-line/Off-line detection</li>
<li>Manifest files</li>
</ul>
<p>The example above simply allows you to save/load/remove whatever data you care to type into the textarea using Javascript localStorage. It also detects your on-line/off-line status and contains a <strong>Manifest</strong> which is simply a document instructing your browser which files it must cache in order to allow you to use the &#8220;application&#8221; when you are off-line.</p>
<p>The on-line/off-line detection is as simple as checking the Javascript property <strong>navigator.onLine</strong> which is a boolean (true/false).<br/>
It&#8217;s worth mentioning at this point that (in supporting browsers) according to the specification, you can add Javascript event listeners to detect changes in on-line/off-line status in native Javascript as follows:</p>
<pre>window.addEventListener("online", function()
{
  do_something();
}, true);
</pre>
<p>and</p>
<pre>window.addEventListener("offline", function()
{
  do_something();
}, true);</pre>
<p>It seems that MooTools does not yet support the online/offline events as MooTools addEvent() syntax doesn&#8217;t work (at the time of writing).</p>
<p>The <strong>Manifest</strong> file must be sent from your web-server with a specific <strong>mime-type: text/cache-manifest</strong> and should contain &#8220;<strong>CACHE MANIFEST</strong>&#8221; (without the quotes) on the first line followed by the paths and filenames of files you wish to cache, one file per line (I am guessing you can use either relative or absolute paths &#8211; though I have only tried relative paths). Probably the simplest way to achieve this without messing around with your web-server settings is to create a server-side script which will output the correct header and Manifest data for you, I just made a PHP script like this:</p>
<pre>&lt;?
header("content-type:text/cache-manifest");
echo "CACHE MANIFEST
index.html
cnet.220.js
ols.js
ols.css";
?&gt;
</pre>
<p>Sure enough, after adding the <strong>Manifest file</strong>, Firefox (3.6 OSX) displayed a grey bar at the top of the HTML window asking my permission for the web page to store documents for offline use (image cropped in width):</p>
<p>
![](/posts/assets/images/Picture_1.png)
</p>
<p>If there are files which you want to make sure definitely do not get cached for offline use, you can specify them after a heading line &#8220;NETWORK:&#8221;, so the Manifest file would look like this:</p>
<pre>CACHE MANIFEST
index.html
cnet.220.js
ols.js
ols.css
NETWORK:
do-not-cache.php</pre>
<p>So, that&#8217;s the end of experiment 1 in HTML 5&#8230;more will follow soon as time permits.</p>