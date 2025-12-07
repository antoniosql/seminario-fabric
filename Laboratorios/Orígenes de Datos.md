Northwind como OData
https://services.odata.org/v4/northwind/northwind.svc/ 

Orders CSV
https://raw.githubusercontent.com/MicrosoftLearning/dp-data/main/orders.csv

WWI- DW como ZIP
https://assetsprod.microsoft.com/en-us/wwi-sample-dataset.zip

Origen Azure Blob
https://fabrictutorialdata.blob.core.windows.net/sampledata/
1. **File path - Container:** `sampledata`    
2. **File path - Directory:** `WideWorldImportersDW/tables`    
3. **File path - File name:** `dimension_customer.parquet`
Churn
https://synapseaisolutionsa.blob.core.windows.net/public/bankcustomerchurn/churn.csv

Sales
https://raw.githubusercontent.com/MicrosoftLearning/dp-data/main/sales.csv
SELECT Item, SUM(Quantity * UnitPrice) AS Revenue
FROM sales
GROUP BY Item
ORDER BY Revenue DESC;

https://github.com/MicrosoftLearning/dp-data/raw/main/orders.zip

# Azure SQL

srvvernedev.database.windows.net

USE master
go
CREATE LOGIN pruebas WITH PASSWORD = '@@Secret0'
go
USE SalesLT
go
CREATE USER pruebas FOR LOGIN pruebas;
GO
EXEC sp_addrolemember 'db_datareader', 'pruebas'

# MySQL

puerto: 3366
pruebas
@@Secret0