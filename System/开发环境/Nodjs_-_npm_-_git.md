## 交换Caps Lock和Control键
```bash
sudo vi /etc/default/keyboard
XKBLAYOUT=“US”
XKBOPTIONS="ctrl:swapcaps" or "ctrl:nocaps"
sudo dpkg-reconfigure keyboard-configuration
```
## node.js
```bash
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
```
## npm 升级
```bash
sudo apt-get install npm
node有一个模块叫n（这名字可够短的。。。），是专门用来管理node.js的版本的。
首先安装n模块：
sudo npm install -g n
第二步：
升级node.js到最新稳定版
sudo n stable
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm sync connect
是不是很简单？
n后面也可以跟随版本号比如：
n v0.10.26
或
n 0.10.26
分享几个npm的常用命令
npm -v #显示版本，检查npm 是否正确安装。
npm install express #安装express模块
npm install -g express #全局安装express模块
npm list #列出已安装模块
npm show express #显示模块详情
npm update #升级当前目录下的项目的所有模块
npm update express #升级当前目录下的项目的指定模块
npm update -g express #升级全局安装的express模块
npm uninstall express #删除指定的模块
```
## github
```bash
sudo apt-get update
sudo apt-get install git
git config --global user.name "bluhuu"
git config --global user.email "bluhuu@gmail.com"
git config --list
```
## 8.去掉默认密钥环的密码
```bash
打开应用程序－附件－密码和加密密钥（或在终端中输入 seahorse），切换到密码选项卡，会看到一个密码密钥环（我的密钥环是login），右键更改密码，然后什么都不要填，直接提交，这样就去掉默认密钥环的密码了。
```
