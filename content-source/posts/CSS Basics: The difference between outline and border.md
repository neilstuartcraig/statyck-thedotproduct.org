<p>CSS outline and border are at a glance very similar but have a few important differences:</p>
<ul>
<li>Outline is effectively overlaid over the top of the element it is applied to and therefore <strong>outline <em>does not</em> add to the element width</strong> whereas <strong>border <em>does</em> add to the element width</strong></li>
<li>Outline (according to the <a href="http://www.w3.org/TR/CSS21/ui.html#dynamic-outlines" target="_blank">official W3C specification</a> at least) <strong>does not have to be rectangular</strong> whereas border must be rectangular</li>
<li><strong>Internet Explorer 7 and earlier <a href="http://msdn.microsoft.com/en-us/library/cc351024%28VS.85%29.aspx#userinterface" target="_blank">support</a> for outline is poor</strong> whereas border is pretty well supported</li>
</ul>
<p>Both outline and border are CSS2 properties.</p>