# **ELT con flujos de Generación 2**
## **1. Creación y configuración de Dataflows Gen2**

### 🔹 **¿Qué es Dataflow Gen2?**

Dataflows Gen2 en Microsoft Fabric es una solución **low-code** para la ingesta y transformación de datos, diseñada para simplificar el proceso ETL. Está basado en **Power Query**, lo que permite a los usuarios conectar, transformar y cargar datos desde diversas fuentes sin necesidad de código. Los **Flujos de Datos de Gen2** son la evolución de los Dataflows de Power BI, con mejoras significativas en rendimiento, compatibilidad con **OneLake** y escalabilidad a nivel empresarial.

📌 **Principales Beneficios de Dataflows Gen2:**

✅ **Procesamiento en la nube:** No requieren infraestructura local.  
✅ **Integración con Power Query:** Se usa la misma interfaz de Power BI, pero más potente.  
✅ **Escalabilidad:** Permite procesar **grandes volúmenes de datos** en Fabric.  
✅ **Compatibilidad con múltiples fuentes de datos.**  
✅ **Automatización de cargas con Pipelines de Data Factory.**

### 🔹 **Componentes clave de Dataflows Gen2**

- **Power Query**: El motor de transformación de datos utilizado en Dataflows Gen2 es el mismo que en Power BI y Excel. Esto permite a los usuarios aprovechar su experiencia con Power Query para construir flujos de datos complejos sin necesidad de escribir código. Power Query ofrece más de 300 transformaciones de datos basadas en inteligencia artificial
- **Conectores**: Dataflows Gen2 ofrece una amplia gama de conectores a diversas fuentes de datos, incluyendo bases de datos SQL, archivos CSV, Excel, servicios en la nube, APIs y más. Esto permite la extracción de datos de múltiples sistemas y la integración en una única plataforma.
- **Destinos**: Dataflows Gen2 puede cargar datos transformados en varios destinos, incluyendo Azure Data Lake Storage Gen2, Lakehouses en Microsoft Fabric, y otros destinos como tablas de bases de datos
- **Orquestación**: Aunque Dataflows Gen2 se centra en la transformación de datos, también puede integrarse con Data Pipelines de Microsoft Fabric para la orquestación de flujos de datos. Esto permite construir procesos ETL complejos con gestión de dependencias y disparadores.
- **Staging**: Dataflows Gen2 utiliza un área de almacenamiento temporal o "staging" para guardar los resultados intermedios de las transformaciones. Esto mejora el rendimiento del proceso, ya que las transformaciones se aplican en la nube y el resultado se carga en el destino final. .

### 🔹 **Pasos para crear un Dataflow Gen2**

A continuación, explicamos cómo crear y configurar un **Flujo de Datos de Gen2** paso a paso.

#### **Acceder a Dataflows Gen2**

1. En **Microsoft Fabric**, ir al **espacio de trabajo** donde se desea crear el flujo.
2. Hacer clic en **Nuevo → Flujo de Datos Gen2**.
3. Se abrirá la interfaz de **Power Query**, donde se configuran las fuentes y transformaciones.

#### **Conectar una Fuente de Datos**

Los Flujos de Datos de Gen2 pueden conectarse a más de **300 fuentes de datos**, como:  
✔ **Azure SQL Database**  
✔ **OneLake (Almacenamiento central en Fabric)**  
✔ **Archivos CSV en Azure Blob Storage**  
✔ **Google BigQuery, Amazon S3, SAP HANA, APIs REST**

📌 **Ejemplo Práctico:**  
Si queremos extraer datos de ventas desde una base de datos SQL en Azure:

`SELECT id_transaccion, cliente_id, monto, fecha_venta  FROM ventas WHERE fecha_venta >= '2024-01-01'`

💡 **Optimización:** Si la base de datos soporta **particionamiento**, aplicar **filtros en la consulta** para reducir el volumen de datos extraídos.

#### **Aplicar Transformaciones en Power Query**

Una vez importados los datos, podemos realizar transformaciones como:  
✔ **Eliminar duplicados**  
✔ **Filtrar datos innecesarios**  
✔ **Unir datos de múltiples fuentes**  
✔ **Convertir formatos de fecha, número y texto**  
✔ **Crear columnas calculadas**

