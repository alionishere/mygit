# 研判流程和今天讲的数据接入流程归档到：
\\nt01\平台开发部_共享_备份\02.测试专栏\24.大数据\模块总结

# 模块的需要装个工具才能看
\\nt01\平台开发部_共享_备份\02.测试专栏\24.大数据\工具

1、代码review
2、开发和测试流程培训


##############################################################################
# 模拟生成parquet文件
##############################################################################

sh /bigdata/salut/components/spark/bin/spark-shell
import org.apache.spark.sql.{Row, SaveMode}
import org.apache.spark.sql.types._

val schema =
    StructType(
      StructField("recordId", LongType, false) ::
        StructField("timestamp", LongType, false) ::
        StructField("plateCode", StringType, false) ::
        StructField("plateColor", StringType, false) ::
        StructField("tollgateCode", StringType, false) ::
        StructField("year", IntegerType, false) ::
        StructField("month", IntegerType, false) ::
        StructField("day", IntegerType, false) :: Nil
    )

val schema =
    StructType(
      StructField("recordId", LongType, false) ::
     StructField("timestamp", LongType, false) ::
        StructField("plateCode", StringType, false) ::
     StructField("plateColor", StringType, false) ::
        StructField("tollgateCode", StringType, false) ::
         StructField("laneIndex", IntegerType, false) ::
        StructField("year", IntegerType, false) ::
        StructField("month", IntegerType, false) ::
        StructField("day", IntegerType, false) :: Nil
    )

val rdd=sc.parallelize(Seq(
Row(11L,1501632601000L,"浙AA2338","蓝色","tollgate_in1",2,2017,8,2),
Row(12L,1501632601000L,"浙AA2337","蓝色","tollgate_in1",2,2017,8,2),
Row(13L,1501632601000L,"浙AA2336","蓝色","tollgate_in1",2,2017,8,2),
Row(14L,1501632601000L,"浙AA2335","蓝色","tollgate_in1",2,2017,8,2),
Row(15L,1501632601000L,"浙AA2334","蓝色","tollgate_in1",2,2017,8,2),
Row(16L,1501632601000L,"浙AA2333","蓝色","tollgate_in1",2,2017,8,2),
Row(17L,1501632601000L,"浙AA2332","蓝色","tollgate_in1",2,2017,8,2),
Row(18L,1501632601000L,"浙AA2331","蓝色","tollgate_in1",2,2017,8,2),
Row(19L,1501650601000L,"浙AA2330","蓝色","tollgate_in2",2,2017,8,2),
Row(112L,1501650601000L,"浙AA2337","蓝色","tollgate_in2",2,2017,8,2),
Row(113L,1501650601000L,"浙AA2336","蓝色","tollgate_in2",2,2017,8,2),
Row(114L,1501650601000L,"浙AA2335","蓝色","tollgate_in2",2,2017,8,2),
Row(115L,1501650601000L,"浙AA2334","蓝色","tollgate_in2",2,2017,8,2),
Row(116L,1501650601000L,"浙AA2333","蓝色","tollgate_in2",2,2017,8,2),
Row(117L,1501650601000L,"浙AA2332","蓝色","tollgate_in2",2,2017,8,2),
Row(118L,1501650601000L,"浙AA2331","蓝色","tollgate_in2",2,2017,8,2),
Row(119L,1501650601000L,"浙AA2330","蓝色","tollgate_in2",2,2017,8,2)
))


val macdf = spark.createDataFrame(rdd,schema)
macdf.write.mode(SaveMode.Append).parquet("/salut/traffic/Hrecord/Past/year=2017/month=08/day=02")

# var i = 1
while(true) {
macdf.write.mode(SaveMode.Append).parquet("/salut/traffic/Hrecord/Past/year=2017/month=07/day=13")
Thread.sleep(1000)
}

spark.read.parquet("/salut/traffic/Hrecord/Past/year=2017/month=07/day=13").show()

# 往HBase中插入数据
put 'RecordSummary','20170714','f:total','value01'

-- 删除Windows文件“造成”的'^M'字符
cat file | tr -d “\r” > new_file 或者 cat file | tr -s "\r" "\n" > new_file

part-r-00000-73ddcb4c-b0b3-42f9-943d-31741934e02b.snappy.parquet
part-r-00007-dbb6d84e-78f2-4f58-9afb-783c916e46a4.snappy.parquet

# 跟车关联分析
##############################################################################
sh /bigdata/salut/components/spark/bin/spark-shell
val df = spark.read.parquet("/salut/traffic/Hrecord/Past/year=2017/month=07/day=31")
df.createOrReplaceTempView("tbl")
val plateDF = spark.sql("select plateCode,tollgateCode,timestamp,from_unixtime(timestamp/1000) as pass_time from tbl where timestamp between 1500998400000 and 1501171200000")
val df1 = plateDF.filter("plateCode = '辽A64639'")
val df2 = plateDF.filter("plateCode != '辽A64639'")
df1.createOrReplaceTempView("df1")
df2.createOrReplaceTempView("df2")
val resdf = spark.sql("select df1.plateCode,df2.plateCode as plateCode2,tollgateCode,df1.pass_time,df2.pass_time as pass_time2 from df1 join df2 using(tollgateCode) where df1.timestamp between df2.timestamp - 6000000 and df2.timestamp + 6000000")

