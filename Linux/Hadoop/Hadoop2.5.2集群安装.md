# Hadoop2.5.2集群安装

## 1、环境介绍

操作系统：CentOS X64<br>
物理机器：192.168.1.224(Master)、192.168.1.225(Slave1)、192.168.1.226(Slave2)<br>
JDK版本：JDK7.X<br>
Hadoop版本：Hadoop2.5.2

## 2、配置ssh

我们需要对ssh服务进行配置。即NameNode节点需要能够ssh无密码登录访问DataNode节点进入NameNode服务，输入如下命令:

```bash
[root@localhost hadoop]# cd ~  
[root@localhost ~]# cd .ssh/  
[root@localhost .ssh]# ssh-keygen -t rsa -P ''
```

一直回车。.ssh目录下多出两个文件<br>
私钥文件：id_rsa<br>
公钥文件：id_rsa.pub<br>
复制id_rsa.pub文件为authorized_keys

```bash
[root@localhost .ssh]# cp id_rsa.pub authorized_keys
```

将公钥文件authorized_keys分发到各DataNode节点：

```bash
[root@localhost .ssh]# scp authorized_keys root@10.0.1.201:/root/.ssh/  
[root@localhost .ssh]# scp authorized_keys root@10.0.1.202:/root/.ssh/
```

注意：如果当前用户目录下没有.ssh目录，可以自己创建一个该目录<br>
验证ssh无密码登录：

```bash
[root@localhost .ssh]# ssh root@10.0.1.201  
Last login: Mon Jan  5 09:46:01 2015 from 10.0.1.100
```

看到以上信息，表示配置成功！如果还提示要输入密码，则配置失败。

## 3、修改主机名称

通过命令"hostname"查看当前机器的机器名称，然后分别在Master、Slave1、Slave2机器的/etc/sysconfig/network文件上修改下主机名称(非必须)并保存，如下所示：

```bash
#Master机器(192.168.1.224)
NETWORKING=yes
HOSTNAME=Master
#GATEWAY=192.168.20.1

#Slave1机器(192.168.1.225)
NETWORKING=yes
HOSTNAME=Slave1

#Slave2机器(192.168.1.226)
NETWORKING=yes
HOSTNAME=Slave2
```

## 4、修改hosts文件

分别在Master、Slave1、Slave2机器上修改下hosts文件并保存，如下所示：

```bash
192.168.1.224  Master  
192.168.1.225  Slave1  
192.168.1.226  Slave2
```

## 5、确保JDK成功安装并可用

当成功在Master、Slave1、Slave2机器上安装JDK后(笔者使用JDK7.x)，还需要在"/etc/profile"文件中配置Java的环境变量，并通过命令"source /etc/profile"命令使修改后的配置生效，如下所示：

```bash
#JAVA
export JAVA_HOME=/usr/java/jdk1.7.0_67
export PATH=$JAVA_HOME/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

## 6、Haddop的安装

使用命令"tar -zxvf"命令将gz压缩文件解压。笔者Hadoop的安装目录为："/home/hadoop"，解压后的Hadoop目录为"/home/hadoop/hadoop-2.5.2"，最好确保Master、Slave1、Slave2机器上的Hadoop安装路径一致。

## 7、配置Hadoop环境变量

成功安装Hadoop后，接下来要做的事情就是配置Hadoop的环境变量，并通过命令"source /etc/profile"命令使修改后的配置生效，如下所示：

```bash
#HADOOP
export HADOOP_HOME=/home/hadoop/hadoop-2.5.2
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export CLASSPATH=.:$JAVA_HOME/lib:$HADOOP_HOME/lib:$CLASSPATH
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```

## 8、修改Hadoop的一系列配置文件

/home/hadoop/hadoop-2.5.2/etc/hadoop/core-site.xml修改，如下所示：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://Master:9000</value>
    </property>
</configuration>
<!--
<configuration>
 <property>
   <name>hadoop.tmp.dir</name>
   <value>/home/chcit/chcit-hadoop/hadoop-2.5.2/tmp</value>
   <description>Abase for other temporary directories</description>
 </property>
 <property>    
   <name>fs.defaultFS</name>
   <value>hdfs://chcit-2:9000</value>
 </property>
 <property>
    <name>io.file.buffer.size</name>
    <value>4096</value>
 </property>
</configuration>
 -->
```

