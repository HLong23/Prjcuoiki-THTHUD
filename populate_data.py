import psycopg2
import random

conn = psycopg2.connect(
    dbname="sparkdb",
    user="sparkuser",
    password="sparkpassword",
    host="localhost"
)
cur = conn.cursor()

cur.execute("""
    CREATE TABLE sample_data (
        id SERIAL PRIMARY KEY,
        value INTEGER
    );
""")

for _ in range(1000000):
    cur.execute("INSERT INTO sample_data (value) VALUES (%s)", (random.randint(1, 100),))

conn.commit()
cur.close()
conn.close()