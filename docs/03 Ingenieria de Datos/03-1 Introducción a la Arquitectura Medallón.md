# **Introducción a la Arquitectura Medallón**

La **arquitectura Medallón** es un enfoque de diseño de datos en lagos de datos (**Data Lakes**) que organiza la información en **tres capas o zonas** para garantizar calidad, gobernanza y eficiencia en el análisis. Su objetivo es estructurar los datos desde su ingestión hasta su consumo, asegurando integridad y optimización en la consulta y transformación.

Microsoft Fabric, con **OneLake** como núcleo central, permite la implementación de esta arquitectura de manera **nativa**, proporcionando una solución unificada para la gestión de datos empresariales.
## **1. Concepto de Bronce, Plata y Oro: Estructura de capas en la gestión de datos**

### 🔹 **¿Qué es la Arquitectura Medallón?**

La **Arquitectura Medallón** es un enfoque de gestión de datos en capas que mejora la calidad y accesibilidad de los datos almacenados en un **Data Lake** o **Lakehouse**. En Microsoft Fabric, esta arquitectura se implementa en **OneLake**, permitiendo gestionar la evolución de los datos desde su ingesta hasta su consumo​. Existen diferentes nomenclaturas para denominar a las capas (bronze, silver, gold ; raw, validated, curated,...) en la documentación oficial de Onelake, Microsoft opta por bronze, silver, gold, así que esa utilizaremos durante este curso. 

![Arquitectura Medallón](<imagenes/Arquitectura Medallón.png>)

### 🔹 **Capas de la Arquitectura Medallón**

#### **Capa Bronze**

**Propósito:** Almacenar los datos en su formato original tal y como llegan desde las fuentes.

📌 **Características:**

- Datos sin procesar, extraídos directamente de fuentes transaccionales, archivos, APIs, sensores IoT, etc.
- **Formato:** JSON, CSV, Parquet, Avro, Delta Lake.
- **Gobernanza mínima**, solo controles de acceso.
- **Ejemplo en Fabric:** Ingesta con **Data Factory** y almacenamiento en **OneLake**.

#### **Capa Plata(Validada)**

📌 **Propósito:** Refinar y limpiar los datos para hacerlos útiles en análisis.

📌 **Características:**

- Se eliminan valores nulos, se corrigen errores y se filtran registros.
- Se generan particiones y optimizaciones para mejorar rendimiento.
- Se aplican **modelos de gobernanza y seguridad**.

📌 **Ejemplo en Fabric:** Aplicación de transformaciones en **Data Engineering** y almacenamiento en Delta Lake sobre **OneLake**.

#### **Capa Oro(Curada)**

📌 **Propósito:** Servir datos listos para análisis y modelos de negocio.

📌 **Características:**

- Datos enriquecidos, agregados y optimizados.
- Indexación para consultas eficientes.
- Modelado **dimensional (star schema)** para integración con BI.

📌 **Ejemplo en Fabric:**

- Uso de **Data Warehouse** en Fabric para modelado relacional.
- Creación de vistas optimizadas para **Power BI**.

|**Capa**|**Propósito**|**Ejemplo de uso**|
|---|---|---|
|**Bronce (Raw Layer)**|Almacena los datos sin procesar, tal como llegan desde las fuentes.|Datos de sensores IoT o logs de transacciones sin transformación.|
|**Plata (Clean Layer)**|Se aplican procesos de limpieza, transformación y deduplicación.|Eliminación de valores nulos y normalización de datos.|
|**Oro (Curated Layer)**|Datos listos para el consumo empresarial, optimizados para BI y analítica.|Tablas agregadas para informes financieros en Power BI.|

📌 **Beneficio clave:** Permite manejar datos **a gran escala**, asegurando que las transformaciones se realicen de manera eficiente y escalable en Fabric​.

---

## **2. Estrategias para mover datos entre capas y asegurar la calidad**

### 🔹 **Proceso ELT en la Arquitectura Medallón**

Cada capa tiene un conjunto de transformaciones clave que garantizan la **calidad y gobernanza de los datos** en Fabric.