/home/hadoop/hadoop-2.5.2/etc/hadoop/hdfs-site.xml修改，如下所示：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>dfs.replication</name>  
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>        
        <value>/home/hadoop/dfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>>/home/hadoop/dfs/data</value>
    </property>
    <property>
        <name>dfs.webhdfs.enabled</name>
        <value>true</value>
    </property>  
</configuration>
<!--
<configuration>
  <property>  
    <name>dfs.nameservices</name>  
    <value>chcit-2</value>
  </property>  
  <property>  
    <name>dfs.namenode.secondary.http-address</name>  
    <value>chcit-3:50090</value>  
  </property>  
  <property>  
    <name>dfs.namenode.name.dir</name>
    <value>file:///home/chcit/chcit-hadoop/hadoop-2.5.2/dfs/name</value>  
  </property>  
  <property>  
    <name>dfs.datanode.data.dir</name>
    <value>file:///home/chcit/chcit-hadoop/hadoop-2.5.2/dfs/data</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
  <property>  
    <name>dfs.webhdfs.enabled</name>  
    <value>true</value>  
   </property>  
</configuration>
 -->
```

访问namenode的hdfs使用50070端口，访问datanode的webhdfs使用50075端口。要想不区分端口，直接使用namenode的IP端口进行所有的webhdfs操作，就需要在所有的datanode上都设置hdfs-site.xml中的dfs.webhdfs.enabled为true。

/home/hadoop/hadoop-2.5.2/etc/hadoop/mapred-site.xml修改，如下所示：

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>Master:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>Master:19888</value>
    </property>
</configuration>
<!--
<configuration>
 <property>
  <name>mapreduce.framework.name</name>
  <value>yarn</value>
 </property>
 <property>  
  <name>mapreduce.jobtracker.http.address</name>  
  <value>chcit-2:50030</value>  
 </property>  
 <property>  
  <name>mapreduce.jobhistory.address</name>
  <value>chcit-2:10020</value>  
 </property>
 <property>  
  <name>mapreduce.jobhistory.webapp.address</name>
  <value>chcit-2:19888</value>
 </property>  
 -->
```

jobhistory是Hadoop自带了一个历史服务器，用于记录Mapreduce历史作业。默认情况下，jobhistory没有启动，可用手动通过命令启动，如下所示：

```bash
jobhistory-daemon.sh start historyserver
```

/home/hadoop/hadoop-2.5.2/etc/hadoop/yarn-site.xml修改，如下所示：

```xml
<?xml version="1.0"?>
<configuration>
     <property>  
        <name>yarn.nodemanager.aux-services</name>  
        <value>mapreduce_shuffle</value>  
     </property>  
     <property>  
        <name>yarn.resourcemanager.address</name>  
        <value>Master:8032</value>  
     </property>  
     <property>  
        <name>yarn.resourcemanager.scheduler.address</name>  
        <value>Master:8030</value>  
     </property>  
     <property>  
        <name>yarn.resourcemanager.resource-tracker.address</name>  
        <value>Master:8031</value>  
     </property>  
     <property>  
        <name>yarn.resourcemanager.admin.address</name>  
        <value>Master:8033</value>  
     </property>  
     <property>  
        <name>yarn.resourcemanager.webapp.address</name>  
        <value>Master:8088</value>  
     </property>  
</configuration>
```

/home/hadoop/hadoop-2.5.2/etc/hadoop/slaves修改，如下所示：

```bash
Slave1
Slave2
```

