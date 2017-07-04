<p>I&#8217;ve just been creating the HTML for an Email to be sent out on behalf of a client and have found what appears to be a bug in Outlook 2007 &amp; 2010 (which use the MS Word rendering engine) when using tall images in HTML Emails.</p>
<p>My HTML Email was created from a JPEG designed by a design agency which I simply sliced up in Photoshop to allow me to use one image as a hyperlink (we have to do this nowadays since Outlook 2007 and 2010 don&#8217;t support background images). Photoshop created 6 slices, the top 3 were 2056 pixels tall. I used the traditional, nasty table-based HTML for the Email as it tends to be more reliable on various Email clients which our Clients demand.</p>
<p>I found that Outlook 2007 and 2010 effectively cropped the top 3 images, cutting off the top 450 pixels or so&#8230;how odd!</p>
<p>I am wondering if the problem is absolute height (i.e. a lot of pixels) or aspect ratio. I will do some tests to find out when time permits.</p>
<p>There were 2 solutions I found:</p>
<p><strong>Solution 1:</strong><br />
Use divs to format the HTML instead of tables but as I said previously, this is much more difficult to make reliable across various Email clients.</p>
<p><strong>Solution 2:</strong><br />
Slice the images up into shorter dimensions, I ended up slicing the images to around 500px tall which seems to work absolutely fine.</p>
<p>I&#8217;d be very interested to hear if anyone else has experienced the same issue.</p>
<p>Hope that saves you some time&#8230;it took me about an hour of bug-chasing!</p>