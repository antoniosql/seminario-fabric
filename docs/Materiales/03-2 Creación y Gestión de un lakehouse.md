## **1. Definición y ventajas de un Lakehouse frente a un Data Warehouse tradicional**

### 🔹 **¿Qué es un Lakehouse?**

Un **Lakehouse** en Microsoft Fabric es una arquitectura híbrida que combina lo mejor de un **Data Lake** y un **Data Warehouse**, permitiendo almacenar, procesar y analizar tanto datos estructurados como no estructurados en un solo entorno​.

📌 **Diferencias clave entre un Lakehouse y un Data Warehouse**

|**Característica**|**Lakehouse**|**Data Warehouse**|
|---|---|---|
|**Tipo de datos**|Estructurados, semiestructurados y no estructurados.|Solo datos estructurados.|
|**Almacenamiento**|Basado en **OneLake** con formato **Delta Lake**.|Bases de datos relacionales con ACID completo.|
|**Procesamiento**|Compatible con **Spark, SQL y Pipelines de Data Factory**.|Optimizado para consultas SQL transaccionales.|
|**Flexibilidad**|Almacena archivos en diferentes formatos (Parquet, JSON, CSV).|Depende de modelos tabulares predefinidos.|
|**Costos**|Escalable según el consumo, sin necesidad de hardware dedicado.|Costoso debido a infraestructura optimizada para rendimiento SQL.|

📌 **¿Cuándo usar un Lakehouse?**  
✅ **Cuando se manejan datos diversos** (logs, sensores IoT, imágenes, documentos y datos tabulares).  
✅ **Si se requiere alta escalabilidad y flexibilidad** sin necesidad de una estructura rígida.  
✅ **Cuando se desea combinar Spark con SQL** para análisis avanzados​.

---

## **2. Implementación práctica de un Lakehouse en Microsoft Fabric**

### 🔹 **Pasos para crear un Lakehouse en Fabric**

1️⃣ **Acceder al entorno de Fabric**

- Ir a **Microsoft Fabric** → **Data Engineering** → **Nuevo Lakehouse**.
- Asignar un nombre y confirmar la creación​.

2️⃣ **Cargar datos en OneLake**

`df = spark.read.format("csv").option("header", "true").load("onelake://empresa/datos_ventas/") df.write.format("delta").save("onelake://empresa/lakehouse/ventas/")`

📌 **Explicación:**

- Se ingestan datos en formato CSV.
- Se convierten a **Delta Lake** para mayor eficiencia.

3️⃣ **Consulta de datos en SQL Analytics Endpoint**

`SELECT categoria, SUM(ventas) AS total_ventas FROM lakehouse.ventas GROUP BY categoria;`

📌 **Permite a analistas y usuarios SQL acceder a los datos directamente**​

4️⃣ **Visualización en Power BI con Direct Lake**

- Conectar Power BI con el **SQL Analytics Endpoint del Lakehouse**.
- Crear dashboards interactivos en tiempo real​.

### 🔹 **Ficheros y Tablas**

Dentro de un lakehouse, tenemos dos áreas diferenciadas de almacenamiento, la de Ficheros y la tablas. El área de **ficheros**, está destinada fundamentalmente a actuar como zona de aterrizaje (landing) de los datos, y para alojar datos no estructurados, como pueden ser imágenes, dentro de nuestro lakehouse. La funcionalidad de accesos directos, ya comentada, proporciona una capa de "virtualización" que intenta minimizar el movimeinto de datos, posibilitando el acceso entre diferentes orígenes, incluso entre diferentes proveedores de nube pública. 

Por lo que respecta al área de **tablas**, su función es la de proporcionarnos una experiencia warehouse, sobre los datos que tenemos almacenados en nuestro onelake, siempre en formato Delta. Podemos crear básicamente tres tipos diferenciados de tablas dentro de este área: tablas administradas, tablas externas, y accesos directos de tabla

#### **Tablas administradas**
Son aquellas tablas de las que el motor Spark del lakehouse se encarga de gestionar y mantener, tanto en esquema como en datos. Son el tipo de tabla determinado, y el que proporciona toda la funcionalidad a nuestro lakehouse de control y mantenimiento de los datos. 

#### **Tablas externas**
Se conocen también como tablas externas, y en este caso, la tabla no es más que una definición de un esquema, que apunta a una ubicación externa. El esquema se fuerza únicamente en el momento de consulta de esa tabla. 
Nos puede ser útil, fundamentalmente en la capa silver, en escenarios en los que el esquema de los datos de origen, es susceptible de cambiar con frecuencia.