resdf.show
val filtres = resdf.groupBy("plateCode2").count.filter("count >= 2")
filtres.show
resdf.join(filtres,"plateCode2").filter("plateCode2 = '浙B99349'").show
select * from tbl_res where res_type_id = 31 and 
phy_res_code in ('xtgq7yhjj103','xtgq7yhjj116','xtgq7yhjj119','xtgq7yhjj101');

admin_123
津V70195
val plateDF = spark.sql("select plateCode,tollgateCode,timestamp,from_unixtime(timestamp/1000) as pass_time from relt where timestamp between 1500998400000 and 1501171200000")

spark.sql("select plateCode, row_number() over (partition by plateCode order by plateCode) as num from ss").createOrReplaceTempView("s1")
val s2 = spark.sql("select * from s1 where num = 1")
藏A22329
/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E/src/salut-rest/src/main/java/com/uniview/salut/rest/resources/PlateAnalyseResource.java
/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E/src/salut-rest/src/main/java/com/uniview/salut/viid/resources/VIIDPlateAnalyseResource.java

www.CS.williams.edu/javastructures/Welcome.html

if [ ! -z "`ip addr | grep -w inet | awk '{print $2}' | awk -F '/' '{print $1}' | grep ^"${answer}"$`" ]

##################################################################################################
nohup tmsTool.sh 10 100 200 alarm 208.208.102.212 yes &
ps -aux | grep port 

(\w+\.){2}\w+


spark.sql(s"select regexp_extract('x=a3&x=18abc&x=2&y=3&x=4','x=([0-9]+)([a-z]+)',0)")
spark.sql(s"select regexp_extract('1*2*3*4*1*3*2*1*2*3*4*7*8*5','([1][\\*][2][\\*][3])',0)").show
spark.sql(s"select split('1*2*3*4*1*3*2*1*2*3*4*7*8*5','([1][\\*][2][\\*][3])')").show

spark.sql(s"select regexp_extract('100-200', '(\\d+)-(\\d+)', 1) ").show

maven环境变量的配置：
M2_HOME
D:\Maven\apache-maven-3.3.9-bin\apache-maven-3.3.9
%M2_HOME%\bin;


