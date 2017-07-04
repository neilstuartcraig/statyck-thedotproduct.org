<p>In a continuation of my recent investigations into HTML5, I have been looking at HTML5 forms (sometimes referred to as Web Forms 2). HTML5 offers (currently) 13 completely new input types for forms (there are also some changes to several existing input elements), some of which look like they will be really useful:</p>
<ol>
<li><code>search (for search forms)<br/>
</code></li>
<li><code>number</code></li>
<li><code>range (a numeric range)</code></li>
<li><code>color</code></li>
<li><code>tel</code> (telephone number)</li>
<li><code>url</code></li>
<li><code>email</code></li>
<li><code>date (date only, no time)</code></li>
<li><code>month (Jan, Feb etc.)</code></li>
<li><code>week (week of year)</code></li>
<li><code>time</code> (timestamp)</li>
<li><code>datetime</code> (absolute date/times)</li>
<li><code>datetime-local</code> (local date/times)</li>
</ol>
<p>The problem is, at the time of writing virtually no Browsers support these new input types (the only one I have on my Mac which supports them is <a href="http://www.opera.com" target="_blank">Opera</a> 10.10) and it&#8217;s going to be quite some time before we can even begin to think about relying on Browser support. But, I can&#8217;t imagine it will be long until Mozilla/Firefox and Webkit/Safari/Chrome add support. That got me thinking, it&#8217;s a shame we can&#8217;t make some use of the new HTML5 input types now&#8230;</p>
<p>So, I did a little investigatory work and by borrowing some <a href="http://diveintohtml5.org/detect.html" target="_blank">excellent Javascript detection techniques</a> (a really good article, in fact so good I don&#8217;t think there&#8217;s any point in me covering the same ground so if you;&#8217;re interested in the detection methods, I&#8217;d refer you to that article), I came up with a script which uses unobtrusive Javascript and W3C compliant HTML to convert standard type=&#8221;text&#8221; inputs to the new HTML5 input types! Hopefully this will be of some use to someone &#8211; please note that JavaScript is not exactly my forte, so if anyone who is reading is willing and able to contribute improvements to JSH5F, they will be gladly received!</p>
<p>NOTE: Since Browsers should default to type=&#8221;text&#8221; for any non-specified or mal-specified inputs, you could in theory just start using the new input types but this script offers you the chance to use the new HTML5 input types with a little less risk of unruly behaviour from older browsers and a simpler, cross-browser method of styling the HTML5 input types differently. I have also just updated the jsh5f.js JavaScript file to allow appending of a string to the name attribute of the input element (using the &#8220;name_suffix&#8221; variable near the top of the jsh5f.js script) &#8211; this important distinction allows you to very simply distinguish between converted and non-converted inputs which can be important as the new HTML5 input elements often supply data in a different format to a standard text input (see my post describing <a href="//thedotproduct.org/html5-input-elements-and-their-data-formats/" target="_blank">HTML5 input types and their data formats</a> for more information).</p>
<h2><strong>JSH5F Examples</strong></h2>
<p>The script is really simple to use, you simply add a class of (by default) &#8220;h5f_input_NEW_INPUT_TYPE&#8221; to the class attribute of your input element. For example you could create the following markup which would convert a standard text input to an HTML5 date input:</p>
<pre>&lt;input type="text" class="textbox h5f_input_date" name="some_name" /&gt;
</pre>
<p>You can then ask the script to add further attributes to your converted HTML5 input element by adding (by default) &#8220;h5f{JSON_STYLE_STRING_OF_KEY/VALUE_PAIRS}&#8221; for example you could create the following markup which would convert a standard text input to an HTML5 range input:</p>
<pre>&lt;input type="text" class="textbox h5f_input_range h5f{min:-100,max:200,step:10}" name="some_name" /&gt;
</pre>
<p>Since your inputs will be transformed into HTML5 inputs on supporting browsers, you might want to style the converted HTML5 inputs a bit differently &#8211; You can do this by adding a CSS class which by default is prefixed with &#8220;h5f_add_&#8221; for example if you want to add the CSS class &#8220;html5_range&#8221; to a range input you would create the following markup:</p>
<pre>&lt;input type="text" class="textbox h5f_input_range h5f_add_html5_range h5f{min:-100,max:200,step:10}" name="some_name" /&gt;</pre>
<p>There is a <a href="/experiments/jsh5f/" target="_blank">simple working example of jsh5f.js here</a> (Please note: as far as I know, JSH5F will currently only work on Opera 10 as only Opera 10 supports the necessary HTML5 for input types)</p>
<p>Notes:</p>
<ul>
<li>The class &#8220;textbox&#8221; has nothing to do with the JSH5F script, it&#8217;s just there as an example to show that you can have one or more CSS classnames on your input element which can be simply used to style the element in the standard way. Also, you can change the prefix strings for the input element type (default: &#8220;input_&#8221;) and config JSON prefix (default: &#8220;h5f&#8221;) in the jsh5f.js Javascript file.</li>
<li> It is also worth mentioning that Browser support for attributes such as &#8220;required&#8221; and &#8220;placeholder&#8221; are event more scant than Browser support for the new HTML5 input element types &#8211; Wikipedia currently has a <a href="http://en.wikipedia.org/wiki/Comparison_of_layout_engines_%28HTML5%29" target="_blank">HTML5 features compatibility table</a> which I am hoping will be maintained.</li>
<li> Testing is a little tricky since only Opera appears to support any of the HTML5 input types but I have tested the script on FireFox (3.6 OSX), Safari (4 OSX) and Opera (10.10 OSX) and there are no reported errors &#8211; I will test on Internet Explorer Windows as soon as I can.</li>
<li>jsh5f.js uses only standard JavaScript, it does not require (nor should it interfere with) any JavaScript libraries (MooTools, JQuery, Prototype etc)</li>
</ul>
<h2><strong>Download</strong></h2>
<p>The code itself is hosted on Google code: <a href="http://code.google.com/p/jsh5f/" target="_blank">Google Code Project jsh5f</a></p>
<h2><strong>A Brief troubleshooting guide</strong></h2>
<ul>
<li>Ensure that when adding extra attributes (using the h5f prefix), you use a different type of quotes (single/double) from that enclosing your class definition e.g.:
<pre>&lt;input type="text" class="textbox input_range h5f{required="required"}" name="some_name" /&gt;
</pre>
<p>will fail because the class definition is ended by the first double-quote on the required=&#8221;required&#8221; &#8211; obvious when looking at HTML source code but not always obvious when looking at PHP or some other HTML generator code. You should instead user:</p>
<pre>&lt;input type="text" class='textbox input_range h5f{required="required"}' name="some_name" /&gt;</pre>
<p>Strictly speaking, JSON string values should only ever be enclosed by double quotes (reference: <a href="http://www.json.org/" target="_blank">http://www.json.org/</a>)</li>
<li>If you are using PHP to generate your extra attributes and you need a string with spaces in (e.g. for the placeholder attribute), you need to encode the string with rawurlencode() rather than urlencode() because the JavaScript function decodeURIComponent() only works with rawurlencode() strings.</li>
<li>You should have no spaces at all in your h5f{OPTIONS} string, otherwise it will look like more than one &#8220;class&#8221;. You should not need any spaces in your &#8220;keys&#8221; and any spaces in values should be urlencoded (with rawurlencode in PHP or similar)</li>
</ul>
<p>References and further reading:</p>
<ul>
<li>JavaScript detection of HTML5 features &#8211; Dive in to HTML5: <a href="http://diveintohtml5.org/detect.html" target="_blank">http://diveintohtml5.org/detect.html</a></li>
<li>JavaScript DOM compatibility table &#8211; Quirksmode.org: <a href="http://www.quirksmode.org/dom/w3c_core.html" target="_blank">http://www.quirksmode.org/dom/w3c_core.html</a></li>
<li>HTML5 specification draft &#8211; WhatWG: <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/" target="_blank">http://www.whatwg.org/specs/web-apps/current-work/multipage/</a></li>
<li>HTML5 features support compatibility table &#8211; <a href="http://en.wikipedia.org/wiki/Comparison_of_layout_engines_%28HTML5%29" target="_blank">Wikipedia.org: http://en.wikipedia.org/wiki/Comparison_of_layout_engines_%28HTML5%29</a></li>
</ul>