分别在/home/hadoop/hadoop-2.5.2/etc/hadoop/hadoop-env.sh和yarn-env.sh中配置Java环境变量，如下所示：

```bash
export JAVA_HOME=/usr/java/jdk1.7.0_67
```

## 9、将配置好的Hadoop拷贝到从机上

使用命令"scp -r hadoop-2.5.2 hadoop@Slave1:/home/hadoop"和"scp -r hadoop-2.5.2 hadoop@Slave2:/home/hadoop"执行数据拷贝。

## 10、启动Hadoop

在正式 启动Hadoop之前，分别在Master、Slave1、Slave2机器上格式化HDFS，如下所示：

```bash
hdfs namenode –format
```

当成功格式化后，接下来便可以在Master上通过命令"start-all.sh"启动Hadoop，同时也可以通过"stop-all.sh"停止Hadoop运行(会由Master负责带动Slave节点的启动和停止)。

当成功启动Hadoop后，我们便可以在每一个节点下执行命令jps，查看Hadoop的进程，如下所示：

```bash
#Master上的Hadoop进程
30791 SecondaryNameNode
30943 ResourceManager
30607 NameNode

#Slave1上的Hadoop进程
9902 DataNode
10001 NodeManager

#Slave2上的Hadoop进程
9194 DataNode
9293 NodeManager
```

除此之外，开发人员还可以通过<http://ip:50070>、<http://ip:8088>、<http://ip:19888>，通过浏览器查阅Hadoop集群中每一个节点的运行状态。

### 备注

```bash
启动
sbin/start-dfs.sh  
sbin/start-yarn.sh  
停止
sbin/stop-dfs.sh  
sbin/stop-yarn.sh
```

## 11、单独重启丢失的DataNode节点

如果某个DataNode节点Dead（由于死机或人为原因等），可以在不重启整个Hadoop服务的情况下进行单独重启。方法如下：<br>
在NameNode的hadoop-2.5.2/sbin目录下，执行命令启动HDFS DataNode

```bash
./hadoop-daemons.sh start datanode
./yarn-daemons.sh start nodemanager
```

也可以单独启动NameNode节点，命令如下：

```bash
./hadoop-daemon.sh start namenode
./yarn-daemon.sh start resourcemanager
```

上述四个命令都可以指定--config参数，后面跟hadoop的集群配置文件所在目录（即$HADOOP_HOME/etc/hadoop），大家可通过参数-h查看命令帮助信息<br>
注意：上面命令不会影响已经启动的hdfs或yarn服务，只会把丢失节点的服务启动起来。

## 12、特别说明

特别说明下，上面配置主服务器的slaves文件，使用的是ip配置，此时需要在主服务器的/etc/hosts中增加ip到主机名的映射如下：<br>
[plain] view plain copy<br>
10.0.1.201 anyname1<br>
10.0.1.202 anyname2<br>
否则，可能在执行start-dfs.sh命令时，从服务器的DateNode节点打印如下错误日志：<br>
2015-01-16 17:06:54,375 ERROR org.apache.hadoop.hdfs.server.datanode.DataNode: Initialization failed for Block pool BP-1748412339-10.0.1.212-1420015637155 (Datanode Uuid null) service to /10.0.1.218:9000 Datanode denied communication with namenode because hostname cannot be resolved (ip=10.0.1.217, hostname=10.0.1.217): DatanodeRegistration(0.0.0.0, datanodeUuid=3ed21882-db82-462e-a71d-0dd52489d19e, infoPort=50075, ipcPort=50020, storageInfo=lv=-55;cid=CID-4237dee9-ea5e-4994-91c2-008d9e804960;nsid=358861143;c=0)<br>
大意是无法将ip地址解析成主机名，也就是无法获取到主机名，需要在/etc/hosts中进行指定。<br>
本文章参照了<http://blog.csdn.net/greensurfer/article/details/39450369>
