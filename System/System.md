## fcitx输入法
```bash
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
im-config
其它输入法：
fcitx-pinyin、fcitx-sunpinyin、fcitx-googlepinyin，fcitx-sogoupinyin
fcitx-table、fcitx-table-wubi、fcitx-table-wbpy
```

## 获取root权限
```bash
sudo -i
sudo passwd  
su root
```

## 修改hosts
```bash
sudo gedit /etc/hosts  
sudo /etc/init.d/networking restart
```
## 升级
```bash
sudo apt update  
sudo apt upgrade
```

## 删除多余的内核
```bash
dpkg -l 'linux-image-*' | grep '^ii'
sudo apt-get purge linux-image-4.2.0-27-generic
```
## 解压缩
```bash
sudo apt-get install unzip
sudo apt-get install unrar
```
## VLC媒体播放器
```bash
sudo add-apt-repository ppa:djcj/vlc-stable
sudo apt-get update
sudo apt-get install vlc
```
## Linux下的foobar2000
```bash
sudo add-apt-repository ppa:alexey-smirnov/deadbeef
or
sudo add-apt-repository ppa:starws-box/deadbeef-player
sudo apt-get update
sudo apt-get install deadbeef
```
## Guake
```bash
sudo add-apt-repository ppa:webupd8team/unstable
sudo apt-get update
sudo apt-get install guake
```
## 词典
```bash
sudo apt-get install goldendict
```
## 安装flash
```bash
https://get.adobe.com/cn/flashplayer/otherversions/
1. tar -zxvf install_flash_player_11_linux.x86_64.tar.gz
sudo cp libflashplayer.so /usr/lib/firefox/browser/plugins
sudo cp -r usr/* /usr
重启下firefox
2. sudo apt-get update
sudo apt-get install flashplugin-nonfree
```
## Adobe Reader（PDF阅读器）
```bash
sudo apt-add-repository “deb http://archive.canonical.com/ $(lsb_release -sc) partner”
sudo apt-get update
sudo apt-get install acroread
```
## htop（交互式进程查看器）
```bash
sudo apt-get install htop
```
## Caffeine（看视频时防止屏保和sleep）
```bash
sudo add-apt-repository ppa:caffeine-developers/ppa
sudo apt-get update
sudo apt-get install caffeine
```
## XMind（思维导图）
```bash
* 官方下载：http://www.xmind.net/download/linux/
sudo dpkg -i xmind-linux-3.4.0.201311050558_amd64.deb
sudo apt-get -f install
sudo dpkg -i xmind-linux-3.4.0.201311050558_amd64.deb
```
## unetbootin安装u盘启动盘
```bash
sudo add-apt-repository ppa:gezakovacs/ppa
sudo apt-get update
sudo apt-get install unetbootin
sudo mkdir /mnt/usb
sudo mount /dev/sdb1 /mnt/usb
```
## uget的安装
```bash
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo apt-get update
sudo apt-get install uget
sudo add-apt-repository ppa:t-tujikawa/ppa
sudo apt-get update
sudo apt-get install aria2
```
## 分区工具Gparted
```bash
sudo apt-get install gparted
sudo gparted
```
## 到google官网下载chrome
```bash
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install

map <C-f> scrollFullPageDown
map <C-b> scrollFullPageUp
```
