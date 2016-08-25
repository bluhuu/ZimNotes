# Hadoop安装
##下载
wget http://mirrors.cnnic.cn/apache/hadoop/common/hadoop-2.5.2/hadoop-2.5.2.tar.gz
mv hadoop-2.5.2.tar.gz /opt/
cd /opt/
tar -zxvf hadoop-2.5.2.tar.gz
cd hadoop-2.5.2/conf/

vim hadoop-env.sh
```bash
export JAVA_HOME=/usr/lib/jvm
#echo $JAVA_HOME
```
vim core-site.xml
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
vim hdfs-site.xml
```xml
<configuration>
<property>
<name>dfs.data.dir</name>
<value>/hadoop/data</value>
</property>

</configuration>
```
vim mapred-site.xml
```xml
<configuration>
<property>
<name>mapred.job.tracker</name>
<value>imooc:9001</value>
</property>

</configuration>
```
vim /etc/profile
