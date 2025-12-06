# Fabric Notebook para Ciencia de Datos y Tiempo Real

# 1️⃣ Cargar datos en PySpark desde ventas.csv
df = spark.read.format("csv").option("header", "true").load("/mnt/data/ventas.csv")
df.show(5)

# 2️⃣ Transformación de datos en PySpark
df = df.withColumn("monto", df["monto"].cast("double"))
df.createOrReplaceTempView("ventas")

# 3️⃣ Consulta SQL sobre las ventas
result = spark.sql("""
SELECT categoria, SUM(monto) AS total_ventas
FROM ventas
GROUP BY categoria
""")
result.show()

# 4️⃣ Simulación de eventos en tiempo real con JSON
import json
with open("/mnt/data/event_stream.json", "r") as f:
    eventos = json.load(f)
print("Ejemplo de evento en tiempo real:", eventos[0])

# 5️⃣ Configuración de Data Activator - Leer reglas desde JSON
with open("/mnt/data/data_activator_rules.json", "r") as f:
    reglas = json.load(f)
print("Reglas de Data Activator:", reglas)