#### **Accesos directos de tabla**

Además de poder crear shortcuts a almacenamientos de ficheros en el área **Files**  de un lakehouse, también podemos crear estos accesos directos a tablas externas, lo que nos permitirá poder acceder a esas tablas desde el SQL Endpoint, como si estuviesen realmente almacenadas en ese ítem de lakehouse. 
Si pensamos en nuestra arquitectura medallón, y en el paso entre capas, los shortcuts nos pueden servir para, por ejemplo, referenciar tablas que no necesitamos modificar en el paso entre capas, evitando así tener que copiar y duplicar esas tablas entre las diferentes capas.  

---
## **3. El SQL Analytics Endpoint

### 🔹**Consultando con SQL el lakehouse**

El **punto de conexión de análisis SQL** en Microsoft Fabric ofrece una experiencia basada en SQL para interactuar con las tablas Delta dentro de un almacén de lago (_lakehouse_). A continuación, se detallan sus características principales:

- **Creación automática**: Al generar un almacén de lago, se crea automáticamente un punto de conexión de análisis SQL que apunta al almacenamiento de tablas Delta del mismo.    
- **Modo de solo lectura**: Este punto de conexión permite únicamente operaciones de lectura sobre las tablas Delta. Para modificar los datos, es necesario cambiar al modo de almacén de lago y utilizar Apache Spark.
- **Flexibilidad en la gestión de datos**: Aunque las operaciones de escritura no están permitidas, se pueden crear funciones, definir vistas e implementar seguridad a nivel de objeto en SQL para estructurar y gestionar el acceso a los datos de manera efectiva.
- **Control de acceso mediante seguridad SQL**: Es posible establecer reglas de seguridad a nivel de objeto que se aplican al acceder a los datos a través del punto de conexión de análisis SQL. Para garantizar que los datos no sean accesibles por otros medios, se deben configurar los roles y permisos adecuados en el área de trabajo.
- **Reaprovisionamiento del punto de conexión**: Si el aprovisionamiento inicial falla, se ofrece la opción de reintentar directamente desde el almacén de lago, evitando la necesidad de crear uno nuevo.
- **Limitaciones actuales**: Las tablas Delta externas creadas con código Spark no son visibles para el punto de conexión de análisis SQL. 

Resumiendo, el punto de conexión de análisis SQL en Microsoft Fabric facilita el análisis y la gestión de datos en lakehouses mediante T-SQL, proporcionando una integración fluida y herramientas robustas para el control de acceso y la estructuración de datos.


--- 

## **4. Gobernanza y seguridad: Configuración de accesos y permisos**

### 🔹 **Esquemas en un lakehouse**

Microsoft Fabric Lakehouse admite la creación de esquemas personalizados, lo que permite agrupar tablas para mejorar la detección de datos, el control de acceso y la organización. Al crear un nuevo lakehouse, es posible habilitar esta función seleccionando la opción "Esquemas de lakehouse (versión preliminar pública)". Una vez creado, nos encontraremos un esquema predeterminado llamado "dbo" bajo la sección de Tablas, el cual es permanente y no puede ser modificado o eliminado. 

Para almacenar una tabla en un esquema específico, es necesario especificar el nombre del esquema al guardar la tabla. Si no se indica, la tabla se ubicará en el esquema predeterminado "dbo". Por ejemplo, utilizando PySpark, se podemos guardar una tabla en el esquema "ventas" con el siguiente comando:

`df.write.mode("Overwrite").saveAsTable("ventas.nombre_tabla")`

Además, el **Explorador** de Lakehouse permite organizar las tablas mediante la función de arrastrar y soltar, facilitando su reubicación entre diferentes esquemas. Es importante tener en cuenta que, al modificar una tabla, también se deben actualizar los elementos relacionados, como el código en cuadernos o los flujos de datos, para asegurar que estén alineados con el esquema correcto. Obviamente estas tareas no se realizan automáticamente. 

- Para **referenciar múltiples tablas Delta** desde otro lakehouse de Fabric o desde un almacenamiento externo, se puede utilizar un acceso directo de esquema. Este acceso muestra todas las tablas bajo el esquema o carpeta seleccionados, reflejando cualquier cambio realizado en las tablas de la ubicación de origen. 