🔹 **Estrategias para mover datos entre capas:**

1️⃣ **De Bronce a Plata:**  
✅ **Filtrado de datos erróneos o duplicados**.(de-duplicación)  
✅ **Conversión de formatos** (JSON → Parquet, CSV → Delta Lake).  
✅ **Enriquecimiento con datos de otras fuentes**.

2️⃣ **De Plata a Oro:**  
✅ **Agregaciones y cálculos avanzados** para optimizar consultas.  
✅ **Creación de vistas optimizadas** en un Data Warehouse.  
✅ **Indexación y particionamiento** para mejorar el rendimiento​.

📌 **Ejemplo práctico:** Un pipeline de Data Factory puede extraer datos brutos de sensores (Bronce), limpiarlos y calcular promedios por hora (Plata), y finalmente generar reportes con tendencias de uso (Oro).

---

### 🔹 **Patrones de despliegue**

Para implementar la arquitectura medallion en Fabric, podemos usar lakehouses (uno para cada zona), un datawarehouse o una combinación de ambos. La decisión dependerá de nuestras preferencias y de la experiencia de su equipo. Fabric no ofrece flexibilidad: podemos usar diferentes motores analíticos que trabajan con una única copia de los datos en OneLake.

Aquí hay dos patrones que podemos considerar:

🔹 **Patrón 1**: Crear cada zona como un lakehouse. En este caso, los usuarios empresariales acceden a los datos a través del punto de conexión de análisis SQL.

🔹 **Patrón 2**: Configurar las zonas de bronce y plata como lakehouse y la zona oro como datawarehouse. Aquí, los usuarios empresariales acceden a los datos mediante el punto de conexión de almacenamiento de datos.

Aunque podemos crear todos los almacenes de lago dentro de una única área de trabajo en Fabric, lo recomendable es que cada almacén tenga su propia área de trabajo independiente. Este enfoque nos da más control y mejor gobernanza a nivel de zona.

Para la **zona bronce**, lo ideal es almacenar los datos en su formato original o usar Parquet o Delta Lake. Siempre que sea posible, debemos de mantener los datos en su formato original. Si los datos de origen provienen de OneLake, Azure Data Lake Store Gen2 (ADLS Gen2), Amazon S3 o Google, es mejor crear un acceso directo en la zona bronce en lugar de copiarlos.

Para las **zonas plata y oro**, se recomienda usar tablas Delta por las funcionalidades adicionales y mejoras de rendimiento que ofrecen. Fabric normaliza el formato Delta Lake y, por defecto, cada motor de Fabric escribe los datos en este formato. Además, estos motores aplican la optimización en tiempo de escritura **V-Order** al formato de archivo Parquet, lo que permite lecturas extremadamente rápidas para motores como Power BI, SQL, Apache Spark y otros. 


--- 

## **3. Delta lakehouse**

### 🔹 **Apache Parquet**

**Parquet** es un formato de almacenamiento columnar de código abierto que se creó como parte de Apache Hadoop y que actualmente se utiliza en muchos otros sistemas.
Su principal característica es que organiza los datos en columnas, a diferencia de otros formatos que los organizan en filas, como CSV. Además, a cada columna se le asigna un tipo de dato. Esto tiene varias ventajas, entre ellas quiero resaltar las dos que me parecen más importantes.
La primera ventaja es la reducción del espacio de almacenamiento, ya que los datos de cada columna se pueden codificar de manera independiente, con un algoritmo específico para el tipo de dato de la columna. Por ejemplo, para una columna con textos donde los valores se repitan mucho, en lugar de almacenar directamente el texto de cada fila, se puede crear primero un diccionario con los valores únicos y luego para cada fila almacenar un valor numérico con el índice al diccionario. De esta forma se logra reducir el espacio requerido para almacenar la columna. Parquet soporta varios métodos de codificación.
Además de esta codificación, Parquet también soporta varios tipos de compresión, como **Snappy** o GZIP, con lo cuál se logra reducir aún más el espacio de almacenamiento.
Para dar una idea de cuanto se comprimen los datos, he convertido un archivo CSV con 11 millones de filas a Parquet. El tamaño en disco del CSV es de unos 500 MB mientras que el tamaño del archivo Parquet es de unos 42 MB.
Por lo tanto, con los archivos Parquet podemos reducir los costes de almacenamiento, sobre todo si estamos usando almacenamiento en la nube como es el caso de **Onelake**.
La segunda ventaja es que las columnas se pueden leer de manera independiente, o sea, si sólo se quieren obtener los datos de algunas columnas, estos se pueden ir a buscar directamente, sin necesidad de cargar los datos de las columnas restantes. 

