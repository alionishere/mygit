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

admin_123

#################################################################################################### 
# 远程调试
#################################################################################################### 
http://10.220.3.241/imos_code_bigdata/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E
java -Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y -jar salut-rest-1.2.jar

# 主线代码 main-line
http://10.220.3.241/imos_code_bigdata/branches/bugfix/br_MPPV300R003B01_2014_bugfix/DB9500E
链接: http://pan.baidu.com/s/1pL2WDMN 密码: 8suw

java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 -jar start.jar jetty.http.port=80

##############################################################################
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

spark.sql(s"select regexp_extract('100-200', '([0-9]+)-(\\d+)', 1) ").show


#PG安装路径
export PG_INSTALL_DIR="/home/postgres/pgsql"
#PG data文件夹
export PG_DATA_DIR="/bigdata/salut/components/pgsql/data"
#PG archive路径
export PG_ARCHIVE_DIR="/bigdata/salut/components/pgsql/archive"
#Pgpool安装路径
export PGPOOL_INSTALL_DIR="/bigdata/salut/components/pgpool"
#postgresql命令路径
export POSTGRESQL="/bigdata/salut/bin/common/postgresql"
#虚地址
export VIP="208.208.102.99"
export VPORT=9999
# PGPOOL 运行时生成文件路径
export PGPOOL_RUN_DIR="/var/log/dblog/pgpool"
# PG 用户名密码
export PG_PASSWD="passwd"

#安装PGPOOL会用到pg_config,避免使用系统预装的老版本
export PATH="$PG_INSTALL_DIR"/bin:$PATH

以下命令在主机上操作
运行PG

$POSTGRESQL start

首次安装PGPOOL

#下载源码
wget http://www.pgpool.net/download.php?f=pgpool-II-3.6.6.tar.gz 
tar -zxf pgpool-II-3.6.6.tar.gz
cd pgpool-II-3.6.6
# 配置安装目录
./configure --prefix="$PGPOOL_INSTALL_DIR"
# 编译&安装
make && make install
# 安装 pgpool-recovery 插件
cd src/sql/pgpool-recovery
#注：pgpool-recovery 插件安装在 $PG_INSTALL_DIR 子目录下,而不是 $PGPOOL_INSTALL_DIR 子目录下
make && make install
psql -f pgpool-recovery.sql template1 -U postgres
配置

PGSQL

开启 Archiving 和 Stream Replication

#创建PG WAL日志的归档目录
mkdir $PG_ARCHIVE_DIR –p
chown postgres:postgres $PG_ARCHIVE_DIR
#修改POSTGRESQL.CONF
cat >> $PG_DATA_DIR/postgresql.conf << EOT
#是否开启standby模式下可查询,若开启，则要求 wal_level >= hot_standby
hot_standby = on

#WAL日志Level: minimal(默认) < archive < hot_standby < logical 
wal_level = hot_standby

#最大可连接的streaming客户端数，可理解为最多支持几个standby
max_wal_senders = 2

#是否进行archiving（即是否把WAL日志传输到其它地方）
archive_mode = on

#传输WAl日志所用的命令（%p代表WAL文件绝对路径，%f只代表文件名）
archive_command = 'cp "%p" "$PG_ARCHIVE_DIR/%f"'
EOT
# 为postgres用户添加Streaming 权限
sed -i '1i\host replication all 208.208.102.0/24 trust' $PG_DATA_DIR/pg_hba.conf
$POSTGRESQL restart
说明：
这种配置下，PGSQL产生的WAL日志文件会被不断归档至$PG_ARCHIVE_DIR，不过日志文件每填满16M时才会执行一次归档；
归档的文件可以之后用来进行数据恢复
PGPOOL

准备目录

mkdir $PGPOOL_RUN_DIR -p
拷贝样例配置文件

cp "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf.sample-stream "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
cp "$PGPOOL_INSTALL_DIR"/etc/pcp.conf.sample "$PGPOOL_INSTALL_DIR"/etc/pcp.conf
cp "$PGPOOL_INSTALL_DIR"/etc/pool_hba.conf.sample "$PGPOOL_INSTALL_DIR"/etc/pool_hba.conf
修改"$PGPOOL_INSTALL_DIR"/etc/pgpool.conf：
replace(){
sed -i "s|\(^$1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
sed -i "s|^#\s*\($1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
}