📌 **Ejemplo en Power Query:**

`= Table.AddColumn(#"Datos Importados", "Margen", each [Precio] - [Costo], type number)`

#### **Definir el Destino de Datos**

El **resultado del Dataflow Gen2** puede almacenarse en:  
✔ **OneLake**  
✔ **Azure SQL Database**  
✔ **Un modelo semántico en Power BI**

Para definir el destino:

4. Seleccionar **OneLake** para almacenar los datos transformados.
5. Configurar **una actualización programada** para la carga de datos.


---

## **2. Conectores disponibles en Fabric y su uso en escenarios reales**

### 🔹 **Tipos de conectores en Dataflows Gen2**

Los Dataflows Gen2 ofrecen una gran variedad de conectores para la ingesta de datos. Entre los más utilizados están​:

|**Tipo de Conector**|**Ejemplos de Fuentes**|**Casos de Uso**|
|---|---|---|
|**Bases de Datos**|SQL Server, PostgreSQL, SAP HANA|Extracción de datos transaccionales para análisis.|
|**Servicios Cloud**|Azure Data Lake, AWS S3, Google BigQuery|Integración de datos multicloud.|
|**Archivos**|Excel, CSV, JSON, Parquet|Transformación y limpieza de datos no estructurados.|
|**SaaS y APIs**|Salesforce, Dynamics 365, SharePoint|Conexión con sistemas empresariales para reporting.|

### 🔹 **Ejemplo de escenario real**

Una empresa de e-commerce necesita **consolidar datos de ventas desde SQL Server, Google Analytics y un ERP en Dynamics 365**.

1️⃣ **Fuente:** SQL Server, Google Analytics y Dynamics 365.  
2️⃣ **Proceso:** Se utiliza un **Dataflow Gen2** para transformar y consolidar la información.  
3️⃣ **Destino:** Los datos limpios se almacenan en **un Data Warehouse en Fabric** para reportes en Power BI.

📌 **Beneficio:** Automatización del proceso ETL y reducción del tiempo de consolidación de datos en un **70%** ​.

---

## **3. Transformaciones avanzadas y optimización del rendimiento**

Para mejorar la calidad y estructura de los datos, se pueden aplicar:

✔ **Agrupaciones y agregaciones**  
✔ **Expresiones condicionales (IF, CASE)**  
✔ **Tablas pivote y no pivote**  
✔ **Normalización y desnormalización de datos**

📌 **Ejemplo:**  
Si queremos calcular el total de ventas por cliente en Power Query:

`= Table.Group(#"Datos Importados", {"cliente_id"}, {{"TotalVentas", each List.Sum([monto]), type number}})`

### 🔹**Optimización del Rendimiento**

Para mejorar el rendimiento en **Dataflows Gen2**, se recomienda:  
📌 **Reducir la cantidad de datos extraídos** aplicando filtros desde la fuente.  
📌 **Usar formatos como Parquet o Delta Lake** en OneLake.  
📌 **Particionar grandes volúmenes de datos** para mejorar tiempos de procesamiento.


### 🔹 **Transformaciones avanzadas en Power Query**

Power Query en Dataflows Gen2 permite realizar transformaciones avanzadas sin necesidad de programación:

✅ **Filtrado y limpieza de datos** → Eliminación de duplicados y corrección de valores nulos.  
✅ **Creación de columnas calculadas** → Uso de expresiones en **M Query** para cálculos personalizados.  
✅ **Uniones y combinaciones de datos** → Integración de múltiples fuentes en un solo dataset.  
✅ **Pivot y unpivot** → Transformación de datos en distintos formatos para análisis​.

### 🔹 **Optimización del rendimiento en Dataflows Gen2**

🔹 **Fast Copy** → Reduce el tiempo de ingesta de datos en un **50%** gracias a una optimización en la transferencia de datos​.  
🔹 **Incremental Refresh** → Permite actualizar solo los datos nuevos en lugar de recargar todo el dataset​.  
🔹 **Staging optimizado** → Los Dataflows Gen2 crean artefactos de staging en OneLake para acelerar el procesamiento​.  
🔹 **Column Binding en SAP HANA** → Mejora la eficiencia en la consulta de datos en sistemas SAP​.

