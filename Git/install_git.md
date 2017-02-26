# 在Linux上安装Git
```bash
	sudo apt-get install git
	git config --global user.name "bluhuu"
	git config --global user.email "bluhuu@gmail.com"
	ssh-keygen -t rsa -C "bluhuu@gmail.com"
	ssh git@github.com
```
## 添加github源
```bash
	git remote add origin git@github.com:XXXXX/XXXXX.git
	git push -u origin master
```

## 户名和密码
1.方法一
在C:\users\Administrator 创建文件名为.git-credentials 的文件
```bash
    touch .git-credentials
    内容：https://{username}:{password}@github.com
    git config --global credential.helper store
```
