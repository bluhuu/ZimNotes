# 通过WiFi访问已越狱的kindle电子书

<div id="content">
  <div id="con_top">
  <script type="text/javascript">veryhuo_as(&quot;va001&quot;);</script>
</div>
  <p>亚马逊kindle电子书阅读器的系统是基于linux，然后阅读程序是用java程序写的，越狱后我就尝试直接通过wifi去连接kindle，但是竟然提示无法连接，既然是基于linux的，那就先连线上去看看怎么回事吧。</p>
  <ol>
  <li>首先保证kindle已经越狱 </li>
  <li>在主界面搜索框输入：;un password(password是网络连接密码) </li>
  <li>连上usb线，打开电脑自动识别出来的usb网卡，设置电脑usb网卡的ip为192.168.15.*网段（kindle默认的ip地址就是192.168.15.244），然后顺利通过终端ssh root@192.168.15.244连接上kindle </li>
  <li>mntroot rw，取得root的都写权限 </li>
  <li>打开iptables，vi /etc/sysconfig/iptables，找到不能wifi连接的原因了： </li>
</ol>
  <blockquote>
  <p># ICMP. Allow only responses to local connections<br>-A INPUT -p icmp -m state –state RELATED,ESTABLISHED -j ACCEPT</p>
</blockquote>
  <p>在其后面添加如下内容：</p>
  <blockquote>
  <p>-A INPUT -i wlan0 -p tcp –dport 22 -j ACCEPT</p>
</blockquote>
  <p>这样就能通过wlan0口（wifi）访问22端口了（ssh端口）然后保存退出vi。</p>
  <p>6.在kindle主界面搜索框输入：711，察看kindle上的wlan0网卡的ip地址，假设为192.168.0.2，在电脑终端通过ssh root@192.168.0.2,出现密码输入提示，输入密码后，成功登陆。至此，问题解决。</p>
  <div id="con_all">
  <div id="con_ad1">
  <script type="text/javascript">veryhuo_as(&quot;va011&quot;);</script>
</div>
  <div id="con_ad8">
  <script type="text/javascript">veryhuo_as(&quot;va022&quot;);</script>
</div>
</div>
</div>
