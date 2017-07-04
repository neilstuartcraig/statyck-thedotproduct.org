<p><strong>Web-fonts</strong>, for those who don&#8217;t know, are a method of <strong>using a custom font in your web page</strong>(s). Unlike the more traditional method of specifying the font using the CSS &#8220;font-family&#8221; (or the shorthand &#8220;font&#8221;) which relies on the user having the relevant font installed on their computer, <strong>web-fonts</strong> allow the developer to use fonts which reside on the internet.</p>
<p>Microsoft actually introduced a limited version of <strong>web-fonts</strong> as far back as Internet Explorer 4 but it&#8217;s taken until now to gain a (almost) consensus on how <strong>web-fonts</strong> should be implemented. Web-fonts are now part of the <strong>CSS3</strong> specifcation in the font module and as such have now been implemented at least partially in several major, current browsers such as Firefox 3.5+, Opera 10, Safari 3.1+, Google Chrome 4+ and probably some more (see the <a href="http://www.webfonts.info/wiki/index.php?title=%40font-face_browser_support" target="_blank">web-fonts browser compatibility table on webfonts.info</a> for more details) so it&#8217;s high time we learned how to use them!</p>
<p>The method is very simple indeed. In your Stylesheet, you must first define the web-font(s) you wish to use, with one <strong>@font-face</strong> class per font file e.g.:</p>
<pre>@font-face
{
    font-family:"Caviar dreams";
    src:url('CaviarDreams.ttf');
}
</pre>
<p>So we are declaring the name/label by which we want to reference the font first using &#8220;font-family&#8221;, then defining the font file itself with &#8220;src&#8221; which can be a relative or absolute URL.</p>
<p>Then, to actually use the font to style an element in your page(s), you&#8217;d use exactly the same CSS rules as for any other font e.g.:</p>
<pre>div.webfont_div
{
    font-family:"Caviar dreams";
}
</pre>
<p>Note that the quotes around the font-family value simply allow you to have one or more spaces in the font-family name/label.</p>
<p>I have put together <a href="/experiments/font-face/" target="_blank">a simple example of web-fonts</a> which should help to explain a little further. Please view the source files for details.</p>