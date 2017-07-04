<p>As I mentioned in <a href="//thedotproduct.org/how-to-get-an-accurate-geo-location-from-apple-iphone-using-navigator-geolocation-watchposition/" target="_blank">my previous post about the new/upcoming navigator.geolocation standard</a>, I have been experimenting with<strong> Geo location on my IPhone</strong> so I thought I&#8217;d share some of that with you in case it helps anyone out.</p>
<p>My example is very simple and is intended to show how you can use the <strong>JavaScript</strong> <strong>navigator.geolocation.watchPosition()</strong> (the <strong>more accurate method of Geo location on IPhone</strong>) to determine your<strong> Geo location</strong>.</p>
<p>So, without further ado, here it is, my <a href="/experiments/geo/" target="_blank">example of navigator.geolocation.watchPosition()</a>. The JavaScript code is commented but if you have any questions, please post them as comments and I&#8217;ll do my best to answer them. I&#8217;ll be honest here too, i&#8217;ve not really tested the script on anything other than my <strong>IPhone</strong> so if it doesn&#8217;t work for you, please let me know!</p>
<p>The <strong>navigator.geolocation</strong> object offers is quite small but offers the following (at the time of writing):</p>
<p><strong>Methods</strong>:</p>
<ul>
<li> void <strong>navigator.geolocation.getCurrentPosition</strong>(success_callback_function, error_callback_function, position_options)</li>
<li> long <strong>navigator.geolocation.watchPosition</strong>(success_callback_function, error_callback_function, position_options)</li>
<li> void <strong>navigator.geolocation.clearWatch</strong>(watch_position_id)</li>
</ul>
<p>position_options is specified as a JSON-style string with up to three parameters:</p>
<ul>
<li><strong>enableHighAccuracy</strong> &#8211; A boolean (true/false) which indicates to the device that you wish to obtain it&#8217;s most accurate readings (this parameter may or may not make a difference, depending on your hardware)</li>
<li><strong>maximumAge</strong> &#8211; The maximum age (in milliseconds) of the reading (this is appropriate as the device may cache readings to save power and/or bandwidth)</li>
<li><strong>timeout</strong> &#8211; The maximum time (in milliseconds) for which you are prepared to allow the device to try to obtain a Geo location</li>
</ul>
<p>For example, your options could specified as per my example:</p>
<pre>wpid=navigator.geolocation.watchPosition(geo_success, geo_error, <strong>{enableHighAccuracy:true, maximumAge:30000, timeout:27000}</strong>);</pre>
<p>The success_callback_function is passed a single parameter, a position object which has the following properties:</p>
<ul>
<li><strong>coords.latitude</strong> &#8211; The current latitude reading</li>
<li><strong>coords.longitude</strong> &#8211; The current longitude reading</li>
<li><strong>coords.accuracy</strong> &#8211; The accuracy of the current latitude and longitude readings (in metres)</li>
<li><strong>coords.speed</strong> &#8211; The current speed reading in metres per second (you can simply multiply by 2.2369 to convert to miles per hour or multiply by 3.6 to convert to kilometres per hour)</li>
<li><strong>coords.altitude</strong> &#8211; The current altitude reading (in metres)</li>
<li><strong>coords.altitudeAccuracy</strong> &#8211; The accuracy of the current altitude reading (in metres)</li>
</ul>
<p>So, for example if your success_callback_function is specified as in my example:</p>
<pre>wpid=navigator.geolocation.watchPosition(<strong>geo_success</strong>, geo_error, {enableHighAccuracy:true, maximumAge:30000, timeout:27000});
</pre>
<p>the success_callback_function would be called &#8220;geo_success&#8221; and could be as follows:</p>
<pre>function geo_success(position)
{
    document.title=position.coords.speed;
}
</pre>
<p>Which would simply change the document.title to the current speed reading.</p>
<p>You can find the full specification for the navigator.geolocation interface here: <a href="http://dev.w3.org/geo/api/spec-source.html#geolocation_interface" target="_blank">http://dev.w3.org/geo/api/spec-source.html#geolocation_interface</a>.</p>