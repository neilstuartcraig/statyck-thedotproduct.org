<p>I&#8217;ll say right now, I don&#8217;t currently have a solution to this problem but if you do, please let me know as I need a solution for a current project!</p>
<p>I was part-way through developing a website at work for a client yesterday when I got a notification from FireFox telling me version 3.6 was now available. So, being the sensible techie type I dropped what I was doing and upgraded, what could be the problem with that eh?</p>
<p>Well, the problem is that I immediately noticed that an Adobe Flash movie which was being embedded in the web page I was working on now had a mysterious 1 pixel spacing around it&#8230;not good. I assumed that FireFox 3.6 was perhaps adhering more strictly to some CSS standards or had slightly different inheritance so I duly set about amending all the usual properties, forcing border, outline, margin and even padding to 0 but no improvement. I then tried some slightly less usual attempts at fixes such as floating left, right or none, position relative and so on, again, no improvement. hmmm.</p>
<p>So, I turned to Google and found that a lot of people have found the same problem. Someone suggested &#8220;outline:none&#8221; should be added to the Flash movie object but this didn&#8217;t help me and didn&#8217;t seem to help most other people either.</p>
<p>There are various claims that the problem exists only on the Mac OSX version of FireFox 3.6 which from my limited testing at work appears to be the case but I couldn&#8217;t say for sure.</p>
<p>For reference, my test case consists a Flash Movie (which is actually a YouTube video) inserted using the <a title="Flash Satay: a W3 compliant Flash Movie insertion method" href="http://www.alistapart.com/articles/flashsatay" target="_blank">Flash Satay</a> method (which is therefore an object) sitting directly inside a div which is floated (left) with fluid height and fixed width:</p>
<pre>&lt;div&gt;
 &lt;object type="application/x-shockwave-flash" data="http://www.youtube.com/v/lBO3hBSga6k&amp;amp;hl=en_GB&amp;amp;fs=1&amp;amp;"&gt;
 &lt;param name="movie" value="http://www.youtube.com/v/lBO3hBSga6k&amp;amp;hl=en_GB&amp;amp;fs=1&amp;amp;" /&gt;

 &lt;img src="/images/listing_to_details_page/details_thumb/" alt="" /&gt;
 &lt;/object&gt;
 &lt;h3&gt;
 &lt;a href="/item/14"&gt;
 Now Showing: Kick Ass
 &lt;/a&gt;
 &lt;/h3&gt;
&lt;/div&gt;</pre>
<p>If anyone has any further experience or suggestions for fixes, i&#8217;d be very glad to hear them!</p>
<p><b>UPDATE:</b> I have added a bug report to Mozilla&#8217;s Bugzilla here: <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=553177" target="_blank">https://bugzilla.mozilla.org/show_bug.cgi?id=553177</a> please confirm the bug and add any further information you feel necessary if you are experiencing the same problem.</p>