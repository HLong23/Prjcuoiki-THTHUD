from pyspark.sql import SparkSession

# Cấu hình Spark session
spark = SparkSession.builder \
    .appName("Spark PostgreSQL") \
    .config("spark.jars", "C:\Users\lamtu\spark-sql-docker\postgresql-42.7.3.jar") \
    .getOrCreate()

# Đọc dữ liệu từ PostgreSQL
df = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:postgresql://localhost:5432/sparkdb") \
    .option("dbtable", "sample_table") \
    .option("user", "sparkuser") \
    .option("password", "sparkpassword") \
    .option("driver", "org.postgresql.Driver") \
    .load()

df.show()