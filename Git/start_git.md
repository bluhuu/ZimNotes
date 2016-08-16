## 获取新版本
```bash
git pull
```
## 添加文件
```bash
git add  -A
git add file1.txt file2.txt
```
## 提交
```bash
**git commit -m** "XXX"
```
## 推送
```bash
**git push origin master**
```
## 状态
```bash
**git status**
```
## 比较
```bash
**git diff**
git diff HEAD -- readme.txt
```
## 历史记录
```bash
**git log** --pretty=oneline
```
## 回退
```bash
**git reset** --hard HEAD^
git reset --hard 3628164
* HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令git reset --hard commit_id
```
## 后悔药
```bash
**git reflog**
* 查看命令历史
```
## 回到最近一次git commit或git add时的状态
```bash
**git checkout** -- file
```
## 暂存区的修改撤销掉（unstage），重新放回工作区
```bash
git reset HEAD file
```
## 删除文件
```bash
**git rm** file
```