Otras dos características muy importantes de Parquet son:

- **Metadatos**: además de los datos, guarda información sobre los nombres y los tipos de las columnas, estadísticas de los datos, entre otras cosas.
- **Estructuras anidadas**: es capaz de representar datos con una estructura compleja, por ejemplo, que una columna contenga a su vez otra tabla.

Se convirtió rápidamente en el formato de referencia en el paradigma Big Data, por la compresión que ayudaba a reducir costes, por poder manejar gran cantidad de datos y estar orientado al análisis, y por facilitar los patrones de ELT, con una estructura de metadata integrada. 

---

### 🔹 **¿Qué es un Delta lake?**

Delta Lake es una capa de almacenamiento open source que ofrece transacciones ACID (atomicidad, coherencia, aislamiento y durabilidad) para cargas de trabajo de macrodatos de Apache Spark. Está basado en una evolución del formato Apache Parquet, denominada Delta, desarrollada por Databricks, que a día de hoy se ha convertido en un estándar de facto en el mundo lakehouse, desde que Databricks decidió liberarlo como un proyecto Open Source también.  Por lo tanto el **formato de fichero Delta** es un estándar de almacenamiento optimizado basado en **Parquet**, diseñado para mejorar la eficiencia en la gestión de datos en lagos de datos y almacenes analíticos. Microsoft Fabric adopta **Delta Lake** como formato principal para almacenamiento en **OneLake**, asegurando compatibilidad con múltiples motores analíticos y soporte para transacciones ACID. A continuación se detallas las principales características de este formato:

| Característica                                         | Descripción                                                                                                                                                                                                                                                                                                                |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Transacciones ACID**                                 | Los lakehouses suelen llenarse con múltiples procesos y canalizaciones, donde algunos escriben datos mientras otros los leen. Delta Lake  ofrece transacciones ACID para garantizar la integridad de los datos, evitando problemas en los registros. Así podemos asegurarnos de que los datos sean consistentes y fiables. |
| **Control escalable de metadatos**                     | Administrar grandes volúmenes de datos puede ser complicado, pero Delta Lake maneja incluso los metadatos a gran escala. Aprovecha la potencia de Spark para procesarlos de manera distribuida, lo que permite gestionar datos en la escala de petabytes sin perder eficiencia.                                            |
| **Viaje en el tiempo (control de versiones de datos)** | ¿Necesitas volver a una versión anterior de los datos? Con Delta Lake podemos "deshacer" cambios y recuperar versiones pasadas, lo que facilita auditorías, análisis de tendencias y recuperación de información en caso de errores.                                                                                       |
| **Formato abierto**                                    | Delta Lake utiliza Apache Parquet como formato de referencia, lo que nos permite beneficiarse de esquemas de compresión y codificación eficientes sin depender de formatos propietarios.                                                                                                                                   |
| **Lote unificado y origen/receptor de streaming**      | Las tablas en Delta Lake pueden funcionar tanto para procesamiento por lotes como en streaming. Podemos ingerir datos en tiempo real, reponer históricos de manera sencilla y ejecutar consultas interactivas sin problemas.                                                                                               |
| **Aplicación de esquemas**                             | Se aseguran de que los tipos de datos sean correctos y de que todas las columnas necesarias estén presentes. Así evitan inconsistencias y mantienen la coherencia de los datos.                                                                                                                                            |
| **Evolución del esquema**                              | Pueden realizar cambios en los esquemas de las tablas sin necesidad de escribir DDL de migración manualmente. Así, la estructura de los datos se adapta automáticamente a nuevas necesidades.                                                                                                                              |
| **Historial de auditorías**                            | Delta Lake registra automáticamente cada cambio en los datos, permitiéndoles realizar auditorías completas y rastrear modificaciones de manera sencilla.                                                                                                                                                                   |
| **Actualizaciones y eliminaciones**                    | Pueden actualizar y eliminar datos fácilmente con operaciones como MERGE, UPDATE y DELETE, sin complicaciones y garantizando el cumplimiento de normativas.                                                                                                                                                                |
| **100% compatible con la API de Apache Spark**         | No necesitan hacer cambios en sus canalizaciones de datos actuales para usar Delta Lake, ya que es totalmente compatible con Spark.                                                                                                                                                                                        |

