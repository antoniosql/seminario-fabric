# **Trabajando con Datawarehouse en Microsoft Fabric**
## **1. Diferencias clave entre un Data Warehouse y un Lakehouse**

### 🔹 **¿Qué es un Data Warehouse en Microsoft Fabric?**

Un **Data Warehouse en Fabric** es una solución optimizada para **almacenar, procesar y analizar datos estructurados** mediante SQL. Se diferencia del **Lakehouse**, que permite gestionar datos estructurados y no estructurados en un solo entorno​.

📌 **Comparación entre Data Warehouse y Lakehouse en Fabric**

|**Característica**|**Data Warehouse**|**Lakehouse**|
|---|---|---|
|**Tipo de datos**|Solo estructurados.|Estructurados y no estructurados.|
|**Modelo de almacenamiento**|SQL tradicional con ACID y transacciones multi-tabla.|Basado en **Delta Lake** con acceso desde Spark y SQL.|
|**Optimización**|Indexación, vistas materializadas y caché de consultas.|Optimización con **formato Parquet y Delta Lake**.|
|**Casos de uso**|Informes analíticos empresariales y BI.|Procesamiento de Big Data y análisis avanzado.|
|**Interfaz principal**|**T-SQL y Power BI DirectQuery**.|**Spark, SQL y Data Science Notebooks**.|

📌 **¿Cuándo usar un Data Warehouse en Fabric?**  
✅ Cuando se requiere **transacciones SQL multi-tabla** con soporte ACID.  
✅ Para modelos de datos altamente estructurados optimizados para informes en Power BI.  
✅ Cuando se necesita **una arquitectura tradicional de almacenamiento y análisis de datos**​.