📌 **Ejemplo práctico:**  
Un equipo de analistas financieros necesita actualizar diariamente datos de ventas **sin recargar todo el dataset**. Se configura **Incremental Refresh**, logrando una reducción del 80% en el tiempo de carga​.

Estas opciones que veremos ahora en detalle, se configuran consulta por consulta:
![[Dataflow config consulta.png]]
#### **Refrescos Incrementales**

El **Refresco Incremental** permite que los Dataflows **solo carguen datos nuevos o modificados**, en lugar de recargar toda la fuente de datos.

📌 **Ejemplo Práctico:**  
Si tenemos una tabla de transacciones de ventas con más de **100 millones de registros**, un Dataflow con Refresco Completo **recargará toda la tabla en cada ejecución**, lo que es ineficiente.  
Con **Refresco Incremental**, solo se importarán las **ventas nuevas del último mes**.

Para activar el **Refresco Incremental en Dataflows Gen2**:

1. Seleccionar la **columna de fecha** que servirá de referencia para el incremental.
2. Configurar el **rango de retención** (ejemplo: solo los últimos 6 meses).
3. Publicar el Dataflow y activar el **modo incremental**.

Existe alguna limitación, la más importante relacionada con los destinos como podemos apreciar en esta imagen, porque no todos los destinos soportan actualizaciones incrementales. 
![[Dataflow Gen2 Incremental.png]]
Si queremos tener un destino lakehouse, y cargas incrementales, estas no podremos configurarlas en el Dataflow, sino que tendremos que cargar los datos en crudo, y posteriomente refinarlos en el lakehouse. Si el destino está soportado entonces tendremos que configurar la carga incremental, de este modo:
![[Dataflow Carga Incremental.png]]

- Primero configurados una columna por la que filtrar los datos. Esta configuración es necesaria y especifica la columna que usan los flujos de datos para filtrar los datos. Esta columna debe ser una columna DateTime, Date o DateTimeZone. El flujo de datos usa esta columna para filtrar los datos y solo recupera los datos que han cambiado desde la última actualización.
- Extraer datos del pasado. Esta configuración es necesaria y especifica el retroceso en el tiempo que el flujo de datos debe extraer datos. Esta configuración se usa para recuperar la carga de datos inicial. El flujo de datos recupera todos los datos del sistema de origen que se encuentran dentro del intervalo de tiempo especificado.
- Tamaño del cubo. Esta configuración es necesaria y especifica el tamaño de los cubos que usa el flujo de datos para filtrar los datos. El flujo de datos divide los datos en cubos en función de la columna DateTime. Cada cubo contiene los datos que cambiaron desde la última actualización. El tamaño del cubo determina la cantidad de datos que se procesan en cada iteración. Un tamaño de cubo más pequeño significa que el flujo de datos procesa menos datos en cada iteración, pero también significa que se requieren más iteraciones para procesar todos los datos. Un tamaño de cubo mayor significa que el flujo de datos procesa más datos en cada iteración, pero también significa que se requieren menos iteraciones para procesar todos los datos.
- Valor máximo de columna. Esta configuración es necesaria y especifica la columna que usa el flujo de datos para determinar si los datos han cambiado. El flujo de datos compara el valor máximo de esta columna con el valor máximo de la actualización anterior. Si se cambia el valor máximo, el flujo de datos recupera los datos que han cambiado desde la última actualización. Si no se cambia el valor máximo, el flujo de datos no recupera ningún dato.
- Periodos Finalizados. Si seleccionamos esta opción se leerán únicamente datos de periodos finalizados. 

Limitaciones:
- Solo se admiten destinos basados en SQL
- El número máximo de cubos es de 50 para una tabla y 150 para el dataflow completo
- Solo se admite el método replace en el destino

#### **Fast Copy**

**Fast Copy** es una funcionalidad que acelera la transferencia de datos en Fabric al utilizar **procesamiento en paralelo y compresión eficiente**.

