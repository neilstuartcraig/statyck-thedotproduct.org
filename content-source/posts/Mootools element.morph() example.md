<p>Mootools, like other JavaScript frameworks, provides some easy to use animations which I&#8217;ve used successfully quite a number of times, they really do save a massive amount of time and when used appropriately can add some gloss to your project. I&#8217;d always stuck with the old notation of using the <a href="http://mootools.net/docs/core/Fx/Fx" target="_blank">Mootools Fx methods</a> and had set each property to be altered&#8230;but recently, I spent a little time reading the Mootools documentation and found that not only can you morph an element from one CSS class to another, you can use a simpler &#8220;element.morph()&#8221; syntax, rather than having to set up and Fx object first&#8230;nice!</p>
<p>I think the best way to explain it is with a <a href="//thedotproduct.org/experiments/morph/" target="_blank">working example</a>.</p>
<p>The example assumes a some reasonably basic Mootools/JavaScript knowledge but I have tried to keep it simple so it will be easier for less experienced developers to use:</p>
<p><strong>HTML</strong> (some meta tags etc removed for clarity &#8211; note that cnet.220.js is the CNet version of Mootools 1.2, you can use either CNet&#8217;s version or the standard Mootools 1.2 version):</p>
<pre>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" lang="en"&gt;
&lt;head&gt;
&lt;title&gt;Mootools element.morph() example&lt;/title&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=utf-8" /&gt;
&lt;link rel="stylesheet" href="morph.css" type="text/css" /&gt;

&lt;script type="text/javascript" src="cnet.220.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="morph.js"&gt;&lt;/script&gt;

&lt;/head&gt;
&lt;body&gt;
 &lt;div&gt;
   &lt;div id="main"&gt;
   &lt;/div&gt;
 &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<p><strong>JavaScript:</strong></p>
<pre>window.addEvent("domready", function()
{
 // obtain the main container element
 var m=$("main");
 
 // check we have successfully obtained the main container element
 if(m)
 {
  // create a div which will be morphed
  var el=new Element("div", 
  {
    "class":"morph_div"
  }).inject(m, "top");
 
  // create the button which will start the morph
  var btn=new Element("button", 
  {
    type:"button",
    html:"Morph element",
    "class":"morph_btn"
  }).inject(m, "before");
 
  // set a variable which will be used to indicate which state the morph element is in
  var btn_status=0;

  // add an onClick event to the above button which morphs the morph element
  btn.addEvent("click", function()
  {
    // update the morph status
    btn_status=btn_status==0?1:0;
 
    // set the morph transition duration and type - duration is in milliseconds, for types see the mootools docs on mootools.net
    el.set("morph", {duration:700, transition:"bounce:out"});

    // morph the morph element to the opposite css class to that which is it currently in
    el.morph(btn_status?"div.morph_div_alt":"div.morph_div");
    });
  }
  else
    alert("Sorry, couldn't find the main container element");
});</pre>
<p><strong>CSS</strong></p>
<pre>html
{
 background:#fff;
 color:#494949;
 font:100 80% verdana,arial,sans-serif;
 padding:0;
 margin:0;
}
body
{
 padding:2em 0;
 margin:0;
}
div
{
 float:left;
 width:100%;
 margin:0;
 padding:0;
}
a
{
 text-decoration:none;
 color:#196496;
}

div.site_outer
{
 float:none;
 margin:0 auto;
 width:960px;
}
div.site_inner
{
 padding:1em 0 0 0;
}
div.morph_div
{
 border:1px solid #f0f;
 background:#ff0;
 width:50px;
 height:50px;
}
div.morph_div_alt
{
 border:10px solid #000;
 background:#0ff;
 width:250px;
 height:250px;
}
</pre>
<p><strong>NOTES:</strong></p>
<ul>
<li><strong>You can only morph between mathematically calculable CSS properies</strong> e.g. width, height, border width, colours etc &#8211; you cannot morph between e.g. 2 different background images for obvious reasons!</li>
<li><strong>All properties which are to be morphed between must be explicitly declared in both the source and destination CSS classes</strong> &#8211; you cannot morph from/to an inherited property</li>
</ul>
<p>That&#8217;s it&#8230;I hope it&#8217;s helpful</p>