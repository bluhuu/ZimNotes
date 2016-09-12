<div id="post-883" class="post-883 post type-post status-publish format-standard hentry category-kindle">

						<h1 class="entry-title">Kindle 3 — changing the root password for SSH via&nbsp;WiFi</h1>
						<div class="byline">
							<abbr class="published" title="September 25, 2011 8:43 pm">September 25, 2011</abbr> ·							by <span class="author vcard"><a href="https://grenville.wordpress.com/author/grenville/" title="Posts by grenville" rel="author">grenville</a></span> ·							in <a href="https://grenville.wordpress.com/category/computers/kindle/" rel="category tag">Kindle</a>														· <span class="comments-link"><a href="https://grenville.wordpress.com/2011/09/25/kindle-3-changing-root-password/#respond">Leave a comment</a></span>
														<span class="edit"></span>
						</div>

						<div class="entry-content">

							<p>This post summarises the steps I used to change the root ssh password and enable ssh access over 802.11/WiFi on <a title="Kindle K3 — jailbreak, then network access over USB&nbsp;port" href="https://grenville.wordpress.com/2011/09/25/kindle-jailbreak-usb-networking/" target="_blank">my jailbroken Kindle 3</a>.<br>
<span id="more-883"></span></p>
<p><strong>Enabling root access</strong></p>
<p>The K3 starts with an unknown root password which we’d need to know if attempting to ssh in over WiFi. The trick to making this password known is to <a title="Kindle K3 — jailbreak and USB&nbsp;networking" href="https://grenville.wordpress.com/2011/09/25/kindle-jailbreak-usb-networking/" target="_blank">set up USB networking</a>, login over the USB link, re-mount the filesystem readw-write (rw), then use passwd to change root’s password.</p>
<p>Supply an empty password to first ssh into the K3 as root over the USB network link.</p>
<pre>[gja@gjadesktop]/home/gja(103)% ssh root@192.168.2.2

Welcome to Kindle!

root@192.168.2.2's password:
#################################################
#  N O T I C E  *  N O T I C E  *  N O T I C E  #
#################################################
Rootfs is mounted read-only. Invoke mntroot rw to
switch back to a writable rootfs.
#################################################
[root@kindle root]#</pre>
<p>The password file on the “rootfs” file system (mounted on /dev/root), which by default is mounted read-only (ro).</p>
<pre>[root@kindle root]# mount
rootfs on / type rootfs (rw)
/dev/root on / type ext3 (ro,noatime,nodiratime,data=ordered)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
tmpfs on /dev type tmpfs (rw,mode=755)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
rwfs on /mnt/rwfs type tmpfs (rw,size=32768k)
shm on /dev/shm type tmpfs (rw)
rwfs on /var type tmpfs (rw,size=32768k)
/dev/mmcblk0p2 on /var/local type ext3 (rw,sync,errors=continue,data=ordered)
fsp on /mnt/us type <span class="skimlinks-unlinked">fuse.fsp</span> (rw,nosuid,nodev,noatime,user_id=0,group_id=0)
/dev/loop/0 on /mnt/base-us type vfat (rw,noexec,noatime,nodiratime,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8)
[root@kindle root]#</pre>
<p>Use the “mntroot” command to re-mount the root file system in read-write (rw) mode.</p>
<pre>[root@kindle root]# mntroot rw
system: I mntroot:def:Making root filesystem writeable
[root@kindle root]#</pre>
<p>/dev/root is now “rw”:</p>
<pre>[root@kindle root]# mount
rootfs on / type rootfs (rw)
/dev/root on / type ext3 (rw,noatime,nodiratime,data=ordered)
[...]
[root@kindle root]#</pre>
<p>I used ‘passwd’ to change root’s password to “xxxxx”, then make things safe again by restoring the root file system to read-only mode:</p>
<pre>[root@kindle init.d]# mntroot ro
system: I mntroot:def:Making root filesystem read-only
[root@kindle init.d]#</pre>
<p><strong>Enabling SSH into the K3 via WiFi</strong></p>
<p>The K3’s WiFi interface uses DHCP to request a valid local IP address from whatever WiFi network (SSID) you’ve configured the K3 to use. &nbsp;(The K3 enables you to scan for local WiFi networks, and then provide the authentication key/password for which ever network/SSID you chose.) In factory-default form the K3’s WiFi interface is only used to access the Amazon online shop and rudimentary web access using the experimental browser.</p>
<p>Fortunately, in addition to settings for the IP addresses at either end of the USB network link, the configuration file <code>/usbnet/etc/config</code> contains a flag to enable SSH access over the WiFi interface whenever both usbNetwork and WiFi are enabled:</p>
<pre>K3_WIFI="true"</pre>
<p>With this option set “true”, you can SSH in to the K3’s DHCP-assigned IP address over WiFi — but you <em>will</em> require the root password that we set above.</p>
		<div class="wpcnt">
			<div class="wpa wpmrec">
				<a class="wpa-about" href="https://wordpress.com/about-these-ads/" rel="nofollow">About these ads</a>
				<div class="u">
					<script type="text/javascript">
					(function(g){g.__ATA.initAd({sectionId:26942, width:300, height:250});})(window);
					</script><div id="automattic-id-3988" data-section="26942" style="width:300px; height:250px;"></div>
				</div>
			</div>
		</div><div id="jp-post-flair" class="sharedaddy sd-like-enabled sd-sharing-enabled"><div class="sharedaddy sd-sharing-enabled"><div class="robots-nocontent sd-block sd-social sd-social-icon-text sd-sharing"><h3 class="sd-title">Share this:</h3><div class="sd-content"><ul><li class="share-email share-service-visible"><a rel="nofollow" data-shared="" class="share-email sd-button share-icon" href="https://grenville.wordpress.com/2011/09/25/kindle-3-changing-root-password/?share=email&amp;nb=1" target="_blank" title="Click to email" style="background-color: rgb(242, 242, 242);"><span>Email</span></a></li><li class="share-end"></li></ul></div></div></div><div class="sharedaddy sd-block sd-like jetpack-likes-widget-wrapper jetpack-likes-widget-loaded" id="like-post-wrapper-53208-883-57d65a962f47b" data-src="//widgets.wp.com/likes/#blog_id=53208&amp;post_id=883&amp;origin=grenville.wordpress.com&amp;obj_id=53208-883-57d65a962f47b" data-name="like-post-frame-53208-883-57d65a962f47b"><h3 class="sd-title">Like this:</h3><div class="likes-widget-placeholder post-likes-widget-placeholder" style="height: 55px; display: none;"><span class="button"><span>Like</span></span> <span class="loading">Loading...</span></div><iframe class="post-likes-widget jetpack-likes-widget" name="like-post-frame-53208-883-57d65a962f47b" height="55px" width="100%" frameborder="0" src="//widgets.wp.com/likes/#blog_id=53208&amp;post_id=883&amp;origin=grenville.wordpress.com&amp;obj_id=53208-883-57d65a962f47b"></iframe><span class="sd-text-color"></span><a class="sd-link-color"></a></div>