- En el contexto de la elaboración de informes con **Power BI**, al crear un modelo semántico, es posible seleccionar tablas de diferentes esquemas. Si existen tablas con el mismo nombre en distintos esquemas, se mostrarán números junto a los nombres de las tablas en la vista de modelo para diferenciarlas.

- Al trabajar con **cuadernos** en un lakehouse que tiene habilitados los esquemas, las tablas se organizan según sus respectivos esquemas en el explorador de objetos del cuaderno. Es posible arrastrar y soltar una tabla en una celda de código para obtener un fragmento de código que hace referencia al esquema correspondiente. La nomenclatura para referenciar una tabla sigue el formato: "área_de_trabajo.lakehouse.esquema.tabla". Si se omite algún elemento, el ejecutor utilizará la configuración predeterminada; por ejemplo, si solo se proporciona el nombre de la tabla, se asumirá el esquema "dbo" del lakehouse predeterminado para el cuaderno.
- Para realizar **consultas SQL de Spark** que involucren múltiples áreas de trabajo, se utiliza la nomenclatura "área_de_trabajo.lakehouse.esquema.tabla" al referenciar las tablas en el código. Esto permite combinar tablas de diferentes áreas de trabajo, siempre que el usuario que ejecuta el código tenga los permisos necesarios para acceder a dichas tablas. Es fundamental asegurarse de que las tablas provengan de lakehouses con esquemas habilitados, ya que la combinación de tablas de lakehouses sin esquemas habilitados no funcionará.


Actualmente (Febrero 2025), en la versión preliminar pública, existen algunas limitaciones. Por ejemplo, el uso del área de trabajo en el espacio de nombres para lakehouses compartidos no funciona correctamente, y obtener el esquema para tablas administradas en formatos no Delta (como CSV) no está soportado. 

### 🔹 **Modelo de seguridad en un Lakehouse**

📌 Microsoft Fabric permite la gestión de permisos en un **Lakehouse** mediante **roles y controles de acceso**​.

|**Rol**|**Permisos**|
|---|---|
|**Admin**|Acceso total, configuración y eliminación de Lakehouse.|
|**Member**|Lectura y escritura de datos, ejecución de scripts.|
|**Contributor**|Creación y modificación de objetos, sin configuración de seguridad.|
|**Viewer**|Solo lectura de datos desde SQL Analytics Endpoint.|
Estos permisos se establecen a nivel de workspace y se heredan en todos los items, también los lakehouse. 
### 🔹 **Implementación de seguridad en Lakehouse**

Desde el punto de vista de acceso al lakehouse, como cualquier otro item del espacio de trabajo, tendrán acceso predeterminado los usuarios a los que hayamos dado acceso a través de los roles del espacio de trabajo. En el caso de los usuarios con el rol de visor, tendrán acceso al SQL EndPoint, pero no podrán acceder al item de lakehouse. Sin embargo, podemos compartir con un usuario el acceso al endpoint SQL de nuestro lakehouse, sin necesidad de darle permisos sobre ningún otro item del espacio de trabajo. Esto lo realizamos desde la opción de compartir del lakehouse

![[Compartir acceso lakehouse.png]]
Una vez hemos configurado el acceso, podemos llegar a niveles más granulares, controlando el acceso a las tablas, a través de los roles que veremos en el SQL Endpoint y la seguridad a nivel de columna y a nivel de fila, que configuramos a través de las políticas de seguridad. 


1️⃣ **Definir accesos mediante RBAC (Role-Based Access Control)**

`GRANT SELECT ON lakehouse.ventas TO [grupo_finanzas];`

📌 **Restringe acceso solo a usuarios autorizados**​.

2️⃣ **Uso de Column-Level Security (CLS) y Row-Level Security (RLS)**

`CREATE SECURITY POLICY Ventas_Politica ADD FILTER PREDICATE usuario_region = USER() ON lakehouse.ventas;`

📌 **Permite restringir filas según el usuario autenticado**​.

3️⃣ **Uso de Shortcuts en OneLake para compartir datos sin replicarlos**

`CREATE SHORTCUT ventas_region TO "onelake://empresa/lakehouse/ventas/"`

📌 **Facilita compartir datos con otros equipos sin duplicaciones**​.

