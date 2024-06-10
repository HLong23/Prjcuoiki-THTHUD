# Sử dụng image OpenJDK chính thức làm cơ sở
FROM openjdk:11-jre-slim

# Đặt biến môi trường cho Spark
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Cài đặt các gói phụ thuộc
RUN apt-get update && \
    apt-get install -y curl python3 python3-pip postgresql postgresql-contrib procps && \
    apt-get clean

# Sao chép và cài đặt Spark
COPY spark-3.5.1-bin-hadoop3.tgz /opt/
RUN tar -xzf /opt/spark-3.5.1-bin-hadoop3.tgz -C /opt/ && \
    rm /opt/spark-3.5.1-bin-hadoop3.tgz && \
    mv /opt/spark-3.5.1-bin-hadoop3 /opt/spark

# Sao chép script entrypoint
COPY entrypoint.sh /usr/local/bin/

# Đặt quyền thực thi cho script entrypoint
RUN chmod +x /usr/local/bin/entrypoint.sh

# Đặt entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Mở các cổng cần thiết
EXPOSE 4040 8080 7077 5432