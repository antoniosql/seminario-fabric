# **Desarrollo con Apache Spark**

**Apache Spark** es un motor de procesamiento distribuido de **código abierto** diseñado para **procesamiento de datos a gran escala**. Se ejecuta en clusters y permite el análisis de datos en **tiempo real y batch**, proporcionando APIs en **Python (PySpark), Scala, Java, R y SQL**.

✔ **Alta velocidad** gracias a su ejecución en memoria.  
✔ **Escalabilidad** para procesar desde **megabytes hasta petabytes** de datos.  
✔ **Compatibilidad con múltiples fuentes de datos**, como **OneLake, Data Warehouses, Data Lakes y bases de datos SQL**.

En **Microsoft Fabric**, Spark es una pieza clave del **Data Engineering** y se integra con otros servicios como **Data Factory, OneLake, Power BI y Data Science**.

--- 

## **1. ¿Cómo se integra Apache Spark en Microsoft Fabric?

En **Microsoft Fabric**, Spark se ejecuta en un entorno **completamente administrado**, eliminando la necesidad de configurar clusters manualmente.

### **🔹 Componentes Clave**

✔ **Clusters de Spark administrados**: Se asignan dinámicamente recursos según la carga de trabajo.  
✔ **Pools de Spark**: Grupos de recursos donde se ejecutan notebooks y trabajos de Spark. 
✔ **Notebooks de Fabric**: Espacios interactivos para escribir código en **PySpark, Scala y SQL**.  
✔ **OneLake**: Almacenamiento unificado para datos procesados por Spark.  
✔ **Integración con Data Factory**: Automatización de cargas y ejecución de pipelines.

📌 **Ejemplo:**  
Si una empresa quiere procesar **grandes volúmenes de datos de ventas**, Spark puede leer los datos desde **OneLake**, aplicar transformaciones con PySpark y guardar el resultado en un **Data Warehouse** para su análisis en Power BI.

---

## **2. Conceptos Clave de Spark Compute**

### 🔹**Compute Engines**

Microsoft Fabric permite ejecutar Spark en un entorno administrado donde los **clusters** se crean y gestionan automáticamente. Esto permite a los usuarios centrarse en el desarrollo sin preocuparse por la infraestructura subyacente.

### 🔹**Tipos de Jobs en Fabric Spark**

- **Batch Jobs:** Se utilizan para procesamiento de datos en grandes volúmenes.    
- **Streaming Jobs:** Permiten el procesamiento en tiempo real de datos en movimiento.    
- **Notebooks y Pipelines:** Usados para desarrollo interactivo y modelado de datos.    

---

## **3. Configuración y Gestión de Pools de Spark**

### 🔹**Pools Predeterminados (Starter Pools)**

Los **Starter Pools** en Microsoft Fabric son grupos preconfigurados de recursos de Spark que permiten ejecutar trabajos de manera rápida sin necesidad de configuración avanzada.

**Ventajas:**

- No requieren configuración manual.    
- Son ideales para entornos de desarrollo y pruebas.    
- Ofrecen un rendimiento óptimo para cargas de trabajo moderadas.    

### 🔹**Creación de Pools Personalizados**

Para cargas de trabajo más complejas, es posible **crear pools de Spark personalizados** con configuraciones específicas.

Pasos para la configuración:

1. Definir el tamaño del pool de nodos.    
2. Seleccionar el tipo de instancias de Spark (RAM/CPU).    
3. Configurar límites de concurrencia y asignación de memoria.    
4. Asociar el pool a una capacidad de Fabric.    

![Configuración de Pools Spark](<imagenes/Configuracion Pools Spark.png>)

### 🔹**Facturación y Administración de Capacidad**

Microsoft Fabric usa un modelo de **cobro por uso**, donde los recursos de Spark consumen **unidades de capacidad (CU)**. Esta es la tabla con los valores predeterminados que tienen los pools de Spark dependiendo de la SKU. 

![Pools Spark por defecto SKU](<imagenes/Pools Spark por defecto SKU.png>)

- **Estrategias de optimización de costes:**    
    - Utilizar pools compartidos para trabajos recurrentes.        
    - Configurar límites de uso en trabajos Spark.        
    - Monitorear el consumo con herramientas de Fabric.        


Para un pool starter, estas son las tareas que se facturan y las que no. En el caso de un pool personalizado, simplemente desaparece el estado "Pool Idle". 

![Facturación Pools Sparl](<imagenes/Facturacion Pools Spark.png>)

---

## **4. Gestión de Concurrencia y Encolado de Trabajos**

### 🔹**Modo de Alta Concurrencia**

El **modo de alta concurrencia** en Fabric permite ejecutar múltiples trabajos Spark simultáneamente dentro de un mismo pool de recursos.

**Beneficios:**

- Mayor eficiencia en la ejecución de tareas paralelas.    
- Menos sobrecarga en la creación de clusters.    
- Uso más eficiente de los recursos disponibles.    