Uno de los mayores desafíos en el almacenamiento de datos es garantizar que las consultas sean rápidas y eficientes. En el formato **Delta Lake**, existen dos estrategias clave para mejorar la ejecución de consultas analíticas sobre grandes volúmenes de datos: **Z-Ordering** y **V-Ordering**. Ambas técnicas optimizan la organización de los datos dentro de los archivos **Parquet**, reduciendo el tiempo de búsqueda y mejorando la latencia de las consultas.

---

#### **Z-Ordering**

**Z-Ordering** es una técnica de **clustering** que mejora la eficiencia de las consultas al **reorganizar los datos dentro de los archivos Delta según una columna clave**. Esta optimización es particularmente útil en escenarios donde las consultas filtran frecuentemente por una o varias columnas específicas.

 📌 **¿Cómo funciona?**

- Organiza los datos utilizando un **algoritmo de Morton (Z-order curve)**, que **agrupa valores similares dentro del mismo archivo**.
- Reduce **la cantidad de archivos que deben escanearse** en consultas con filtros en columnas clave.
- Mejora la **localidad de los datos**, facilitando la lectura secuencial en almacenamiento distribuido.

👉 **Casos de uso óptimos:**

- Tablas con **grandes volúmenes de datos** y **consultas que filtran por rangos en columnas específicas**.
- Datos con **altos índices de cardinalidad**, donde la dispersión de valores en los archivos podría generar **lecturas innecesarias**.

---

#### **V-Ordering**

**V-Ordering** (Vertical Ordering) es un **método de ordenación dentro de los archivos Parquet** que mejora el rendimiento de las consultas al **minimizar los costos de descompresión y escaneo**. La aplicación de V-Ordering es automática cuando almacenamos datos en formato delta en Onelake. 

 📌 **¿Cómo funciona?**

- Reordena los datos **dentro de cada archivo Parquet** en un patrón de **valores agrupados y ordenados**.
- Optimiza la lectura de **columnas altamente repetitivas**, como dimensiones con pocos valores únicos.
- Reduce el **tamaño del archivo comprimido**, ya que los valores similares se agrupan de forma más eficiente.

👉 **Casos de uso óptimos:**

- Datos con **alta repetición en columnas específicas**, donde la organización de los valores mejora la compresión.
- Consultas con **agregaciones frecuentes**, ya que permite **lecturas más eficientes y menos I/O**.
---

## **4. Conclusión y Preguntas Clave**

✅ **La Arquitectura Medallón mejora la calidad y estructuración de los datos en Fabric.**  
✅ **Cada capa (Bronce, Plata y Oro) tiene un propósito específico para la gestión de datos.**  
✅ **Fabric proporciona herramientas para mover datos entre capas de manera eficiente con Spark y Data Factory.**

### **Preguntas para reflexión y discusión**

1️⃣ ¿Cómo puedo asegurar la gobernanza y calidad de los datos en cada capa?  
2️⃣ ¿Cuándo debo utilizar un Data Warehouse en vez de un Lakehouse para la capa Oro?  
3️⃣ ¿Qué impacto tiene la arquitectura Medallón en el rendimiento de las consultas en Fabric?