<p>For ages now we&#8217;ve been trying to find a solution to our music needs in the office at work&#8230;</p>
<p>We have Windows, Mac and Linux computers and wanted to be able to use one computer to play music but we wanted each of our staff to be able to control (pause, skip track etc) the music, in case the phone rings etc. At last, we found the solution&#8230;and it&#8217;s very simple indeed!</p>
<p><a href="http://www.videolan.org/vlc/" target="_blank">VLC</a> &#8211; a multimedia app (which is available for a lot of different platforms) has an option allowing network control via a web-browser interface. Granted, it&#8217;s not the prettiest of interfaces but it works well so we are very happy.</p>
<p>Please note that the computers which will control VLC must be on the same network as the &#8220;Host machine&#8221; (the computer running VLC). Computer with which you want to control VLC do NOT need to have VLC installed.</p>
<p>To get the whole thing to work, we simply did the following:</p>
<ol>
<li>Install VLC on the &#8220;Host machine&#8221;, the computer from which you want to play music (whichever computer is wired to your speakers!)</li>
<li>Go into the &#8220;Preferences&#8221; (or &#8220;Options&#8221; depending on your platform) in VLC and click the &#8220;All&#8221; (or &#8220;Advanced&#8221;) radio button in the bottom left</li>
<li>Still in &#8220;Preferences&#8221; (&#8220;Options&#8221;)  select &#8220;Interfaces&#8221; from the left-hand menu check &#8220;Run as daemon process&#8221; (most instructions do not mention this setting but ours wouldn&#8217;t work without it)</li>
<li>Again in &#8220;Preferences&#8221; (&#8220;Options&#8221;)  select &#8220;Interfaces&#8221; &gt; &#8220;Control interfaces&#8221; from the left-hand menu and select &#8220;Web interface&#8221;</li>
<li>&#8220;OK&#8221; the changes to preferences</li>
<li>Start up a web-browser on another computer on the same network and go to http://HOST-MACHINE-IP:8080 and you should see the VLC network control interface!<br />
NOTE: If you don&#8217;t &#8211; please check the firewall settings on the host computer</li>
</ol>
<p>There are some instructions on the VLC website which discuss the various options to achieve the above also &#8211; <a href="http://wiki.videolan.org/Control_VLC_via_a_browser" target="_blank">http://wiki.videolan.org/Control_VLC_via_a_browser</a></p>
<p>I hope that helps!</p>