<div id="jp-relatedposts" class="jp-relatedposts" style="display: block;">
	<h3 class="jp-relatedposts-headline"><em>Related</em></h3>
<div class="jp-relatedposts-items jp-relatedposts-items-minimal"><p class="jp-relatedposts-post jp-relatedposts-post0" data-post-id="991" data-post-format="false"><span class="jp-relatedposts-post-title"><a class="jp-relatedposts-post-a" href="https://grenville.wordpress.com/2011/09/26/kindle-3-file-systems-and-flash-layout/" title="Kindle 3's FLASH file system layout

This post briefly summarises my findings when poking around the file systems on the FLASH of my Kindle 3. Overall layout With USB networking enabled, it is easy enough to login remotely and poke around. The entire internal FLASH drive is /dev/mmcblk0, so we can use fdisk to print the…" rel="nofollow" data-origin="883" data-position="0">Kindle 3's FLASH file system layout</a></span><span class="jp-relatedposts-post-context">In "Kindle"</span></p><p class="jp-relatedposts-post jp-relatedposts-post1" data-post-id="960" data-post-format="false"><span class="jp-relatedposts-post-title"><a class="jp-relatedposts-post-a" href="https://grenville.wordpress.com/2011/12/21/kindle-3-keyboard-shortcuts-and-useful-commands/" title="Kindle 3 -- keyboard shortcuts, battery monitoring and debug commands

This post briefly summarises a variety of keyboard commands and shortcuts I've picked up from various places and found useful when experimenting with my Kindle 3 Commands / Debug mode There are a number of commands available in 'debug' mode, which are entered via the Home page's &quot;Search&quot; window. Reach…" rel="nofollow" data-origin="883" data-position="1">Kindle 3 -- keyboard shortcuts, battery monitoring and debug commands</a></span><span class="jp-relatedposts-post-context">In "Kindle"</span></p><p class="jp-relatedposts-post jp-relatedposts-post2" data-post-id="353" data-post-format="false"><span class="jp-relatedposts-post-title"><a class="jp-relatedposts-post-a" href="https://grenville.wordpress.com/2011/01/07/adding-a-debian-environment-to-the-ns-k330-under-snakeos-2/" title="FTP vs rsync on the NS-K330 with SnakeOS 1.2.0

I recently been playing with my new NS-K330 &quot;NAS&quot;&nbsp; -- a tiny device with one 10/100Mbps LAN port and two USB 2.0 ports, intended for home use as a cheap Network Attached Storage unit and file download client. This post describes the network transfer performance I experienced using ftp and…" rel="nofollow" data-origin="883" data-position="2">FTP vs rsync on the NS-K330 with SnakeOS 1.2.0</a></span><span class="jp-relatedposts-post-context">In "Embedded -- NS-K330"</span></p></div></div></div>


						</div><!-- .entry-content -->

					</div>