# PGPOOL监听地址
replace listen_addresses  '*'
# PGPOOL端口，也是虚IP对应的端口
replace port  $VPORT
# 虚IP
replace delegate_IP  $VIP
# pcp是管理PGPOOL的一个协议
replace pcp_listen_addresses  '*'
replace pcp_port 9898

#######负载均衡#######
replace load_balance_mode   off

#######运行时文件存放路径#######
replace socket_dir   $PGPOOL_RUN_DIR
replace pcp_socket_dir  $PGPOOL_RUN_DIR
replace wd_ipc_socket_dir  $PGPOOL_RUN_DIR
# PGPOOL状态文件（不是日志文件）
replace logdir   $PGPOOL_RUN_DIR
replace pid_file_name  "$PGPOOL_RUN_DIR/pgpool.pid"

############用户认证############
# 开启PGPOOL的hba验证
#    pool_hba 和 PGSQL的 hba 类似
#    但因为PGPOOL不知道用户的真实密码，所以我们需要事先把用户名和密码hash值存到pool_passwd文件中
replace enable_pool_hba   on
#pool_passwd文件名
replace pool_passwd   'pool_passwd'

############状态监测############
# [ 数据同步监测 ] ： 定时检测主从机流复制状态
#    检测时用指定用户连接PG，读取pg_current_xlog_location 和 pg_last_xlog_replay_location，相减得到从机目前滞后于主机的记录数
# 多少秒检测一次
replace sr_check_period   10
# 检测时，连接PG用的信息
replace sr_check_user   'postgres'
replace sr_check_password    $PG_PASSWD
replace sr_check_database   'postgres'

# [ 健康检测 ]：若需要failover则必须开启
#    定时去连接各个PG数据库，确保PG数据库可连接
#    多少秒检测一次
replace health_check_period   5
# 检测时，连接PG用的信息
replace health_check_user   'postgres'
replace health_check_password   $PG_PASSWD
# 若失败超过这么多次，则执行 failover 操作
replace health_check_max_retries   3
#每次重试的间隔
replace health_check_retry_delay    1
#failover命令，主要任务是promote备机成为主机
replace failover_command   "$PGPOOL_INSTALL_DIR/scripts/failover.sh %d %P %H %R"

# [ 在线恢复 ] : 恢复之前挂掉的PGSQL
#    命令：pcp_recovery_node -h $VIP  -p $PCP_PORT -U postgres -n node_id
#    内部执行步骤：CHECKPOINT，USER_SCRIPT，RECOVERY，STADNBY
#    恢复时需要连接PG执行操作，recovery_1st_stage_command脚本也是通过PG引擎执行的
replace recovery_user   'postgres'
replace recovery_password   'passwd'
replace recovery_1st_stage_command   'recovery_1st_stage'

############PGSQL############
#0号PGSQL的连接信息
replace backend_hostname0   '208.208.102.212'
replace backend_port0   5432
#负载均衡时的权重
replace backend_weight0   1
replace backend_data_directory0    $PG_DATA_DIR
replace backend_flag0   'ALLOW_TO_FAILOVER'

#1号PGSQL的连接信息
replace backend_hostname1   '208.208.102.213'
replace backend_port1   5432
#负载均衡时的权重
replace backend_weight1   1
replace backend_data_directory1   $PG_DATA_DIR
replace backend_flag1   'ALLOW_TO_FAILOVER'

############看门狗############
replace use_watchdog   true
replace wd_hostname   '208.208.102.212'
replace wd_port   9000
# 监测方法
replace wd_lifecheck_method   'heartbeat'
# 监测间隔
replace wd_interval   10
# 心跳设置
replace wd_heartbeat_port   9694
replace wd_heartbeat_deadtime   30

#########其他机器信息#########
replace heartbeat_destination0   '208.208.102.213'
replace heartbeat_destination_port0   9694
replace other_pgpool_hostname0   '208.208.102.213'
replace other_pgpool_port0   9999
replace other_wd_port0   9000

replace heartbeat_destination1   '208.208.102.42'
replace heartbeat_destination_port1   9694
replace other_pgpool_hostname1   '208.208.102.42'
replace other_pgpool_port1   9999
replace other_wd_port1   9000

