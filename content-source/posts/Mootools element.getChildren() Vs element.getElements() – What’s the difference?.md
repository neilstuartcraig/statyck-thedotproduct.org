<p>I have been writing a fair bit of Javascript recently and came up with a couple of situations where I needed to use Mootools JavaScript element.getChildren() instead of element.getElements() so I thought i&#8217;d share a little info which may or may not be obvious about these two very useful Mootools methods.</p>
<p>At first glance of the <a href="http://mootools.net/docs/core/Element/Element" target="_blank">Mootools documentation</a>, element.getChildren() and element.getElements() look pretty much identical, but what&#8217;s not obvious (to me at least) is the fundamental difference between the two methods:</p>
<p><strong>element.getElements() recurses through all child elements from it&#8217;s initial starting point whereas element.getChildren() does not, it returns only direct children of the element from which it begins.</strong></p>
<p>For example, if you had a fragment of HTML like this:</p>
<pre>&lt;ul id="list_one"&gt;
    &lt;li&gt;Item one&lt;/li&gt;
    &lt;li&gt;Item two&lt;/li&gt;
    &lt;li&gt;
        &lt;ul&gt;
             &lt;li&gt;sub item one&lt;/li&gt;
             &lt;li&gt; sub item two&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>
<p>you could then have some JavaScript like this to perform an operation on it:</p>
<pre>window.addEvent("domready", function()
{
    var list=$("list_one");
    list.getChildren("li").each(function(el, i)
    {
         // do something
    });
});
</pre>
<p>and that would affect only the 3 immediate children &lt;li&gt; of the outer &lt;ul&gt; and would not affect the &#8220;sub items&#8221; &lt;li&gt; in the inner &lt;ul&gt;.</p>
<p><strong>NOTE: both element.getChildren() and element.getElements() return an array of DOM elements, hence looping around the result using each().</strong></p>
<p>Conversely, if you wanted to affect all &lt;li&gt; within the outer &lt;ul&gt; you could do something like this:</p>
<pre>window.addEvent("domready", function()
{
    var list=$("list_one");
    list.getElements("li").each(function(el, i)
    {
         // do something
    });
});
</pre>
<p>There&#8217;s tons more element methods such as element.getFirst() which retrieves the first matching child element.</p>
<p>If you include selectors in your Mootools download, you can add css-style selectors to your methods e.g.:</p>
<pre>window.addEvent("domready", function()
{
    var list=$("list_one");
    list.getElements("li.some_class").each(function(el, i)
    {
         // do something
    });
});
</pre>
<p>which would affect only &lt;li&gt; which have a CSS class of &#8220;some_class&#8221;.</p>
<p>Hope that makes sense and saves someone some time!</p>