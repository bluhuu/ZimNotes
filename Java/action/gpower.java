import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class GpowerTransfer{

	private static final String QUOREM = "192.168.103.50,192.168.103.51,192.168.103.52,192.168.103.53,192.168.103.54,192.168.103.55,192.168.103.56,192.168.103.57,192.168.103.58,192.168.103.59,192.168.103.60";//这里是你HBase的分布式集群结点，用逗号分开。
	private static final String CLIENT_PORT = "2181";//端口
	private static Logger log = Logger.getLogger(GpowerTransfer.class);

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		BasicConfigurator.configure();
		log.setLevel(Level.DEBUG);
		String tableName = "kpi";//HBase表名称
		Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum", QUOREM);
        conf.set("hbase.zookeeper.property.clientPort", CLIENT_PORT);
        try { File workaround = new File(".");
            System.getProperties().put("hadoop.home.dir", workaround.getAbsolutePath());
            new File("./bin").mkdirs();
            new File("./bin/winutils.exe").createNewFile();//这几段奇怪的代码在windows跑的时候不加有时候分报错，在web项目中可以不要,但单独的java程序还是加上去吧，知道什么原因的小伙伴可以告诉我一下，不胜感激。
			HBaseAdmin admin = new HBaseAdmin(conf);
			if(admin.tableExists(tableName)){
				Class.forName("com.mysql.jdbc.Driver");//首先将mysql中的数据读取出来，然后再插入到HBase中
				String url = "jdbc:mysql://192.168.***.***:3306/midb?useUnicode=true&amp;characterEncoding=utf-8";
				String username = "********";
				String password = "********";
				Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement pstmt = con.prepareStatement("select * from kpi_gpower");
				ResultSet rs = pstmt.executeQuery();
				HTable table = new HTable(conf, tableName);
				log.debug(tableName + ":start copying data to hbase...");
				List<Put> list = new ArrayList<Put>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				String base = "base";//family名称
				String gpower = "gpower";//family名称
				String[] qbase = {"fid","tid","date"};//qualifier名称
				String[] qgpower = {"power","windspeed","unpower","theory","coup"};//qualifier名称
				while(rs.next()){
				    String rowKey = rs.getString("farmid") + ":" + (rs.getInt("turbineid")<10?("0"+rs.getInt("turbineid")):rs.getInt("turbineid")) + ":" + sdf.format(rs.getDate("vtime"));//拼接rowkey
				    Put put = new Put(Bytes.toBytes(rowKey));//新建一条记录，然后下面对相应的列进行赋值
				    put.add(base.getBytes(), qbase[0].getBytes(), Bytes.toBytes(rs.getString("farmid")));//base:fid
				    put.add(base.getBytes(), qbase[1].getBytes(), Bytes.toBytes(rs.getInt("turbineid")+""));//base:tid
				    put.add(base.getBytes(), qbase[2].getBytes(), Bytes.toBytes(rs.getDate("vtime")+""));//base:date
				    put.add(gpower.getBytes(), qgpower[0].getBytes(), Bytes.toBytes(rs.getFloat("value")+""));//gpower:power
				    put.add(gpower.getBytes(), qgpower[1].getBytes(), Bytes.toBytes(rs.getFloat("windspeed")+""));//gpower:windspeed
				    put.add(gpower.getBytes(), qgpower[2].getBytes(), Bytes.toBytes(rs.getFloat("unvalue")+""));//gpower:unvalue
				    put.add(gpower.getBytes(), qgpower[3].getBytes(), Bytes.toBytes(rs.getFloat("theory")+""));//gpower:theory
				    put.add(gpower.getBytes(), qgpower[4].getBytes(), Bytes.toBytes(rs.getFloat("coup")+""));//gpower:coup
				    list.add(put);
				}
				table.put(list);//这里真正对表进行插入操作
				log.debug(tableName + ":completed data copy!");
				table.close();//这里要非常注意一点，如果你频繁地对表进行打开跟关闭，性能将会直线下降，可能跟集群有关系。
			}else{
				admin.close();
				log.error("table '" + tableName + "' not exisit!");
				throw new IllegalArgumentException("table '" + tableName + "' not exisit!");
			}
			admin.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