#注：对于其他机器，心跳地址和PGPOOL地址一般相同，WATCH DOG的地址和PGPOOL的地址相同不用设置
生成POOL_PASSWD文件

用户名:postgres 密码:$PG_PASSWD

$PGPOOL_INSTALL_DIR/bin/pg_md5 -f $PGPOOL_INSTALL_DIR/etc/pgpool.conf -m -u postgres $PG_PASSWD
# 将会生成 $PGPOOL_INSTALL_DIR/etc/pool_passwd 文件
Note: 此处的用户名密码必须和PG里的用户密码相同
配置"$PGPOOL_INSTALL_DIR"/etc/pcp.conf：

pcp.conf里每行的含义：pcp命令(如pcp_recovery_node)的用户名：密码

echo "postgres":`$PGPOOL_INSTALL_DIR/bin/pg_md5 passwd`  > "$PGPOOL_INSTALL_DIR"/etc/pcp.conf
Note: 此处的用户名密码不必和PG里的用户密码相同
配置"$PGPOOL_INSTALL_DIR"/etc/pool_hba.conf：

cat > "$PGPOOL_INSTALL_DIR"/etc/pool_hba.conf << EOT
host    all         all           0.0.0.0/0          md5
EOT
顺序很重要：There is no “fall-through” or “backup”: if one record is chosen and the authentication fails, subsequent records are not considered. If no record matches, access is denied.
这个pool_hba验证的是客户端和PGPOOL的连接，通过后，用户任需通过pg_hba的验证
编写$PG_DATA_DIR/recovery_1st_stage

“克隆”数据库
添加recovery.conf,使PG进入恢复模式
cat > $PG_DATA_DIR/recovery_1st_stage << EOT
#!/bin/bash -x
# PG 安装目录
pghome=$PG_INSTALL_DIR
# PG 归档目录
archivedir=$PG_ARCHIVE_DIR

