## 一.环境介绍：
sqoop版本:1.99.4-hadoop200  
hadoop版本:hadoop2.2.0  
安装路径是/usr/local/sqoop  
## 二.sqoop1.99.4安装
### 1.解压安装文件到/usr/local/sqoop目录
### 2.修改环境变量 sudo vi /etc/profile

```bash
export SQOOP_HOME=/usr/local/sqoop  
export PATH=$SQOOP_HOME/bin:$PATH  
export CATALINA_HOME=$SQOOP_HOME/server  
export LOGDIR=$SQOOP_HOME/logs
```

使立即生效：source /etc/profile

### 3.修改sqoop配置文件
#### (1)修改/usr/local/sqoop/server/conf/sqoop.properties
org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/usr/local/hadoop2.2.0/etc/hadoop #hadoop的安装目录中的配置目录
#### (2)修改/usr/local/sqoop/server/conf/catalina.properties
common.loader=/usr/local/sqoop/hadoop_lib     #需要用到的Jar包目录(也可以直接引用多个目录，用‘，’隔开)

### 4.成立Jar包目录
#### (1)在sqoop根目录下新建文件夹hadoop_lib
#### (2)把hadoop相关依赖jar包拷贝到该目录
```bash
/usr/local/hadoop2.2.0/share/hadoop/common/*.jar
/usr/local/hadoop2.2.0/share/hadoop/common/lib/*.jar
/usr/local/hadoop2.2.0/share/hadoop/hdfs/*.jar
/usr/local/hadoop2.2.0/share/hadoop/hdfs/lib/*.jar
/usr/local/hadoop2.2.0/share/hadoop/mapreduce/*.jar
/usr/local/hadoop2.2.0/share/hadoop/mapreduce/lib/*.jar
/usr/local/hadoop2.2.0/share/hadoop/tools/*.jar
/usr/local/hadoop2.2.0/share/hadoop/tools/lib/*.jar
/usr/local/hadoop2.2.0/share/hadoop/yarn/*.jar
/usr/local/hadoop2.2.0/share/hadoop/yarn/lib/*.jar
/usr/local/hadoop2.2.0/share/hadoop/httpfs/tomcat/lib/*.jar
```
#### (3)把/usr/local/sqoop/server/bin/*.jar和/usr/local/sqoop/server/lib/*.jar拷贝到该目录

### 5.赋予权限
sqoop.sh默认是没有运行权限的，所以需要给sqoop.sh赋予运行权限  
sudo chmod 777 /usr/local/sqoop/bin/sqoop.sh  
运行sqoop.sh,此时会提示另外一个脚本没有运行,可根据提示赋予权限给相应文件  
如果嫌麻烦，可以用一个一劳永逸的方法，就是把整个sqoop目录赋予所有权限。  
sudo chmod 777 -R /usr/loacl/sqoop  

### 6.工具验证
```bash
cd /usr/local/sqoop/bin  
./sqoop2-tool verify
```

### 7.启动sqoop server
```bash
cd /usr/local/sqoop/bin  
./sqoop2-server start
```
### 8.查看日志文件，如果日志文件没有报错，说明sqoop启动成功，否则启动失败

```bash
cat /usr/local/sqoop/server/logs/catalina.out
```

### 7.进入客户端shell
```bash
cd /usr/local/sqoop/bin
./sqoop2-shell
```
## 三.sqoop1.99.4的使用
### 1.配置客户端使用服务：set server --host 127.0.0.1 --port 12000 --webapp sqoop
### 2.建立连接
#### (1)建立JDBC连接
```bash
create link --cid 1 #我的是1，可以通过show connector查看
Please fill following values to create new link object
Name: First Link

Link configuration
JDBC Driver Class: com.mysql.jdbc.Driver
JDBC Connection String: jdbc:mysql://localhost:3306/database
Username: sqoop
Password: *****
JDBC Connection Properties:
There are currently 0 values in the map:
entry#protocol=tcp
New link was successfully created with validation status OK and persistent id 1
```

#### (2)建立HDFS连接
```bash
create link --cid 2
Creating link for connector with id 1
Please fill following values to create new link object
Name: Second Link

Link configuration HDFS URI: hdfs://nameservice1:8020/
New link was successfully created with validation status OK and persistent id 2
```
### 3.创建任务
```bash
sqoop:000> create job -f 1 -t 2
 Creating job for links with from id 1 and to id 2
 Please fill following values to create new job object
 Name: Sqoopy

 FromJob configuration

  Schema name:(Required)sqoop
  Table name:(Required)sqoop
  Table SQL statement:(Optional)
  Table column names:(Optional)
  Partition column name:(Optional) id
  Null value allowed for the partition column:(Optional)
  Boundary query:(Optional)

ToJob configuration

 Output format:
  0 : TEXT_FILE
  1 : SEQUENCE_FILE
      Output format:
        0 : TEXT_FILE
        1 : SEQUENCE_FILE
      Choose: 0
      Compression format:
        0 : NONE
        1 : DEFAULT
        2 : DEFLATE
        3 : GZIP
        4 : BZIP2
        5 : LZO
        6 : LZ4
        7 : SNAPPY
        8 : CUSTOM
      Choose: 0
      Custom compression format:(Optional)
      Output directory:(Required)/root/projects/sqoop

      Driver Config

      Extractors: 2
      Loaders: 2
      New job was successfully created with validation status OK  and persistent id 1
```

### 4.开始任务
```bash
start job --jid 1
附属常用shell命令：
1.查看版本号：show version --all
2.建立连接：create link --cid 1/2  #1代表jdbc连接，2代表hdfs连接，可用show connector查看  
3.建立job：create job --f 1 --t 2  #link1导数据到link2
4.启动Job：start job --jid 1
5.查看Job状态:status job --jid 1
6.查看连接:show link
7.查看job:show job
8.查看连接器：show connector  #查看连接器的id号，用于建立连接
9.配置客户端使用服务：set server --host 127.0.0.1 --port 12000 --webapp sqoop
```
