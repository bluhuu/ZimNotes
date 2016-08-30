# Hadoop安装
## 下载
wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.5.2/hadoop-2.5.2.tar.gz
mv hadoop-2.5.2.tar.gz /opt/
cd /opt/
tar -zxvf hadoop-2.5.2.tar.gz
cd hadoop-2.5.2/conf/

## vim hadoop-env.sh
```bash
export JAVA_HOME=/usr/lib/jvm
#echo $JAVA_HOME
```
## vim core-site.xml
```xml
<configuration>
<property>
<name>hadoop.tmp.dir</name>
<value>/hadoop</value>
</property>

<property>
<name>dfs.name.dir</name>
<value>/hadoop/name</value>
</property>

<property>
<name>fs.default.name</name>
<value>hdfs://imooc:9000</value>
</property>

</configuration>
```
## vim hdfs-site.xml
```xml
<configuration>
<property>
<name>dfs.data.dir</name>
<value>/hadoop/data</value>
</property>

</configuration>
```
## vim mapred-site.xml
```xml
<configuration>
<property>
<name>mapred.job.tracker</name>
<value>imooc:9001</value>
</property>

</configuration>
```
## vim /etc/profile
```bash
export HADOOP_HOME=/opt/hadoop-2.5.2
#修改下行
export PATH=${JAVA_HOME}/bin:${HADOOP_HOME}/bin:$PATH
source /etc/profile
```
## hadoop namenode -format
## start-all.sh
```bash
使用jps查看hadoop是否正常运行
```
## hadoop fs -ls / 查看hadoop文件系统
## hadoop fs -mkdir input 创建input文件夹 /user/root/input
## hadoop fs -put hadoop-env.sh input/ 把文件放入input文件夹
## hadoop fs -cat input/hadoop-env.sh 查看文件
## hadoop fs -get input/hadoop-env.sh hadoop-env2.sh 获取文件并命名
## hadoop fs -rm input/hadoop-env.sh 删除文件
## hadoop dfsadmin -report 获取文件系统信息
