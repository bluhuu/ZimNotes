# github下fork后同步源的新更新

## 首先要先确定一下是否建立了主repo的远程源
> git remote -v

## 配置上游项目地址。即将你 fork 的项目的地址给配置到自己的项目上。比如我 fork 了一个项目，原项目是 wabish/fork-demo.git，我的项目就是 bluhuu/fork-demo.git
> git remote add upstream https://github.com/wabish/fork-demo.git  
> git remote -v

## 获取上游项目更新。使用 fetch 命令更新，fetch 后会被存储在一个本地分支 upstream/master 上
> git fetch upstream

## 合并到本地分支。切换到 master 分支，合并 upstream/master 分支
> git merge upstream/master

## 提交推送。根据自己情况提交推送自己项目的代码
> git push origin master