### 🔹**Administración de Admisión de Trabajos**

Fabric permite configurar políticas de **admisión de trabajos** para controlar la cantidad de tareas en ejecución simultánea y evitar sobrecargas.

**Opciones disponibles:**

- Asignar prioridades a diferentes tipos de trabajos.    
- Limitar el número de trabajos simultáneos.    
- Definir reglas de asignación de recursos.    

### 🔹**Encolado de Trabajos**

Cuando los recursos están ocupados, los nuevos trabajos ingresan a una **cola de espera** hasta que haya capacidad disponible.

**Buenas prácticas:**

- Priorizar trabajos críticos con etiquetas de urgencia.    
- Definir límites de tiempo de espera para evitar bloqueos.    
- Monitorear el estado de la cola para ajustes dinámicos.    

---

## **5. Optimización y Autoajuste en Spark**

### 🔹**Técnicas de Optimización**

Para mejorar el rendimiento de trabajos Spark en Fabric, se pueden aplicar las siguientes estrategias:

- **Particionamiento de Datos:** Para paralelizar el procesamiento.    
- **Broadcast Join:** Para evitar movimientos de datos innecesarios.    
- **Uso de Cache:** Para almacenar datos frecuentemente utilizados.    
- **Compresión de Datos:** Para reducir el tiempo de procesamiento.    

### 🔹**Uso de AutoTune**

Fabric ofrece **AutoTune**, una funcionalidad que ajusta automáticamente los parámetros de ejecución de Spark para maximizar la eficiencia.

**¿Cómo funciona?**

1. Analiza patrones de ejecución de trabajos anteriores.    
2. Ajusta dinámicamente parámetros como el número de ejecutores y la asignación de memoria.    
3. Optimiza la distribución de tareas dentro del cluster.    

**Ventajas:**

- Reducción del tiempo de ejecución.    
- Menos intervención manual en la configuración de Spark.    
- Uso más eficiente de los recursos disponibles.

---

## **6. Uso de PySpark para la ingeniería de datos**

### 🔹 **¿Qué es PySpark y por qué usarlo en Fabric?**

PySpark es la implementación de **Apache Spark en Python**, y es una herramienta clave para procesar grandes volúmenes de datos en paralelo dentro de Fabric.

📌 **Beneficios de PySpark en Fabric:**  
✅ **Escalabilidad:** Ejecuta procesos de datos en clústeres distribuidos.  
✅ **Compatibilidad con Delta Lake:** Soporta almacenamiento en **OneLake** con formato optimizado.  
✅ **Interoperabilidad con SQL y Power BI:** Permite consultas híbridas con T-SQL​.

### 🔹 **Ejemplo de código PySpark en un Notebook de Fabric**


`from pyspark.sql import SparkSession  
# Crear sesión de Spark 
spark = SparkSession.builder.appName("FabricPySparkDemo").getOrCreate()  
# Cargar datos desde OneLake 
df = spark.read.format("delta").load("onelake://mi_empresa/datasets/ventas")  
# Transformaciones en PySpark 
df_filtrado = df.filter(df["ingresos"] > 10000)  # Mostrar resultados df_filtrado.show()`

📌 **Explicación del código:**  
1️⃣ Se inicia una sesión de **Spark en Fabric**.  
2️⃣ Se cargan datos en formato **Delta Lake desde OneLake**.  
3️⃣ Se aplican transformaciones con **PySpark (filtros y manipulación de datos)**.


--- 

## **7. Introducción a los Notebooks en Microsoft Fabric**

### 🔹 **¿Qué es un Notebook en Microsoft Fabric?**

Un **Notebook en Microsoft Fabric** es un entorno interactivo que permite escribir y ejecutar código en múltiples lenguajes (**Python, Scala, SQL y .NET**). Está diseñado para **ingenieros de datos, científicos de datos y analistas**, facilitando la exploración y transformación de datos​.

### 🔹 **Características clave de los Notebooks en Fabric**

✅ **Soporte multi-lenguaje:** Python (PySpark), Scala, SQL y .NET.  
✅ **Integración con OneLake:** Accede y manipula datos almacenados en Fabric.  
✅ **Ejecuta Spark Jobs en paralelo:** Alta capacidad de cómputo distribuido.  
✅ **Versionado con Git:** Soporte para control de versiones e integración con CI/CD.  
✅ **Orquestación con Pipelines:** Los notebooks pueden ejecutarse como parte de un flujo de datos​.

📌 **Ejemplo de uso:** Un equipo de análisis de datos puede usar un Notebook en Fabric para limpiar y transformar datos financieros antes de almacenarlos en un Data Warehouse.


---

## **8. Optimización del rendimiento en Spark y mejores prácticas**

### 🔹 **Estrategias para mejorar el rendimiento de Apache Spark en Fabric**

📌 **Optimización del rendimiento con Spark en Fabric:**

