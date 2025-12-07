
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
