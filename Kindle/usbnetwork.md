# 安装usbnetwork
## 1.修改 usbNetwork 配置
/mnt/us/usbnet目录
1.将 DISABLED_auto文件名改为auto。
2.修改 /mnt/us/usbnet/etc/config文件，这是UNIX格式。  
  K3_WIFI="true"  
  K3_WIFI_SSHD_ONLY="true"
## 2. 制作密钥
去http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html下载 puttygen.exe。运行该软件，点击 Generate，然后根据提示随机移动鼠标来产生随机密钥。搞完之后，要把Public key for pasting into OpenSSH authorized_keys file里面生成的文本粘贴到一个空白的文本文件，应该是巨长的一行。然后保存到 K3 的 usbnet/etc 目录下，文件名是authorized_keys，这个是公钥。然后点击软件的 save private key 按钮保存私钥。需要的话，可以在KeyPasspharse填写一个密码来保护私钥文件。断开USB连接，[HOME] -> [MENU]> Settings -> [MENU] >Restart，重启K3。
## 3. 显示 K3 的 IP 地址
先开启无线，显示 WiFi 图标后，[HOME] -> [MENU] >Settings，然后输入 alt+u, alt+q, alt+q。这就是著名的 711 页面。在页面上半部分有 MAC地址，下半部分显示有 IP Address。一般无线路由器上的DHCP可以根据MAC地址保留IP地址，在路由器里设置一下之后，IP地址就不会再改变了。

## 4. SCP 客户端
下载http://winscp.net/download/winscp429.zip。解压缩，软后运行winscp。点击 New 按钮。Host Name 填写上一步得到的 IP 地址。User Name 填root。Private Key File 选择步骤4保存的私钥文件。Protocol 选择 SCP。左侧点击 SCP/Shell,然后将 Lookup User Groups 前的勾去除。左侧点击Directories，右侧在RemoteDirectory中填写/mnt/us。最后点击 Save 按钮保存。将来再次使用的时候，选中保存的配置，直接 login就可以了。运行之后，左侧是计算机的文件夹。右侧是K3 文件夹。

这时，你己经可以往K3内部liux 的任何文件夹下传文件了。。我们现在要做的是，把安装多看的脚本文件放入root目录中，然后运行它。
## 5.将这个安装多看脚本传入root目录中，具体是/tmp/root   ，DK_System/install里的一个*install.sh，解压后用winscp 传入 /tmp/root 目录中。
好了，如果你耐心的看到这里，己经成功大半了，最后一步要做的就是想办法让K3运行这个安装多看脚本就行了。
由于是windows 下安装，直接让K3运行这个脚本还不行，需要使用一个小工具putty，http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html下载

运行putty , 在host name 里面输入K3的IP。。这个IP在前面讲usbnetwork时有查IP的方法，或者在你的路由器里面可以看到。点击左面SSH 前面的加号，点击“auth”，右面点击“browse”，选到上面讲到的保存的私钥文件。。再点左面的“session”，回到最开始输IP时的界面，点击右下角的“open”，在弹出的窗口中输入用户名“root“，这时就进入K3了。（如果你没有装入之前存的私钥文件，输了用户名后会提示你输入密码，但谁也不知道密码是多少，所以进不了”

进入K3后，输入 sh./*install.sh(*代表具体文件名不定)  回车，开始安装多开脚本。。。一两秒钟，有个提示“making........”，大致意思是，让建立可写的文件系统，当时我还以为没运行成功，到处去找教程怎么建立可写的文件系统，结果没找到，后来发现，出现这个提示就己经是安装成功了。。

最后，重启K3，一切都和老系统装多看一样，重启后一会就提示按“Q”进入多看。。。。。。。。。。。

最后补充一点，需要在putty 安装多看脚本前，把多看的DK_System等三个文件夹拷入K3根目录。。
## http://www.mobileread.com/forums/showthread.php?t=225030
