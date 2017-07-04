<p>As a follow-up to my article on <a href="//thedotproduct.org/2010/03/jsh5f-a-javascript-method-to-enable-html5-form-elements-in-browsers-which-support-them/" target="_blank">js5hf</a> &#8211; an unobtrusive javascript method for converting text type inputs to HTML5 input types, I wanted to put together a simple example of the new HTML5 inputs to demonstrate the formats in which they output data. So&#8230;you can see my <a href="//thedotproduct.org/experiments/html5_inputs/" target="_blank">example of HTML5 input element data formats</a> which is semi-interactive &#8211; you can enter data as you wish and view the output by submitting the form.</p>
<p>A summary of the output formats is (any constant elements e.g. the &#8220;W&#8221; in week inputs and the &#8220;T&#8221; in datetime inputs are bolded):</p>
<ul>
<li>Search: String</li>
<li>Number: String/Number</li>
<li>Range: String/Number</li>
<li>Tel: Unsupported at present</li>
<li>URL: String (Opera requires an absolute URL e.g. http://www.example.com)</li>
<li>Email address: String (The Email address format checks performed are minimal to day the least)</li>
<li>Date: YYYY-MM-DD</li>
<li>Month: YYYY-MM</li>
<li>Week: e.g. YYYY-<strong>W</strong>WW (e.g. 2010-04 is week 4 of 2010)</li>
<li>Time: HH:II:SS (e.g. 23:59:59)</li>
<li>Datetime: YYYY-MM-DD<strong>T</strong>HH:II:SS (e.g. 2010-04-25T23:59:59)</li>
<li>Datetime-local: YYYY-MM-DD<strong>T</strong>HH:II:SS (e.g. 2010-04-25T23:59:59)</li>
</ul>
<p>You can see a <a href="http://www.w3.org/TR/html-markup/" target="_blank">more complete specification of HTML5 input elements on w3.org</a>.</p>