<p>A CSS sprite is really a technique rather than a unique object in the same way that DHTML is simply the technique of using JavaScript to manipulate the DOM.</p>
<p>So what exactly is a CSS sprite? Well, the sprite is a normal web-compatible image (e.g. JPEG, PNG or GIF) which contains several (or even all) CSS-applied background images for elements on your web page. The idea being that you can write your CSS classes in such a way that you define the width and height of your elements and position the CSS sprite image in so as to display only the relevant portion of the CSS sprite image as the element background.</p>
<p>As an example of CSS sprites, let&#8217;s create a graphical menu (one of my pet hates but a love of many designers I work with). We will create the menu using a &lt;ul&gt; (unordered list) with child &lt;li&gt; elements, each containing an anchor (&lt;a&gt;) element which in turn contains a &lt;span&gt; element. We will make each &lt;li&gt; list item float up next to it&#8217;s siblings, hide the text inside the &lt;span&gt; element, set the dimensions of the &lt;li&gt; element appropriately so that only the portion of the sprite image to be used as the background-image for that element is shown then set a :hover pseudo class on the &lt;a&gt; as a hover/rollover state. All graphics for the menu will come from a single image, the sprite image which for our example looks like this:</p>
<p>
![](/posts/assets/images/css_sprites_menu.jpg)
</p>
<p>The HTML markup we&#8217;ll use looks like this:</p>
<pre>&lt;ul&gt;
    &lt;li&gt;&lt;a href="#"&gt;&lt;span&gt;Home&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;&lt;span&gt;About us&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;&lt;span&gt;Products&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;&lt;span&gt;Contact us&lt;/span&gt;&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;</pre>
<p>Your CSS could then be something like this:</p>
<pre>/* menu main styles */
ul.main_menu
{
    float:left;
    width:100%;
    padding:0;
    margin:0;
    list-style-type:none; /* remove list item marker disc */
}
ul.main_menu li
{
    float:left; /* make each list item float next to it's siblings */
    padding:0;
    margin:0;
    height:50px; /* assign the same height to all list items */
}
ul.main_menu li a
{
    /* make the anchor elements display as block so we can 
    reliably set dimensions on them and remove default styles */
    float:left;
    display:block;
    padding:0;
    margin:0;
    width:100%;
    height:100%;
}
ul.main_menu li a span
{
    /* hide the text for each list item as our graphics will be replacing them */
    /* this technique (unlike display:none) won't hide the text from screenreaders */
    position:absolute;
    left:-90000px;
}

/* individual menu items */
ul.main_menu li.menu_item_home
{
    width:70px;
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') 0 0;
}
ul.main_menu li.menu_item_home a:hover
{
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') 0 52px;
}

ul.main_menu li.menu_item_about_us
{
    width:104px;
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -70px 0;
}
ul.main_menu li.menu_item_about_us a:hover
{
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -70px 52px;
}

ul.main_menu li.menu_item_products
{
    width:96px;
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -174px 0;
}
ul.main_menu li.menu_item_products a:hover
{
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -174px 52px;
}

ul.main_menu li.menu_item_contact_us
{
    width:105px;
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -270px 0;
}
ul.main_menu li.menu_item_contact_us a:hover
{
    background:url('/experiments/css-sprites/css-sprites-menu.jpg') -270px 52px;
}
</pre>
<p>Note the negative &#8220;x&#8221; positioning of the sprite image &#8211; this is because we want to offset the position of the sprite image to the left so that we display the correct portion of the sprite image as the background of our &lt;li&gt; element.</p>
<p>We apply the :hover pseudo class to the anchor (&lt;a&gt;) element rather than the &lt;li&gt; since earlier versions of Internet Explorer don&#8217;t apply the :hover pseudo class on any other elements than &lt;a&gt;&#8217;s.</p>
<p>You can see a working <a href="//thedotproduct.org/experiments/css-sprites/" target="_blank">example of CSS sprites</a> using the image, HTML and CSS above <a href="//thedotproduct.org/experiments/css-sprites/" target="_blank">here</a>.</p>
<p>The key benefits of CSS sprites are:</p>
<ul>
<li>Reduced number of HTTP requests which reduces page load times (because each HTTP request has a latency while the request is established then fulfilled)</li>
<li>Reduction/removal of that nasty &#8220;flicker&#8221; which can occur when the browser downloads a new image for the :hover pseudo class of the &lt;a&gt; element</li>
<li>Less files cluttering up the Web Server</li>
</ul>
<p>The down side to CSS sprites are:</p>
<ul>
<li>A slight increase in complexity in CSS</li>
<li>More time required by the designer to create the sprite image(s)</li>
<li>If an element needs to be added or amended, the whole sprite may need to be re-edited an uploaded</li>
<li>If a graphical element is removed, this may cause extra work in amending the sprite and CSS positioning accordingly</li>
</ul>
<p>CSS sprites are not necessarily appropriate for every website but they certainly can be a big benefit it the right circumstances. If your website is used by a lot of mobile or dial-up users or is very popular, you may well want to consider CSS sprites perhaps alongside <a href="http://code.google.com/p/minify/" target="_blank">CSS and JavaScript minification</a> &#8211; these methods could drastically reduce the number of HTTP requests made by your website which will be a big benefit for users of slower connections.</p>