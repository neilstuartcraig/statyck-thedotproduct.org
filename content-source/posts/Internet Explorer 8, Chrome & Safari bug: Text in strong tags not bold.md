<p>This&#8217;ll be a quick post. There is a very annoying bug in Internet Explorer 8 (not IE6 or IE7), Chrome and Safari whereby text inside a &lt;strong&gt; tag is not displayed in bold!I haven&#8217;t yet figured out exactly under which conditions this bug manifests itself so if you know, please send me a message via comments &#8211; I am wondering if it&#8217;s incorrect inheritance of styling from the parent element.</p>
<p>Luckily, the solution is simple, you can add a global style to your stylesheet like this:</p>
<p>

<pre>
strong 
{
    font-weight:900 !important;
}
</pre>

<p>This will force all strong tags to display text in bold (unless you override the class with a more specific class with selectors), the &#8220;!important&#8221; helps to ensure the class above is not overridden.</p>
<p>The strangest thing about this is the combination of browsers which exhibit exactly the same bug&#8230;Microsoft have always said that IE8 uses an updated version of their &#8220;Trident&#8221; rendering engine which they used in previous rendering engines. Does Internet Explorer 8 use some or all of the Webkit rendering engine? If Microsoft did in fact use some or all of Webkit, this would certainly explain the above bug!</p>
<p>Firefox and other Gecko-based browsers do not exhibit this bug.</p>