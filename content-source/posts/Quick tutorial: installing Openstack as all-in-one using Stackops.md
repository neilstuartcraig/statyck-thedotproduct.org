 <p>I&#8217;ve recently been working on lots of trial-runs of software at work and got annoyed with having to rebuild servers all the time so i decided to join the rest of the world and go virtual. Our production VI at work runs VMWare (ESXi) but my trial stack was going to be a no-budget affair so I took the opportunity to try out <a href="http://www.openstack.org/" target="_blank">Openstack </a>which I&#8217;d been meaning to do for quite some time. If you&#8217;ve not come across Openstack previously, it&#8217;s a project which started at NASA and has moved over to be open source which provides pretty much all the base software you need to run a VI (cloud).</p>
<p>After having read a load of the install documentation on Openstack, I decided it looked pretty complex (and I still hold that view). Consequently, I looked for an installer script/application for Openstack and found the go-to installer of choice for many, <a href="http://devstack.org/" target="_blank">devstack</a>. After playing with devstack for a little while I actually liked it a lot, I have one major beef with it though, as default devstack configures the storage for keystone (the authentication mechanism for Openstack) to use non-persistent storage. This may be fine for very simple test purposes but I found out to my peril that user accounts e.g. admin logins don&#8217;t survive a host reboot. So after trying and failing to use a different storage backend devstack was sidelined for me (I fully recognise this is my weakness but I think since devstack is targetted at developers rather than experienced VI techies.</p>
<p>Enter <a href="http://www.stackops.org/" target="_blank">stackops</a>! So stackops has similar aims in that it intends to (and very much does) simplify the installation of Openstack. Stackops is essentially Ubuntu server as a basis (10.04 at the time of writing) with a &#8220;Smart installer&#8221; which is web-based to install Openstack. I found that with a little digging and a little judicious manual work, I could easily get my Openstack/stackops installation working (stackops defaults to using MySQL as the storage backend for keystone) so I thought I&#8217;d share what I found in case it helps someone out.</p>
<p>As a brief introduction, the stackops installer is very similar to the installer used by Debian and Ubuntu (but with no purple). So here goes with an overview of how to create an all-in-one (single node) installation of Openstack using stackops:</p>
<ul>
<li>Check your host server has
<ul>
<li>A 64 bit intel/AMD (x64) CPU which supports virtualisation &#8211; note you may need to enable virtualisation support in BIOS</li>
<li>A static IP to assign to it (which you can reach from your desktop on at least port 80 and 8888 &#8211; for later configuration)</li>
<li>No data you need on it &#8211; you&#8217;re very likely to lose it all depending on what you do with partitioning and installation</li>
</ul>
</li>
<li>Download the <a href="http://www.stackops.org/" target="_blank">stackops </a>ISO and burn to disc (a CD will do the job as it&#8217;s quite small) &#8211; i&#8217;m basing this on stackops V0.5</li>
<li>Boot the host from the CD created above, follow the installer with logical choices specific to you e.g. language and enter the static IP of your host when prompted</li>
<li>CRITICAL STEP: When you get to the disk partition menu, choose <strong>manual</strong> then (NOTE: the information for this part came from the comments on <a href="https://getsatisfaction.com/stackops/topics/device_dev_sda_not_found_or_ignored_by_filtering" target="_blank">this page</a>):
<ul>
<li>Ideally delete all existing partitions &#8211; NOTE: you will lose all data so only do this if you are 100% sure you don&#8217;t need any of it, you can&#8217;t get it back!</li>
<li>Create partitions as follows:
<ul>
<li>OS partition: Primary, at beginning of free space,mount point &#8220;/&#8221;, bootable flag on, whatever size you want (this will hold the OS, apps etc. so I;d recommend 15GB or more)</li>
<li>Swap partition: Logical, at end of free space, &#8220;use as&#8221; = &#8220;Swap area&#8221;, whatever size you want but probably best to be about the same as the amount of RAM you have</li>
</ul>
</li>
<li>Now we need to create the LVM group which Openstack will use for VM storage so choose &#8220;Configure the Logical Volume Manager&#8221; and choose &#8220;Yes&#8221; when asked if you want to write changes to disk</li>
<li>Now choose &#8220;Create volume group&#8221; and use the name &#8220;nova-volumes&#8221; (without the quotes) &#8211; Openstack expects this name so you must use it</li>
<li>Choose the free space from the selection menu (use spacebar to select) then write changes to LVM then choose &#8220;Finish&#8221; and then write changes to disk</li>
</ul>
</li>
<li>Follow the rest of the stackops installer as normal</li>
</ul>
<p>You&#8217;ll eventually arrive at a shell login prompt so you&#8217;re nearly done! Log in as root using the default password of &#8220;stackops&#8221; (without the quotes).</p>
<p>Now run the shell command &#8220;pvs&#8221; and note the device path (bolded below)</p>
<pre>root@nova-controller:/# pvs
PV                VG           Fmt  Attr PSize   PFree
<strong>/dev/cciss/c0d0p6</strong> nova-volumes lvm2 a-   102.42g 97.42g
root@nova-controller:/# pvs  PV                VG           Fmt  Attr PSize   PFree  /dev/cciss/c0d0p6 nova-volumes lvm2 a-   102.42g 97.42g</pre>
<p>(You&#8217;ll need this in a moment)</p>
<p>So now go back to your desktop and go to the web-installer on the host on port 8888 &#8211; so if your hosts static IP is 192.168.16.10, go to 192.168.16.10:8888 and you will be forwarded on to the stackops web installer &#8211; don&#8217;t be scared it does work!</p>
<p>So head through the installer and when you come to the &#8220;volumes&#8221; page, make sure you select the device which holds your &#8220;nova-volumes&#8221; LVM group which we found above. Now complete the installer and sit back while it does it&#8217;s work.</p>
<p>Once the installer is complete, shell in again as root (pw: stackops) to the host &#8211; you now need to add some VM images. This step seems to be omitted in many guides but luckily, the nice folk at devstack and stackops have provided scripts to download and install some common images e.g. Debian, Ubuntu, Centos etc. You can find these scripts in /var/lib/stackops, just run them using e.g. ./pubdebian6.sh once you&#8217;ve cd&#8217;d to /var/lib/stackops.</p>
<p>Now you can log in to your admin console which is on port 80 at the static IP of your host.</p>
<p>Hope that&#8217;s useful.</p>
<p>Documents for reference:</p>
<ul>
<li><a href="http://www.openstack.org/" target="_blank">Openstack</a></li>
<li><a href="http://devstack.org/" target="_blank">Devstack</a></li>
<li><a href="http://www.stackops.org/" target="_blank">Stackops</a></li>
<li><a href="http://docs.stackops.org/display/doc03/Global+System+Requirements" target="_blank">Stackops requirements</a></li>
<li><a href="http://docs.stackops.org/display/documentation/Install+and+Configure+the+Distro" target="_blank">Stackops initial distro install guide</a></li>
<li><a href="http://docs.stackops.org/display/documentation/Smart+Installer+Overview" target="_blank">Stackops smart installer overview</a></li>
<li><a href="http://docs.stackops.org/display/doc03/StackOps+Virtual+Images+Repository" target="_blank">Stackops VM image repository</a></li>
</ul>