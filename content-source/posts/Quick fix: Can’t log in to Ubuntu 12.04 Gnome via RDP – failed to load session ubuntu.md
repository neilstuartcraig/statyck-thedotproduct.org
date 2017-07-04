<p>AS I type, i&#8217;m setting up an Ubuntu server to use a virtual server host on my test rig. Slight problem though, after getting bored/frustrated with command line configuring (odd because usually command line is my preference) I got lazy and decided to install <a href="http://www.gnome.org/" target="_blank">Gnome </a>and <a href="http://virt-manager.org/" target="_blank">virt-manager</a>. All good, so I thought, I added xrdp to allow me to RDP in but got a message &#8220;<strong>failed to load session ubuntu</strong>&#8220;.</p>
<p>A little digging on the internet and the solution which worked for me was to install unity-2d:</p>
<pre>sudo apt-get install unity-2d
</pre>
<p>Then i just restarted GDM:</p>
<pre>sudo restart gdm</pre>
<p>And I can now log in via RDP to my Ubuntu 12.04 server!</p>
<p>Hope that helps someone.</p>