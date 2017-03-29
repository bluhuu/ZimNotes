# 安装Git

```bash
    sudo apt-get install git
```

## 帐户登陆1

### 设置username和email

```bash
    git config --global user.name "bluhuu"
    git config --global user.email "bluhuu@gmail.com"
```

### 一路回车就行 ~/下生成.ssh文件夹

```bash
    ssh-keygen -t rsa -C "bluhuu@gmail.com"
```

### 打开.ssh/id_rsa.pub，复制里面的key（全复制）

```bash
    回到 https://github.com/settings/keys 上，进入 Account Settings（账户配置），左边选择SSH Keys，Add SSH Key,title随便填，粘贴在你电脑上生成的key
```

### 测试： 两个都可以

```bash
    ssh git@github.com
    ssh -T git@github.com
```

### 添加github源

```bash
    git remote add origin git@github.com:XXXXX/XXXXX.git
    git push -u origin master
```

### 户名和密码

## 帐户登陆2

~/ 创建文件名为.git-credentials 文件

```bash
    touch .git-credentials
    内容：https://{username}:{password}@github.com
    git config --global credential.helper store
```
