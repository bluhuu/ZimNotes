# Hadoop2.5.2集群安装

## 1、环境介绍

操作系统：CentOS X64<br>
物理机器：192.168.1.224(Master)、192.168.1.226(Slave1)、192.168.1.226(Slave2)<br>
JDK版本：JDK7.X<br>
Hadoop版本：Hadoop2.5.2

## 2、修改主机名称

通过命令"hostname"查看当前机器的机器名称，然后分别在Master、Slave1、Slave2机器的/etc/sysconfig/network文件上修改下主机名称(非必须)并保存，如下所示：

```bash
#Master机器(192.168.1.224)
NETWORKING=yes
HOSTNAME=Master

#Slave1机器(192.168.1.225)
NETWORKING=yes
HOSTNAME=Slave1

#Slave2机器(192.168.1.226)
NETWORKING=yes
HOSTNAME=Slave2
```

## 3、修改hosts文件

分别在Master、Slave1、Slave2机器上修改下hosts文件并保存，如下所示：

```bash
192.168.1.224  Master  
192.168.1.225  Slave1  
192.168.1.226  Slave2
```

## 4、确保JDK成功安装并可用

当成功在Master、Slave1、Slave2机器上安装JDK后(笔者使用JDK7.x)，还需要在"/etc/profile"文件中配置Java的环境变量，并通过命令"source "/etc/profile"命令使修改后的配置生效，如下所示：

```bash
#JAVA
export JAVA_HOME=/usr/java/jdk1.7.0_67
export PATH=$JAVA_HOME/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

## 5、Haddop的安装

使用命令"tar -zxvf"命令将gz压缩文件解压。笔者Hadoop的安装目录为："/home/hadoop"，解压后的Hadoop目录为"/home/hadoop/hadoop-2.5.2"，最好确保Master、Slave1、Slave2机器上的Hadoop安装路径一致。

## 6、配置Hadoop环境变量

成功安装Hadoop后，接下来要做的事情就是配置Hadoop的环境变量，并通过命令"source "/etc/profile"命令使修改后的配置生效，如下所示：

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

## 7、修改Hadoop的一系列配置文件

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
```

访问namenode的hdfs使用50070端口，访问datanode的webhdfs使用50075端口。要想不区分端口，直接使用namenode的IP和端口进行所有的webhdfs操作，就需要在所有的datanode上都设置hdfs-site.xml中的dfs.webhdfs.enabled为true。

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

## 8、将配置好的Hadoop拷贝到从机上

使用命令"scp -r hadoop-2.5.2 hadoop@Slave1:/home/hadoop"和"scp -r hadoop-2.5.2 hadoop@Slave2:/home/hadoop"执行数据拷贝。

## 9、启动Hadoop

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