✅ **Uso de formato Delta Lake** → Acelera la lectura/escritura y permite transacciones ACID​.  
✅ **Paralelismo en tareas Spark** → Ajustar el número de particiones para evitar cuellos de botella.  
✅ **Uso de caché en Spark** → Permite mejorar tiempos de respuesta en datasets reutilizados.  
✅ **Aplicación de V-Order en Parquet** → Optimiza el rendimiento de consultas SQL sobre datos en Fabric.

📌 **Ejemplo de optimización con caché en PySpark**

`df.cache()  # Mantiene el DataFrame en memoria para acelerar consultas df.count()  # Ejecuta una acción para materializar el cache`

🔹 **Estrategia de particionamiento recomendada:**

`df.repartition(10)  # Distribuir datos en 10 particiones para balanceo de carga`

✅ **Monitorización de Spark Jobs en Fabric:** Fabric proporciona herramientas de mointorización para visualizar el rendimiento de cada tarea de Spark, permitiendo identificar cuellos de botella​.


---

## **9.Carga Incremental con SCD2 con PySpark**

En los escenarios de BI comunes donde disponemos de un Data Warehouses en SQL Server On-Premises o en la nube, nos encontrábamos con la característica IDENTITY que se asignaba a las claves subrogadas de las dimensiones. Ahora, con las tablas **Delta** nos encontramos con la **problemática** de que las **IDENTITY desaparecen**, por lo que el versionado de las SCD2 tiene que ser rediseñado.

Para ello, proponemos una **solución** para emular el atributo IDENTITY almacenando en una variable el último valor de la clave subrogada cargada, para después con código escrito en Spark SQL y la función de ventana ROW\_NUMBER(), gestionar y mantener los índices autoincreméntales en los elementos que entren nuevos o hayan cambiado de versión.

1) Partiendo de la siguiente dimensión que presenta el nombre “tabla\_delta”:

![tabla_delta](https://www.vernegroup.com/wp-content/uploads/2025/02/Imagen1.png "tabla_delta")

Con estas primeras líneas de código importamos las funciones del módulo pyspark.sql.functions, almacenamos la *pk* en la variable *key\_column*, guardamos los campos en una lista, la reorganizamos para dejar *fromDate* al final y convertimos esa lista en un *string* separado por comas.

![string](https://www.vernegroup.com/wp-content/uploads/2025/02/Captura-de-pantalla-2025-02-12-170322-1.png "string")

2) Suponiendo que en la variable *sdf* tenemos almacenado el *DataFrame* con los datos que han entrado en la última ejecución:

![datos-dataframe](https://www.vernegroup.com/wp-content/uploads/2025/02/Imagen2.png "datos-dataframe")

Con el siguiente código le añadimos el campo *toDate* y *isCurrent*, además de añadir un hash con la función *xxhash64*. Este hash puede estar compuesto por todos los elementos de la dimensión o únicamente por los que nos interesen para versionar.

![hash](https://www.vernegroup.com/wp-content/uploads/2025/02/Captura-de-pantalla-2025-02-12-171012.png "hash")

1) Después, almacenamos en la variable *next\_surrogate\_key* el valor de la última *sk* cargada en la tabla, y guardamos en una vista temporal el *DataFrame* *sdf*.

![vista-temporal-dataframe](https://www.vernegroup.com/wp-content/uploads/2025/02/Captura-de-pantalla-2025-02-12-171322.png "vista-temporal-dataframe")

2) Por último, añadimos las líneas de Spark SQL encargadas de finalizar las versiones actuales de la dimensión y de insertar las nuevas.

![lineas-spark-sql](https://www.vernegroup.com/wp-content/uploads/2025/02/Captura-de-pantalla-2025-02-12-171643-1.png "lineas-spark-sql")

Tras ejecutar todo el código el resultado de la dimensión sería el siguiente:

![codigo-resultado-dimensión](https://www.vernegroup.com/wp-content/uploads/2025/02/Imagen3-1.png "codigo-resultado-dimensión")

En el cual disponemos de **dos versiones** para los **id 2 y 6** y la **nueva inserción** para el **id 7**, cada una de ellas **con** **su** **propia clave subrogada** (*sk*).

---

## **10. Conclusión y Preguntas Clave**

✅ **Los Notebooks en Microsoft Fabric son herramientas clave para la ingeniería de datos con Apache Spark.**  
✅ **PySpark permite la manipulación y transformación de datos a gran escala de manera eficiente.**  
✅ **Optimizar el rendimiento con Delta Lake y técnicas de caching mejora la eficiencia del procesamiento.**  
✅ **Fabric facilita la integración de Spark con almacenamiento en OneLake y análisis en Power BI.**

### **Preguntas para reflexión y discusión**

1️⃣ ¿Cómo elegir entre SQL, PySpark y .NET dentro de un Notebook en Fabric?  
2️⃣ ¿Cuándo se debe usar **cache()** y **repartition()** en Spark para optimizar rendimiento?  
3️⃣ ¿Cómo se pueden monitorear y depurar errores en Spark dentro de Microsoft Fabric?