# redis等录命令
./redis-cli -c -h 192.169.14.81 -p 6379 -a admin_123
# redis批量删除key方法
/bigdata/salut/components/redis/redis-cli KEYS "*[1-9]" | xargs /bigdata/salut/components/redis/redis-cli DEL 
keys *              # 取出当前所有的key
exists name         # 查看n是否有name这个key，存在返回1，否则返回0
del name            # 删除key name
expire confirm 100  # 设置confirm这个key100秒过期
ttl confirm         # 获取confirm 这个key的有效时长
echo                # 在命令行打印一些内容
select 0~15         # 编号的数据库
quit  /exit         # 退出客户端
dbsize              # 返回当前数据库中所有key的数量
info                # 返回redis的相关信息
config get dir/*    # 实时传储收到的请求
flushdb             # 删除当前选择数据库中的所有key
flushall            # 删除所有数据库中的数据库


# SQL化手动创建partition方法
[root@bigdata32 ~]# cd /bigdata/salut/components/spark/bin
[root@bigdata32 bin]# ./beeline
Beeline version 1.2.1.spark2 by Apache Hive

echo "!connect jdbc:hive2://localhost:10000/default root admin_123" | /bigdata/salut/components/spark/bin/beeline

beeline> 
!connect jdbc:hive2://localhost:10000/default

Connecting to jdbc:hive2://localhost:10000/default
Enter username for jdbc:hive2://localhost:10000/default: root ---(用户名root)
Enter password for jdbc:hive2://localhost:10000/default:       ---(密码直接回车)
17/10/13 15:13:15 INFO (Utils:310) - Supplied authorities: localhost:10000
17/10/13 15:13:15 INFO (Utils:397) - Resolved authority: localhost:10000
17/10/13 15:13:15 INFO (HiveConnection:203) - Will try to open client transport with JDBC Uri: jdbc:hive2://localhost:10000/default
Connected to: Spark SQL (version 2.1.1)
Driver: Hive JDBC (version 1.2.1.spark2)
Transaction isolation: TRANSACTION_REPEATABLE_READ
0: jdbc:hive2://localhost:10000/default> 
ALTER TABLE Hrecord ADD PARTITION (year = "2013", month = "12", day="15");  ---创建分区的语句



+---------+--+
| Result  |
+---------+--+
+---------+--+  ---表示成功
No rows selected (5.502 seconds)
0: jdbc:hive2://localhost:10000/default> show partitions hrecord; ---查看partition是否创建成功
+----------------------------+--+
|         partition          |
+----------------------------+--+

create table tb_test (
  id                int,
  name              string
)
row format delimited fields terminated by '\t'; 
create table tb_over (
  NAME              string,
  DEPARTMENT_ID     int,
  SALARY            double
)
row format delimited fields terminated by '\t'; 

load data local inpath '/root/whk/test/tb_test.txt' overwrite into table tb_test_1;
load data local inpath '/root/whk/test/tb_over.txt' overwrite into table tb_over;

select *
from tb_test_1 a
join tb_test b
on (a.id = b.id)

select *
from tb_test a
join tb_test_1 b
on (a.id = b.id)

#################################################################################################### 
# 远程调试
#################################################################################################### 
http://10.220.3.241/imos_code_bigdata/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E
java -Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y -jar salut-rest-1.2.jar
java -Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y -jar salut-spark-1.2.jar

# jetty
-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005
java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -jar start.jar jetty.http.port=80

# 主线代码 main-line
http://10.220.3.241/imos_code_bigdata/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E
链接: http://pan.baidu.com/s/1pL2WDMN 密码: 8suw

java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -jar start.jar jetty.http.port=80

# 调试spark代码
--conf "spark.driver.extraJavaOptions=‐Xdebug ‐Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y"
--conf "spark.executor.extraJavaOptions=‐Xdebug ‐Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y"

--driver-java-options "-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5018"
--driver-java-options "-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
--SPARK_JAVA_OPTS+="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"
##############################################################################

#!/bin/bash

export HOME=/root
. /etc/profile >/dev/null 2>&1
export PATH=/usr/local/bin:$PATH

#-- 检查hdfs上矩阵文件是否存在，如果存在，则删除矩阵
a=`hadoop fs -ls /salut/traffic/Graph`
echo [[ $a =~ "not exist" ]]
if [[ $a =~ "not exist" ]]; then
    echo "hdfs file: /salut/traffic/Graph exists, so delelte it."
fi

##############################################################################
# 日志查看log
##############################################################################
hadoop 日志位置
/var/log/dblog/hadoop/userlogs/

# linux 命令：
pkill -kill -t pts/2
 for i in `ps -ef | grep java | awk '{print $2}'`;do echo -n $i:; ls /proc/$i/task/ | wc -l;done


##############################################################################
# es 信息
##############################################################################
curl 'http://192.169.14.92:9200/?pretty'

##############################################################################
# pg表数据迁移
##############################################################################
/home/postgres/pgsql/bin/psql -h 192.169.14.82 -U postgres -c "select * from tbl_res" -a bigdata  
/home/postgres/pgsql/bin/pg_dump -U postgres -t test11 bigdata > ~/tmp/sqlBackup/test11.sql
psql -d databaename(数据库名) -U username(用户名) -f < 路径/文件名.sql  // sql 文件不在当前路径下
/home/postgres/pgsql/bin/psql -d bigdata -U postgres -f /root/whk/sql/test.sql  

##############################################################################
# 禁止某个IP
iptables -I INPUT -s 208.208.102.212 -j DROP
# 解封某个IP
iptables -D INPUT -s 192.169.14.93 -j DROP
##############################################################################
# pg 备份数据
pg_dump [ -h host ] [ -p port ] [ -t table ]
/home/postgres/pgsql/bin/pg_dump -h 192.169.14.92 -p 5432 -t tbl_associate_analyse -U postgres bigdata > ~/whk/pg_bak.out
/home/postgres/pgsql/bin/pg_dump -h 192.169.14.82 -p 5432 -U postgres bigdata > /home/whk/pg_bak_all.out
/home/postgres/pgsql/bin/pg_dump -h 192.169.14.82 -p 5432 -U postgres bigdata -t tbl_res inserts > /home/whk/backup/pg_bk_tbl_res_insert.out
/home/postgres/pgsql/bin/pg_dump -U postgres imos > ~/whk/backup/pg_bak_cp.out
INSERT INTO tbl_associate_analyse VALUES (1, '', '2013-12-11 00:00:00', '2013-12-18 00:00:00', 300, 11, 1, '', NULL, 4);

# pg无秘钥配置
# --格式  默认读取的是Linux登录的家目录下的文件
hostname:port:database:username:password  

cat > ~/.pgpass << EOT
*:*:*:postgres:admin_123
EOT
chmod 600 ~/.pgpass

# 每日编译 Windows上传到Linux上
put "//nt01/每日编译/平台开发部/Jenkins/Dailybuild_2014_x86/20171211/pdt/Uniview/DBE"

put Z:\20171204\pdt\Uniview\DBE\DB9500E-IMOS110-B3328.tar.gz