#!/bin/bash

# Khởi động dịch vụ PostgreSQL
service postgresql start

# Tạo người dùng và cơ sở dữ liệu PostgreSQL
su - postgres -c "psql -c \"CREATE USER sparkuser WITH PASSWORD 'sparkpassword';\""
su - postgres -c "psql -c \"CREATE DATABASE sparkdb;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE sparkdb TO sparkuser;\""

# Khởi động Spark
$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-worker.sh spark://$(hostname):7077

# Giữ container chạy
tail -f /dev/null