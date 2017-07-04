<p>If, like me you&#8217;ve got an IPhone, you&#8217;ll probably have noticed that when you bookmark a web page in Safari, you get three options:</p>
<ul>
<li>Add Bookmark</li>
<li>Add to Home Screen</li>
<li>Mail link to this page</li>
</ul>
<p>The first and last options are pretty simple and self-explanatory but the second is a bit more interesting. &#8220;Add to Home Screen&#8221; will create an icon on your IPhone home screen alongside the icons for your IPhone apps which when clicked will take you straight to the bookmarked web page. Brilliant eh?</p>
<p>Even better, you can create and specify a custom icon for your web page in much the same way as you would with a traditional favicon &#8211; but it&#8217;s even simpler! Here&#8217;s how:</p>
<ol>
<li>Create your icon as a square image. You can create it at any size though the native size is 57&#215;57 pixels and you can use any web-compatible format e.g. JPEG, PNG, GIF (in RGB mode rather than CMYK). The IPhone will take care of rounding the corners and adding the glossy overlay for you.</li>
<li>Upload your icon to somewhere on the web</li>
<li>Add the following line in the head tag of your web page (X)HTML:<br/>
<code>&lt;link rel="apple-touch-icon" href="/path/to/icon.jpg"/&gt;</code></li>
</ol>
<p>That&#8217;s it!</p>
<p>Here&#8217;s an example (bottom-right icon) from the BBC IPlayer (<a href="http://www.bbc.co.uk/mobile/iplayer" target="_blank">http://www.bbc.co.uk/mobile/iplayer</a> &#8211; visit this on an IPhone to see the code in action):</p>
<p>
![](/posts/assets/images/iphone_icon_example.jpg)
</p>
<p>I found all this info through various experiments involving setting up icons, taking screen grabs from my IPhone and transferring them back to my Mac then analysing in Photoshop.</p>
<p>You may find website stating that you have to use a 57&#215;57 pixel PNG file or other such nonsense but trust me, I tried a lot of combinations and any size (though you should make sure your image is at least 57 x 57 pixels otherwise it&#8217;ll get scaled up and therefore will be poor quality) and format (as long as it&#8217;s web compatible &#8211; that is a jpg, gif or png image in RGB format) will do.</p>
<p>Hope that helps you&#8230;</p>