Para una guía de decisión más detallada puedes consultar el siguiente enlace [Warehouse vs lakehouse](https://learn.microsoft.com/en-us/fabric/fundamentals/decision-guide-lakehouse-warehouse?wt.mc_id=MVP_329801)

El Data Warehouse de Microsoft Fabric ofrece una arquitectura moderna que se caracteriza por la separación entre el almacenamiento y el procesamiento. Esta separación permite escalar cada componente de forma independiente, lo que resulta crucial para organizaciones que manejan grandes volúmenes de datos. Gracias a esta arquitectura, el almacenamiento puede crecer de manera indefinida, mientras que los recursos de cómputo se ajustan dinámicamente a las necesidades específicas de las cargas de trabajo.

Otro aspecto fundamental es el uso de formatos abiertos para el almacenamiento de datos, siendo el **Delta Parquet** el estándar adoptado. Este formato no solo garantiza la interoperabilidad entre los diferentes motores analíticos, como **T-SQL**, **Apache Spark** y **Analysis Services**, sino que también facilita el acceso a los datos sin necesidad de procesos de transformación o duplicación. Esta característica se traduce en una reducción significativa del tiempo y los recursos necesarios para preparar los datos para su análisis.


---

## **2. Creación de un Data Warehouse en Fabric**

### 🔹 **Pasos para crear un Data Warehouse en Microsoft Fabric**

1️⃣ **Acceder al entorno de Fabric**

- Ir a **Microsoft Fabric** → **Data Warehouse** → **Nuevo Data Warehouse**.
- Asignar un nombre y confirmar la creación​.

2️⃣ **Cargar datos en el Data Warehouse**

`COPY INTO mi_warehouse.ventas FROM 'onelake://empresa/datos_ventas/' WITH (FILE_TYPE = 'PARQUET', FORMAT = 'DELTA')`

📌 **Explicación:**

- **Carga masiva de datos** desde **OneLake**.
- Uso de **formato Parquet y Delta** para optimizar rendimiento.

3️⃣ **Ejecución de consultas SQL avanzadas**

`SELECT categoria, SUM(ventas) AS total_ventas FROM mi_warehouse.ventas GROUP BY categoria;`

📌 **Optimización para BI:** Permite consultas agregadas de alto rendimiento en Power BI​.

4️⃣ **Integración con Power BI mediante DirectQuery**

- Conectar Power BI al **SQL Analytics Endpoint del Data Warehouse**.
- Configurar modelos semánticos para acceso en tiempo real​.

---

## **3. Optimización de cargas y consultas para análisis eficientes**

### 🔹 **Estrategias para mejorar el rendimiento de un Data Warehouse en Fabric**

📌 **Optimización de cargas de datos:**  
✅ **Uso de COPY INTO** → Permite cargas eficientes desde **OneLake y otras fuentes**.  
✅ **Compresión y almacenamiento en Delta Lake** → Reduce el espacio en disco y mejora tiempos de consulta.  
✅ **Particionamiento de tablas** → Acelera la ejecución de consultas en grandes volúmenes de datos​.

📌 **Estrategias de optimización en consultas SQL:**  
✅ **Indexación automática** → Fabric crea índices de manera dinámica según el uso de datos.  
✅ **Caché de consultas** → Mejora la velocidad en consultas recurrentes.  
✅ **Uso de vistas materializadas** → Reduce el tiempo de ejecución en reportes analíticos​.

🔹 **Ejemplo de optimización con vistas materializadas**

`CREATE MATERIALIZED VIEW ventas_resumen AS SELECT categoria, SUM(ventas) AS total_ventas FROM mi_warehouse.ventas GROUP BY categoria;`

📌 **Beneficio:** Permite generar reportes **rápidamente** sin recalcular datos en cada consulta​.


---
## **4. Mirror de Bases de Datos**

EL mirror en Microsoft Fabric es una solución rentable y de baja latencia que permite unificar datos de diversos sistemas en una única plataforma de análisis. Esta funcionalidad facilita la replicación continua de tu infraestructura de datos existente directamente en OneLake de Fabric, abarcando una variedad de bases de datos de Azure y fuentes de datos externas.

Con los datos más actualizados en un formato consultable en OneLake, puedes aprovechar todos los servicios que ofrece Fabric, como análisis con Spark, ejecución de notebooks, ingeniería de datos y visualización mediante informes de Power BI, entre otros.

La replicación en Fabric ofrece una experiencia altamente integrada, de extremo a extremo y fácil de usar, diseñada para simplificar tus necesidades analíticas. Construida para promover la apertura y la colaboración entre Microsoft y soluciones tecnológicas que pueden leer el formato de tablas de Delta Lake de código abierto, la replicación es una solución llave en mano de bajo costo y baja latencia que te permite crear una réplica de tus datos en OneLake para satisfacer todas tus necesidades analíticas.

Las tablas Delta resultantes pueden utilizarse en todo Fabric, acelerando así tu transición hacia esta plataforma.

### ¿Por qué utilizarla? 



Actualmente, muchas organizaciones poseen datos operativos o analíticos críticos dispersos en silos. Acceder y trabajar con estos datos suele requerir complejas canalizaciones ETL (Extracción, Transformación y Carga), procesos empresariales y decisiones aisladas, lo que genera:

- Acceso restringido y limitado a datos importantes y en constante cambio.
- Fricción entre personas, procesos y tecnología.
- Largos tiempos de espera para crear canalizaciones de datos y procesos hacia información crucial.
- Falta de libertad para utilizar las herramientas necesarias para analizar y compartir conocimientos de manera cómoda.
- Ausencia de una base adecuada para que las personas compartan y colaboren en torno a los datos.
- Falta de formatos de datos comunes y abiertos para todos los escenarios analíticos: BI, IA, integración, ingeniería e incluso aplicaciones.

La replicación en Fabric proporciona una experiencia sencilla que acelera el tiempo de obtención de valor para obtener conocimientos y tomar decisiones, eliminando los silos de datos entre soluciones tecnológicas mediante:

- Replicación casi en tiempo real de datos y metadatos en un lago de datos SaaS, con análisis integrados para BI e IA.

La plataforma Microsoft Fabric se basa en una arquitectura de Software como Servicio (SaaS), lo que lleva la simplicidad y la integración a un nivel completamente nuevo. Para obtener más información sobre Microsoft Fabric, consulta [¿Qué es Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/overview/).

La replicación crea tres elementos en tu espacio de trabajo de Fabric:

- **OneLake**: gestiona la replicación de datos y metadatos en OneLake y su conversión a Parquet, en un formato listo para análisis. Esto habilita escenarios posteriores como ingeniería de datos, ciencia de datos y más.
- **Punto de conexión de análisis SQL**: proporciona una interfaz para consultas SQL.
- **Modelo semántico predeterminado**: facilita la interpretación y el análisis de los datos replicados.

Además del editor de consultas SQL, existe un amplio ecosistema de herramientas, incluyendo SQL Server Management Studio (SSMS), la extensión mssql para Visual Studio Code e incluso GitHub Copilot.

La funcionalidad de compartir permite un control y gestión sencillos del acceso, asegurando que puedas controlar el acceso a información sensible. Esto también facilita una toma de decisiones segura y democratizada en toda tu organización.

### **Tipos de Mirror**

Fabric ofrece tres enfoques diferentes para incorporar datos en OneLake a través de la replicación:

1. **Replicación de bases de datos**: permite la replicación de bases de datos y tablas completas, facilitando la unificación de datos de diversos sistemas en una única plataforma analítica.
2. **Replicación de metadatos**: sincroniza metadatos (como nombres de catálogos, esquemas y tablas) en lugar de mover físicamente los datos. Este enfoque utiliza accesos directos, asegurando que los datos permanezcan en su origen mientras siguen siendo fácilmente accesibles dentro de Fabric.
3. **Replicación abierta**: diseñada para extender la replicación basada en el formato de tabla Delta Lake abierto. Esta capacidad permite a cualquier desarrollador escribir los cambios de datos de su aplicación directamente en un elemento de base de datos replicada en Microsoft Fabric, basado en el enfoque de replicación abierta y API públicas.

---

## **5. Conclusión y Preguntas Clave**

✅ **Un Data Warehouse en Microsoft Fabric está optimizado para análisis SQL estructurado a gran escala.**  
✅ **Ofrece integración nativa con Power BI y herramientas de modelado SQL.**  
✅ **Las estrategias de optimización, como vistas materializadas e indexación automática, mejoran el rendimiento.**

### **Preguntas para reflexión y discusión**

1️⃣ ¿Cuándo es mejor usar un **Data Warehouse** en lugar de un **Lakehouse** en Fabric?  
2️⃣ ¿Cómo se pueden optimizar cargas de datos masivas usando **COPY INTO**?  
3️⃣ ¿Cuáles son las ventajas de usar **DirectQuery en Power BI** sobre un Data Warehouse en Fabric?