📌 **Beneficios de Fast Copy:**  
✔ **Hasta 10 veces más rápido** que una copia normal.  
✔ **Ideal para migraciones y cargas masivas de datos.**  
✔ **Compatible con Dataflows Gen2 y Pipelines de Data Factory.**

Para habilitar **Fast Copy** en un Dataflow Gen2:

1. Seleccionar la fuente y destino de datos.
2. Activar la opción **"Usar Fast Copy"** en la configuración del Dataflow.
3. Guardar y ejecutar el Dataflow.

Requisitos:
- Conectores y Transformaciones soportados
- Para ficheros solo están soportados CSV y parquet almacenados en Azure Blob o ADLS de más de 100Mb de tamaño
- Para orígenes SQL tablas con más de 5 millones de filas

---

## **4. Hands-On: Construcción de un Dataflow Gen2 desde cero**

### 🔹 **Objetivo del ejercicio**

Construir un **Dataflow Gen2** que:

- Ingesta datos de una base de datos **SQL Server** en Azure en  **OneLake**.
- Realiza transformaciones de limpieza y cálculo.
- Almacena el resultado en un **Lakehouse en Fabric** para su uso en Power BI.

Los datos de conexión a la base de datos son:
- Servidor:  srvvernedev.database.windows.net 
- BBDD: SalesLT
- Usuario: pruebas
- Contraseña: @@Secret0
### 🔹 **Pasos del ejercicio**

1️⃣ **Crear un Dataflow Gen2** en Microsoft Fabric.  
2️⃣ **Añadir conectores** para SQL Server con los datos proporcionados

Agregar las tablas:
- SalesLT.Product
- SalesLT.ProductCategory
- SalesLT.Customer
- SalesLT.SalesOrderDEtail
- SalesLT.SalesOrderHeader

Asegúrate de mostrar todas las opciones de perfilado desde las opciones:

![[Dataflow Perfiles de Datos.png]]
3️⃣ **Aplicar transformaciones** en Power Query:

- En la tabla SalesLT.Product
	- quitar las columnas "ThumbnailPhotoFileName", "ThumbNailPhoto"
	- Reemplazar los nulos de la columna Size por "NA"
	- Expande la tabla SalesLT.ProductCategoy para llevar el campo Name a la tabla de SalesLT.Product
- Renombra la tabla SalesLT.Product como Products
- Desmarca la opción de habilitar el almacenamiento temporal en la tablas en SAlesLT.ProductCategory
- En la tabla SalesLT.Customer
	- Quita las columnas "Suffix", "NameStyle", "MiddleName", "PasswordHash", "PasswordSalt"
	- Renombra la tabla como Customers
- En la tabla SalesLT.OrderDetail 
	- Expande la tablas SalesLT.SalesOrderHeader para traer los campos de detalle, trae todos los campos
	- Renombre la tabla como Sales
- Desmarca la opción de habilitar el almacenamiento temporal en las tablas en SalesLTSalesOrderHeader



    4️⃣ **Definir el destino en OneLake o Lakehouse**.  
    5️⃣ **Ejecutar el Dataflow y validar resultados**.

Abre el Modelo Semántico creado e intenta generar un informe sobre esos datos

📌 **Resultado esperado:** Los datos procesados estarán disponibles para análisis en **Power BI** y otras herramientas dentro de Fabric​.

---

## **5. Conclusión y Preguntas Clave**

✅ **Los Dataflows Gen2 permiten ingestar, transformar y automatizar procesos ETL en Fabric.**  
✅ **El uso de conectores nativos facilita la integración con diversas fuentes de datos.**  
✅ **Las transformaciones avanzadas en Power Query mejoran la calidad y preparación de los datos.**  
✅ **Las optimizaciones como Fast Copy e Incremental Refresh mejoran el rendimiento de los flujos de datos.**

### **Preguntas de reflexión**

1️⃣ ¿Cuándo es mejor usar Dataflows Gen2 en lugar de Pipelines en Data Factory?  
2️⃣ ¿Cómo aprovechar Incremental Refresh para mejorar tiempos de procesamiento?  
3️⃣ ¿Cómo elegir el mejor destino (OneLake, Lakehouse o Data Warehouse) según el caso de uso?


