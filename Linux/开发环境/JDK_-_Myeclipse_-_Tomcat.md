## JDK
### 第一种方法
```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
1.jdk7
	sudo apt-get install oracle-java7-installer
2.jdk8
	sudo apt-get install oracle-java8-installer
```

### 第二种方法
```bash
http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html
下载 jdk-7u80-linux-x64.tar.gz
sudo tar zxvf jdk-7u80-linux-x64.tar.gz -C /usr/lib/jvm
sudo gedit /etc/profile
添加以下代码
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_80
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
保存退出
source /etc/profile
设置系统默认jdk版本
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_80/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_80/bin/javac 300
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0_80/bin/jar 300
sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/jdk1.7.0_80/bin/javah 300
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.7.0_80/bin/javap 300
sudo update-alternatives --config java
验证是否成功
java -version
第三种方法 直接在软件中心 搜索安装openjdk代替
```
## MyEclipse
```bash
sudo chmod +x myeclipse.run
sudo sh myeclipse.run
root@linuxidc:~# 								cd /usr
root@linuxidc:/usr# 							sudo chown -R root:root MyEclipse
root@linuxidc:/usr# 							sudo chmod -R 777 MyEclipse
sudo vim /usr/bin/MyEclipse
	#!/bin/sh
	export MYECLIPSE_HOME="/usr/MyEclipse/MyEclipse 10/myeclipse"
	$MYECLIPSE_HOME/myeclipse $*
sudo chmod 755 /usr/bin/MyEclipse
sudo vim /usr/share/applications/MyEclipse.desktop
	[Desktop Entry]
	Encoding=UTF-8
	Name=MyEclipse 10
	Comment=IDE for JavaEE
	Exec='/usr/MyEclipse/MyEclipse 10/myeclipse'
	Icon=/usr/MyEclipse/MyEclipse 10/icon.xpm
	Terminal=false
	Type=Application
	Categories=GNOME;Application;Development;
	StartupNotify=true
最后一步，初始化启动一下： '/usr/MyEclipse/MyEclipse 10/myeclipse' -clean
```
## Tomcat
```bash
tar -zxvf apache-tomcat-7.0.69.tar.gz
cp -r apache-tomcat-7.0.69 [[/opt]]
加权限：
	sudo chown -R root:root apache-tomcat-7.0.69
	sudo chmod -R 777 apache-tomcat-7.0.69
进入 /opt/apache-tomcat-7.0.69 目录
	cd [[/opt/apache-tomcat-7.0.69]]
sudo vim [[./bin/startup.sh]]
添加：
	JAVA_HOME=/usr/lib/jvm/jdk1.7.0_80
	JRE_HOME=${JAVA_HOME}/jre
	CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
	PATH=${JAVA_HOME}/bin:$PATH
	TOMCAT_HOME=/opt/apache-tomcat-7.0.69
启动tomcat： sudo [[./bin/startup.sh]]
关闭tomcat：sudo ./bin/shutdown.sh
```
