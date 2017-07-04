<p>CSS 2.1 has some really handy selectors, one of which is the <a href="http://www.w3.org/TR/CSS2/selector.html#adjacent-selectors" target="_blank">adjacent (next) sibling selector</a> which has the form:</p>
<pre>el1 + el2
{
color:#f0f;
}</pre>
<p>The above would apply a tasty pink(ish) text colour to el2 where it directly follows el1 in HTML element order. Excellent, that can be seriously useful.</p>
<p>The glaring omission (as far as i can see) in the CSS selectors currently available though is the exact opposite selector, previous-sibling which might perhaps have syntax:</p>
<pre>el1 - el2
{
color:#f0f;
}</pre>
<p>so i would see this as the obvious way to style el2 where it occurs directly before el1 with that same delightful pink(ish) text colour. This would have been immensely helpful in the project I am working on right now as i&#8217;m using a flexbox layout on a Zend Framework form and want to swap around the order of the input and label when and only when the input is a checkbox so i&#8217;d have loved to have been able to do:</p>
<pre>label - input[type="checkbox"]
{
order:-1;
}</pre>
<p>on HTML source of:</p>
<pre>&lt;div&gt;
&lt;label for="a"&gt;
Label text
&lt;/label&gt;
&lt;input type="checkbox" name="a" id="a"&gt;
&lt;/div&gt;</pre>
<p>There is also currently a non-direct sibling selector which uses a tilda in place of the plus, the opposite of this could perhaps be:</p>
<pre>el1 -~ el2
{
color:#f0f;
}</pre>
<p>Please, please, please can we have these browser devs? i&#8217;m certainly not the first to ask for them and I am aware that e.g. jQuery implement these so it obviously makes sense.</p>