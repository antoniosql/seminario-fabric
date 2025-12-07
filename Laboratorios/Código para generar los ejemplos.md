
# 1️⃣ Creación de datasets para la Arquitectura Medallón (Bronce, Plata y Oro)

# Dataset de capa Bronce (Datos en crudo)
bronce_data = {
    "id_transaccion": range(1, 101),
    "cliente_id": [f"C{str(i).zfill(3)}" for i in range(1, 101)],
    "monto": [round(abs(100 + (i * 3.5) - (i % 7) * 25), 2) for i in range(1, 101)],
    "categoria": ["Electrónica", "Ropa", "Alimentos", "Hogar", "Salud"] * 20,
    "fecha": pd.date_range(start="2024-01-01", periods=100, freq="D").strftime("%Y-%m-%d"),
    "estado": ["pendiente", "completado", "rechazado"] * 33 + ["pendiente"]
}

df_bronce = pd.DataFrame(bronce_data)
bronce_csv_path = "/mnt/data/bronce.csv"

df_bronce.to_csv(bronce_csv_path, index=False)

# Dataset de capa Plata (Limpieza y transformación aplicada)
df_plata = df_bronce[df_bronce["estado"] != "rechazado"].copy()
df_plata.drop(columns=["estado"], inplace=True)
plata_csv_path = "/mnt/data/plata.csv"

df_plata.to_csv(plata_csv_path, index=False)

# Dataset de capa Oro (Datos agregados y optimizados)
df_oro = df_plata.groupby("categoria").agg({"monto": "sum"}).reset_index()
oro_csv_path = "/mnt/data/oro.csv"

df_oro.to_csv(oro_csv_path, index=False)

# Mostrar dataset Bronce para revisión
import ace_tools as tools
tools.display_dataframe_to_user(name="Bronce Dataset", dataframe=df_bronce)

bronce_csv_path, plata_csv_path, oro_csv_path

# 2️⃣ Creación del dataset para Lakehouse en Fabric

lakehouse_data = {
    "id_cliente": [f"C{str(i).zfill(3)}" for i in range(1, 101)],
    "nombre": [f"Cliente {i}" for i in range(1, 101)],
    "edad": [25 + (i % 15) for i in range(1, 101)],
    "pais": ["España", "México", "Argentina", "Chile", "Colombia"] * 20,
    "saldo": [round(abs(5000 + (i * 200) - (i % 6) * 300), 2) for i in range(1, 101)],
    "fecha_registro": pd.date_range(start="2020-01-01", periods=100, freq="M").strftime("%Y-%m-%d")
}

df_lakehouse = pd.DataFrame(lakehouse_data)
lakehouse_csv_path = "/mnt/data/lakehouse.csv"

df_lakehouse.to_csv(lakehouse_csv_path, index=False)

# Mostrar dataset generado
tools.display_dataframe_to_user(name="Lakehouse Dataset", dataframe=df_lakehouse)

lakehouse_csv_path

# 3️⃣ Creación del dataset para Data Warehouse en Fabric

data_warehouse_data = {
    "id_venta": range(1, 101),
    "producto": ["Laptop", "Teléfono", "Tablet", "Auriculares", "Smartwatch"] * 20,
    "cantidad": [1, 2, 1, 3, 2] * 20,
    "precio_unitario": [800, 500, 300, 150, 200] * 20,
    "total": [800, 1000, 300, 450, 400] * 20,
    "fecha_venta": pd.date_range(start="2024-01-01", periods=100, freq="D").strftime("%Y-%m-%d")
}

df_data_warehouse = pd.DataFrame(data_warehouse_data)
data_warehouse_csv_path = "/mnt/data/data_warehouse.csv"

df_data_warehouse.to_csv(data_warehouse_csv_path, index=False)

# Generar script SQL para la carga de datos en Data Warehouse
data_warehouse_sql = """
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    producto VARCHAR(50),
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    total DECIMAL(10,2),
    fecha_venta DATE
);

COPY INTO ventas FROM '/mnt/data/data_warehouse.csv'
WITH (FORMAT = 'CSV', HEADER = TRUE);
"""

data_warehouse_sql_path = "/mnt/data/data_warehouse.sql"
with open(data_warehouse_sql_path, "w") as f:
    f.write(data_warehouse_sql)

# Mostrar dataset de Data Warehouse
tools.display_dataframe_to_user(name="Data Warehouse Dataset", dataframe=df_data_warehouse)

data_warehouse_csv_path, data_warehouse_sql_path


# 2️⃣ Simulación de eventos en tiempo real (JSON para EventStream)
event_stream_data = [
    {"evento_id": i, "sensor": f"sensor_{i%5}", "valor": round(50 + (i % 7) * 3.5, 2), "timestamp": f"2024-01-01T12:{str(i).zfill(2)}:00Z"}
    for i in range(1, 51)
]

event_stream_json_path = "/mnt/data/event_stream.json"

# Guardar datos de eventos en formato JSON
import json
with open(event_stream_json_path, "w") as f:
    json.dump(event_stream_data, f, indent=4)

# 3️⃣ Configuración de reglas para Data Activator (JSON)
data_activator_rules = {
    "trigger": "data_activator_event",
    "action": {
        "type": "send_notification",
        "destination": "Microsoft Teams",
        "message": "Se ha detectado una anomalía en los datos."
    },
    "condition": {
        "field": "monto",
        "operator": ">",
        "value": 10000
    }
}

data_activator_json_path = "/mnt/data/data_activator_rules.json"

# Guardar reglas de Data Activator en JSON
with open(data_activator_json_path, "w") as f:
    json.dump(data_activator_rules, f, indent=4)

# Confirmar archivos generados
event_stream_json_path, data_activator_json_path
