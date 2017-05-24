# 最简android之wifi调试
### 1.开始我们需要给手机开启tcpip模式，这个时候需要usb线连接手机

> adb tcpip 端口号（随便写个大点的比如：5555）  
>写完这个之后，usb就没用了

### 1.开始我们需要手机运行Terminal 无线连接手机

> su //如果前面显示的符号是$ ，则运行此命令切换到root。如果是# ，可以不用此命令  
> setprop service.adb.tcp.port 5555  
> stop adbd  
> start adbd  

### 2.你需要查看你手机的ip地址，方法很多
>如果想使用命令的话（如果使用命令查看，usb还不能拔，查完再拔）

> adb shell ifconfig wlan0  


### 3.连接手机

> adb connect 手机ip

### 4.如果想断开连接的话

> adb disconnect 手机ip  
大功告成，注意手机和PC应该在同一wifi下，实际你只要PC能ping通手机ip就没问题，如果没有路由器怎么办？你电脑里面的360wifi是干什么的？

### 如果想切换回usb模式

> adb usb  
如果切换回去的话，下次连接还需要数据线开启tcpip，如果不切换的话，以后调试就再也不用数据线了
