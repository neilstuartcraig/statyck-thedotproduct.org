<p>Like it or hate it, the Apple iPhone has ushered in the age of the “Smartphone” which in turn has delivered mobile web-browsing to the masses. The mobile browser, whilst now broadly quite capable (at least on leading platforms), has introduced a slightly different set of requirements in terms of design and development of Websites.</p>
<p>Many, many designers, developers and others have written articles on how to design and/or develop for the mobile browser. I am aiming to summarise what I have learnt from several sources alongside my experience an opinion in a (hopefully) relatively quick and simple way. So here goes, I&#8217;d recommend that you:</p>
<p><strong>Minimise as far as practicable the use of images</strong><br />
Images can be bad news on the mobile browser for 3 major reasons:</p>
<ol>
<li> Images generally quite large in terms of file size which slows down the page load – remember that mobile browser users are often on relatively slow connections</li>
<li> Each separate image requires a new HTTP connection from the mobile device to the web-server which has a latency, further slowing the page load</li>
<li> Mobile browsers are likely to have far lower (and a much wider range of) screen resolution than desktop browsers so sizing images so that they are suitable for all mobile devices can be very difficult</li>
</ol>
<p>If you insist on using images for your website design, use a <a href="//thedotproduct.org/css-sprites-example/" target="_blank">CSS sprite</a> to reduce download time<br />
<strong></strong></p>
<p><strong>Avoid reliance on JavaScript</strong><br />
If you are trying to create a website which is fully functional for all mobile browser users, you should definitely not rely on JavaScript support because many mobile browsers offer very poor JavaScript support. The poor JavaScript support is further compounded by “mini” browsers (such as Opera mini) which user server-side page rendering to reduce the amount of data transmission required, often resulting in poor or missing JavaScript support.<br />
This situation should resolve itself in the next 2 to 3 years as mobile browsers catch up with the current decent offerings from Apple, Google Android and the newer Blackberry devices. Thankfully (for web-developers) the lifetime of mobile devices is relatively low compared to desktop browsers (IE6, please lay down and die!)<br />
<strong></strong></p>
<p><strong>When designing your navigation menu, bear in mind that touch screen devices do not (in practice) have an “over” state</strong><br />
This has serious repercussions for “flyout”/”drop-down” menus as you must allow for the fact that touch screen devices do not have a cursor and thus cannot be “over” an element.<br />
Personally, I recommend that you simply replicate the “over” functionality (which often shows a sub-menu) when the element is “clicked”. I aim to write an example of this in the near future as I already have a commercially produced, working example.<br />
<strong></strong></p>
<p><strong>Minify your JavaScript &amp; CSS and optimise your website download speed</strong><br />
This results in both reduced data transmission and reduced number of HTTP connections which both reduce download times. Minification is simple and quick to do so there is no excuse!<br />
Layout should be appropriate to low resolution screens.<br />
See my article on <a href="//thedotproduct.org/how-to-reduce-web-page-download-time-in-4-simple-steps/" target="_blank">Website speed optimisation</a> for more information<br />
<strong></strong></p>
<p><strong>Most mobile devices have relatively low screen resolution which means that fixed-width pages designed for desktop will often require both horizontal and vertical scrolling, not good!</strong><br />
I would recommend that for your mobile website, you arrange your content in a single-column form. This will mean that your visitors only have to scroll in one direction, vertical, which is both natural and expected.<br />
You should also think about the physical size of any images used in your content to ensure that they do not cause horizontal scrolling<br />
<strong></strong></p>
<p><strong>Exploit mobile features!</strong><br />
Many modern mobile devices (such as the Apple iPhone and many Android devices) support a useful feature which desktop browsers do not (at least in a usable fashion, desktop browser currently claims I am in New York, USA when in fact I am in Oxfordshire in the UK) – Geolocation. <a href="//thedotproduct.org/example-of-navigator-geolocation-watchposition/" target="_blank">navigator.geolocation</a> can be useful in personalising your content to the visitor or offering convenience (e.g. directions to your physical address) so use it!<br />
Yes, I know I just said avoid reliance on JavaScript but you can (and most certainly should) design your website to use JavaScript purely for enhancement &#8211; this is often referred to as <a href="http://en.wikipedia.org/wiki/Unobtrusive_JavaScript" target="_blank">unobtrusive Javascript</a> and really is easy once you get into the flow of it.</p>
<p><!-- p { margin-bottom: 0.21cm; } -->References used for this articles:<br />
<a href="http://www.utexas.edu/web/guidelines/mobile.html" target="_blank">http://www.utexas.edu/web/guidelines/mobile.html</a><br />
<a href="http://www.appnovation.com/guidelines-adapting-designs-mobile-delivery" target="_blank">http://www.appnovation.com/guidelines-adapting-designs-mobile-delivery</a></p>
<p>W3C mobile browser feature test:<br />
<a href="http://www.w3.org/2008/06/mobile-test/" target="_blank">http://www.w3.org/2008/06/mobile-test/</a></p>