pgdata=\$1
remote_host=\$2
remote_pgdata=\$3
port=\$4
hostname=\$(hostname)
ssh -T "root@\$remote_host" "
    #删除现有DATA文件夹
    rm -rf \$remote_pgdata
    #通过pg_basebackup把主机的DATA恢复到本机
    \$pghome/bin/pg_basebackup -h \$hostname -U postgres -D \$remote_pgdata -x -c fast
    #初始化ARCHIVE文件夹
    mkdir -p \$archivedir
    rm -rf \$archivedir/*
    chown postgres:postgres \$archivedir -Rf
    #添加recovery.conf,使PG进入恢复模式
    cd \$remote_pgdata
    echo standby_mode = \'on\' > recovery.conf
    echo primary_conninfo = \'host="\$hostname" port=\$port user=postgres\' >> recovery.conf
    echo restore_command = \'scp root@\$hostname:\$archivedir/%f %p\' >> recovery.conf
    chown postgres:postgres \$remote_pgdata -Rf
"
EOT
chmod +x  $PG_DATA_DIR/recovery_1st_stage
编写$PG_DATA_DIR/pgpool_remote_start

cat > $PG_DATA_DIR/pgpool_remote_start << EOT
#! /bin/sh -x
remote_host=\$1
remote_pgdata=\$2
# Start recovery target PostgreSQL server
ssh -T root@\$remote_host "$POSTGRESQL start"
EOT
chmod +x $PG_DATA_DIR/pgpool_remote_start
recovery_1st_stage

从调用pg_basebackup从主机那恢复数据
设置成standby模式，之后通过Streaming与主机同步
pgpool_remote_start

远程start PG服务
这两个脚本用于已挂数据库的在线恢复，在调用pcp_recovery_node命令后会依次触发
编写failover.sh

主要作用：把PG从机promote成为主机（从机原来处于recover/standby模式）

创建目录
mkdir $PGPOOL_INSTALL_DIR/scripts/ -p
cat > $PGPOOL_INSTALL_DIR/scripts/failover.sh << EOT
#! /bin/sh -x
pghome="$PG_INSTALL_DIR"
log="$PGPOOL_RUN_DIR/failover.log"

falling_node=\$1          # %d
old_primary=\$2           # %P
new_primary=\$3           # %H
pgdata=\$4                # %R
date >> \$log
echo "failed_node_id=\$falling_node new_primary=\$new_primary" >> \$log
if [ \$falling_node = \$old_primary ]; then
    ssh -T root@\$new_primary "su postgres -c \"\$pghome/bin/pg_ctl promote -D \$pgdata\""
        exit 0;
fi;
exit 0;
EOT
chmod +x $PGPOOL_INSTALL_DIR/scripts/failover.sh
配置ssh互信

root之间互相无密码ssh访问
postgres可以无密码ssh访问root
/bin/cp /root/.ssh/ /home/postgres/ -Rf && chown postgres:postgres /home/postgres/.ssh -R
安装PGPOOL至从机

打包并在从机上解压$PG_INSTALL_DIR $PGPOOL_INSTALL_DIR

ARCHIVE_PATH="/tmp/pg_with_pool.tar.gz"
ARCHIVE_DIRS="
    $PG_INSTALL_DIR
    $PGPOOL_INSTALL_DIR
"
OTHER_PGPOOL_HOSTS="
    208.208.102.212
    208.208.102.213
"
tar -zcf  $ARCHIVE_PATH $ARCHIVE_DIRS
for addr in $OTHER_PGPOOL_HOSTS
do
        scp  $ARCHIVE_PATH  root@$addr:$ARCHIVE_PATH
        ssh root@$addr "
            /bin/rm \"$ARCHIVE_DIRS\" -Rf ;
            tar -C / -zxf \"$ARCHIVE_PATH\" ;
            mkdir -p \"$PGPOOL_RUN_DIR\";
            mkdir -p \"$PG_ARCHIVE_DIR\" && /bin/rm \"$PG_ARCHIVE_DIR/*\" -Rf && chown postgres:postgres \"$PG_ARCHIVE_DIR\";
            /bin/cp /root/.ssh/ /home/postgres/ -Rf && chown postgres:postgres /home/postgres/.ssh -R
        "
done
修改pgpool.conf中相关配置：

在 208.208.102.50 上 修改 pgpool.conf

replace(){
sed -i "s|\(^$1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
sed -i "s|^#\s*\($1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
}

replace wd_hostname  '208.208.102.42'

replace heartbeat_destination0   '208.208.102.212'
replace other_pgpool_hostname0   '208.208.102.212'

replace heartbeat_destination1   '208.208.102.213'
replace other_pgpool_hostname1   '208.208.102.213'
在 208.208.102.55 上 修改 pgpool.conf

replace(){
sed -i "s|\(^$1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
sed -i "s|^#\s*\($1\s*=\).*\$|\1 \'$2\'|g" "$PGPOOL_INSTALL_DIR"/etc/pgpool.conf
}

replace wd_hostname   '208.208.102.212'

replace heartbeat_destination0   '208.208.102.213'
replace other_pgpool_hostname0   '208.208.102.213'

replace heartbeat_destination1   '208.208.102.42'
replace other_pgpool_hostname1   '208.208.102.42'
分别在主机和从机上运行PGPOOL

$PGPOOL_INSTALL_DIR/bin/pgpool -n -D \
-f $PGPOOL_INSTALL_DIR/etc/pgpool.conf \
-a $PGPOOL_INSTALL_DIR/etc/pool_hba.conf \
-F  $PGPOOL_INSTALL_DIR/etc/pcp.conf
初始化208.208.102.55上的PGSQL备用服务器

根据 pgpool.conf，备机的node-id=1，在主机上运行：

$POSTGRESQL stop
# 这一步报错
# /bigdata/salut/components/pgpool/bin/pcp_recovery_node: error while loading shared libraries: libpcp.so.1: cannot open shared object file: No such file or directory
$PGPOOL_INSTALL_DIR/bin/pcp_recovery_node -h $VIP -U postgres -n 1

运行完成后，55上的PG将处于恢复模式（Hot standby）。

测试

免密码登录PG设置（可选）：

cat > ~/.pgpass  << EOT
*:*:*:postgres:passwd
EOT
chmod 600 ~/.pgpass
察看PGPOOL和PG状态

psql -p $VPORT -U postgres  -c "show pool_nodes" -h $VIP
shownodes.png

数据同步

TEST_DATA=0
psql -p $VPORT -U postgres  -h $VIP -d bigdata -c "UPDATE tbl_dic_type SET is_lock=$TEST_DATA;"
sleep 1
psql -p 5432 -U postgres  -h 208.208.102.52 -d bigdata -c "SELECT * from tbl_dic_type;"
sleep 1
psql -p 5432 -U postgres  -h 208.208.102.55 -d bigdata -c "SELECT * from tbl_dic_type;"
主机宕机模拟

postgresql stop && pkill pgpool
检查状态

psql -p $VPORT -U postgres  -c "show pool_nodes" -h $VIP
shownodes1s.png

主机在线恢复

$PGPOOL_INSTALL_DIR/bin/pcp_recovery_node -h $VIP -U postgres -n 0
shownodes2.png

性能测试（pgbench）

初始化

createdb  -h $VIP -p $VPORT -U postgres pgbench
注：pgbench测试时内置的 Transaction Script ( tpcb-like )

BEGIN;
UPDATE pgbench_accounts SET abalance = abalance + :delta WHERE aid = :aid;
SELECT abalance FROM pgbench_accounts WHERE aid = :aid;
UPDATE pgbench_tellers SET tbalance = tbalance + :delta WHERE tid = :tid;
UPDATE pgbench_branches SET bbalance = bbalance + :delta WHERE bid = :bid;
INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES (:tid, :bid, :aid, :delta, CURRENT_TIMESTAMP);
END;
注：scale=1 时的数据量：

pgbench=# \d
              List of relations
 Schema |       Name       | Type  |  Owner   
--------+------------------+-------+----------
 public | pgbench_accounts | table | postgres
 public | pgbench_branches | table | postgres
 public | pgbench_history  | table | postgres
 public | pgbench_tellers  | table | postgres
(4 rows)
pgbench=#  select count(*) FROM  pgbench_accounts;
 count  
--------
 100000
(1 row)
pgbench=# select pg_size_pretty(pg_database_size('pgbench'));
 pg_size_pretty 
----------------
 24 MB
(1 row)
测试

#!/bin/bash
# 测试总时间
DURATION=60
TYPES="tpcb-like select-only"
# 测试对象
BENCH_TARGET="208.208.102.55:5432 $VIP:$VPORT"
# 模拟客户端连接数量
CLIENT_NUM="1 2 4 8 16 32"
# 数据大小缩放
DATA_SCALE="1 10"

NOW=`date +%T`
OUTPUT_FILE="bench_result_T$NOW.csv"
echo "target,scale,type,clients,duration,tps" > $OUTPUT_FILE
echo "BENCHING START , DURATION:$DURATION"
for target in $BENCH_TARGET
do
    host=`echo $target | awk -F: '{print $1}'`
    port=`echo $target | awk -F: '{print $2}'`
    for scale in $DATA_SCALE
    do
        pgbench  -h $host -p $port -U postgres -s $scale -i pgbench > /dev/null 2>&1 
        for type in $TYPES
        do
            for clients in $CLIENT_NUM
            do
                echo "==============================="
                echo -e "CLIENTS_NUM:$clients\tTAGET:$host:$port\tTYPE:$type\tSCALE:$scale"
                bench_result=`pgbench  -h $host -p $port -U postgres -b $type -c $clients -T $DURATION  pgbench 2>&1`
                tps=`echo "$bench_result" | sed -n "10"p | cut -d ' ' -f 3`
                echo "$bench_result"
                echo "TPS:$tps"
                echo "$target,$scale,$type,$clients,$DURATION,$tps" >> $OUTPUT_FILE
            done
        done
    done
done
结果：

每次测试时间 : 60s
橙色：PGPOOL
蓝色：直连PG
评判指标：TPS (Transactions Per Second)
bench_result.jpg

其他小工具

查看从机和主机的同步情况（从机是否及时同步）

psql -p $VPORT -U postgres  -c "show pool_nodes" -h $VIP
# replication_delay 即主机和从机的数据间隙 ,为0表示数据完全一致
查看Watchdog状态

$PGPOOL_INSTALL_DIR/bin/pcp_watchdog_info -h $VIP -U postgres
Watchdog Cluster Information 
Total Nodes          : 3
Remote Nodes         : 2
Quorum state         : QUORUM EXIST
Alive Remote Nodes   : 2
VIP up on local node : YES
Master Node Name     : 208.208.102.50:9999 Linux dbe10250
Master Host Name     : 208.208.102.50

Watchdog Node Information 
Node Name      : 208.208.102.50:9999 Linux dbe10250
Host Name      : 208.208.102.50
Delegate IP    : 208.208.102.99
Pgpool port    : 9999
Watchdog port  : 9000
Node priority  : 1
Status         : 4
Status Name    : MASTER

Node Name      : 208.208.102.52:9999 Linux dbe10252
Host Name      : 208.208.102.52
Delegate IP    : 208.208.102.99
Pgpool port    : 9999
Watchdog port  : 9000
Node priority  : 1
Status         : 7
Status Name    : STANDBY

Node Name      : 208.208.102.55:9999 Linux bigdata55
Host Name      : 208.208.102.55
Delegate IP    : 208.208.102.99
Pgpool port    : 9999
Watchdog port  : 9000
Node priority  : 1
Status         : 7
Status Name    : STANDBY
查看PGPOOL当前配置

psql -p $VPORT -U postgres  -c "PGPOOL SHOW ALL" -h $VIP
Force a WAL segment switch

psql -p $VPORT -U postgres  -c "SELECT pg_switch_xlog();" -h $VIP
相关文档

https://www.postgresql.org/docs/9.6/static
http://www.pgpool.net/docs/latest/en/html/index.html


# 修改pg免秘钥登陆
hostname:port:database:username:password  
cat > ~/.pgpass << EOT
*:*:*:postgres:admin_123
EOT

java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005 -cp $SALUT_CLASSPATH com.uniview.salut.spark.traffic.Debug
java -Xdebug -Xbootclasspath/a:/bigdata/salut/components/jetty/resources/:$HADOOP_HOME/etc/hadoop:$HBASE_HOME/conf -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=y -jar start.jar jetty.http.port=80

<meta http-equiv="X-Frame-Options" content="deny">

/bigdata/salut/components/spark/bin/beeline -u jdbc:hive2://localhost:10000/default -n scott

CREATE TEMPORARY TABLE tb_parquet_tmp_monthly
USING org.apache.spark.sql.parquet
OPTIONS (
  path "/salut/traffic/Hrecord/Past/year=2018/month=02/"

);

# hive中创建pg表
create table haha using org.apache.spark.sql.jdbc options(url 'jdbc:postgresql://207.207.75.61:5432/bigdata', dbtable 'tbl_ttl_config', user 'postgres', password 'passwd');
# 查看Java线程是否泄漏
jps -> 查看对应线程的线程号
jstack pid | grep [泄漏的线程名]

# build spark(编译spark)
# 进入spark源码目录
sh dev/make-distribution.sh --mvn /home/bigdata/env/maven/apache-maven-3.3.9/bin/mvn --name hadoop2.7 --tgz -Phadoop-2.7 -Phive -Phive-thriftserver -Pyarn
# 官网命令spark-2.1.1
./dev/make-distribution.sh --name custom-spark --tgz -Psparkr -Phadoop-2.4 -Phive -Phive-thriftserver -Pmesos -Pyarn

# cloudera 仓库repository
https://repository.cloudera.com/artifactory/cloudera-repos/

# 资源管理控制
# yarn队列提交spark任务权限控制
https://www.cnblogs.com/xiaodf/p/6266201.html
http://lxw1234.com/archives/2015/10/536.htm
http://lxw1234.com/archives/2016/06/696.htm

# docker操作
export https_proxy=http://207.207.30.7:8001
export http_proxy=http://207.207.30.7:8001
docker run -p 4000:80 demo:v1
docker run -p 80:80 demo:v1
docker run -p 8800:80 demo:v1
docker run -it -p 4000:80 demo:v1   /bin/bash
docker run -it --rm -v /home/whk/app/docker:/app -p 4000:80 demo2:v2   /bin/bash
docker run -it --rm -v /share:/share -p 4000:80 demo:v1   /bin/bash

# 创建新Linux用户
useradd -u 544 -d /usr/other3  -g other -m  other3
