
# fetch git

git clone git@github.com:bluhuu/ZimNotes.git

### 1. 查看远程仓库
git remote -v

### 2. 从远程获取最新版本到本地
git fetch origin master

### 3. 比较本地的仓库和远程参考的区别
git log -p master.. origin/master

### 4. 把远程下载下来的代码合并到本地仓库
git merge origin/master
方式二

### 1. 查看远程仓库
git remote -v

### 2. 从远程获取最新版本到本地
git fetch origin master:temp

### 比较本地的仓库和远程参考的区别
git diff temp

### 4. 合并temp分支到master分支
git merge temp

### 5.如果不想要temp分支了，可以删除此分支
git branch -d temp  //强制删除git branch -D <分支名>