Tenemos que asegurarnos también, de que antes de todo esto, los usuarios tienen los permisos necesarios a nivel de almacenamiento de Onelake. Podemos ver la combinación de opciones en este enlace de la documentación [Seguridad RBAC y Onelake](https://learn.microsoft.com/es-es/fabric/onelake/security/data-access-control-model?wt.mc_id=MVP_329801 )

---

## **5. Mantenimiento de tablas**

Como ocurre en cualquier motor de datos, debemos de realizar labores de mantenimiento sobre nuestros datos. Disponemos de una opción a través del interfaz gráfico de mantenimiento de tablas que nos proporciona las funcionalidades mínimas para realizar ese mantenimiento. 

![[Mantenimiento tablas lakehouse.png]]

La característica de mantenimiento de tablas nos ofrece tres operaciones.

- **Optimización**: consolida varios archivos Parquet pequeños en archivos grandes. Las arquitecturas de big data y lakehouse, están pensadas para trabajar con archivos de gran tamaño. Tener archivos de tamaño superior a 128 MB y, de forma óptima, cerca de 1 GB, mejora la compresión y la distribución de datos, en los nodos del clúster. Reduce la necesidad de examinar numerosos archivos pequeños para realizar operaciones de lectura eficaces. Por lo tanto, se recomienda ejectura estrategias de optimización orientadas a reducir el número de ficheros. 
- **Orden en V (V-order)**: aplica la ordenación, la codificación y la compresión optimizadas a los archivos Parquet delta para permitir operaciones de lectura rápidas en todos los motores de Fabric. Para más detalle sobre el funcionamiento de esta optimización, podemos consultar este enlace de la documentación oficial  [V-Order](https://learn.microsoft.com/es-es/fabric/data-engineering/delta-optimization-and-v-order?wt.mc_id=MVP_329801&tabs=sparksql) 
- **Vacuum**: quita los archivos antiguos a los que ya no hace referencia un registro de tabla de Delta. Los archivos deben ser más antiguos que el umbral de retención, y este es por defecto de siete días. Todas las tablas delta de OneLake tienen el mismo período de retención. El período de retención de archivos es el mismo independientemente del motor de proceso de Fabric que estemos utilizando. Este mantenimiento es importante para optimizar el costo de almacenamiento. Establecer un período de retención más corto afecta a las funcionalidades de viaje en el tiempo de Delta. 

---

## **6. Direct Lake**

**Direct Lake** es una opción de modo de almacenamiento para las tablas de un modelo semántico de Power BI almacenado en un área de trabajo de Microsoft Fabric. Está optimizado para grandes volúmenes de datos que se pueden cargar rápidamente en la memoria desde tablas Delta, las cuales almacenan sus datos en archivos Parquet en **OneLake**, el repositorio unificado para todos los datos analíticos. Una vez cargados en memoria, el modelo semántico permite consultas de alto rendimiento, eliminando la necesidad de importar datos al modelo, lo que suele ser un proceso lento y costoso.

![[Direct lake.png]]

- **Carga Rápida de Datos**: Permite la carga eficiente de grandes volúmenes de datos en memoria, facilitando análisis más rápidos.    
- **Actualizaciones Eficientes**: Las operaciones de actualización analizan los metadatos de las tablas Delta y actualizan el modelo para referenciar los archivos más recientes en OneLake, reduciendo el tiempo y los recursos necesarios en comparación con las actualizaciones tradicionales.    
- **Optimización de Recursos**: Al eliminar la necesidad de importar datos, se reduce el consumo de recursos de capacidad, como memoria y CPU.

Los modelos semánticos en modo Direct Lake se conectan a tablas o vistas de un único lakehouse o warehouse en Fabric. Durante una operación de actualización, el modelo analiza los metadatos de la versión más reciente de las tablas Delta y se actualiza para referenciar los archivos más recientes en OneLake. Este proceso, conocido como "operación de enmarcado", es rápido y de bajo costo en comparación con las actualizaciones tradicionales que implican la copia completa de los datos



--- 

## **7. Conclusión y Preguntas Clave**

✅ **Un Lakehouse en Microsoft Fabric combina lo mejor de los Data Lakes y Data Warehouses.**  
✅ **Se puede implementar rápidamente en OneLake y optimizar su rendimiento con Delta Lake.**  
✅ **Los controles de seguridad y accesos permiten restringir y gestionar usuarios de manera eficiente.**

### **Preguntas para reflexión y discusión**

1️⃣ ¿Cuáles son las ventajas de un **Lakehouse** sobre un **Data Warehouse** en mi empresa?  
2️⃣ ¿Cómo se pueden aplicar **Row-Level Security** y **Column-Level Security** en Fabric?  
3️⃣ ¿Cuándo usar **Power BI con Direct Lake** en vez de otros modelos de conexión?