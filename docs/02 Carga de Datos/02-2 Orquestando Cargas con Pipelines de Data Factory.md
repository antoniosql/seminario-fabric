# **Orquestando Cargas con Pipelines de Data Factory

## **1. Introducción a los Pipelines en Microsoft Fabric**

La **orquestación de datos** es un proceso fundamental en cualquier ecosistema de análisis de datos, permitiendo **automatizar, programar y gestionar flujos de trabajo ETL** (Extract, Transform, Load). Microsoft Fabric, a través de **Data Factory y sus Pipelines**, proporciona una solución escalable y flexible para la **carga, transformación y movimiento de datos en la nube**.

### **📌 ¿Por qué es importante la Orquestación en Fabric?**

✔ **Automatización del movimiento de datos** entre diversas fuentes y destinos.  
✔ **Gestión de dependencias** entre actividades de carga y transformación.  
✔ **Monitorización y control de ejecución** con opciones de reintento y alertas.  
✔ **Integración con otros servicios** como Power BI, Dataflows Gen2 y OneLake.

### 🔹 **¿Qué es un Pipeline en Microsoft Fabric?**

Un **Pipeline en Data Factory** dentro de Microsoft Fabric es un flujo de trabajo **automatizado** que permite la ingesta, transformación y movimiento de datos a través de múltiples fuentes y destinos.

Un Espacio de Trabajo de Microsoft Fabric  puede tener una o más canalizaciones. Una canalización es una agrupación lógica de actividades que juntas realizan una tarea. Por ejemplo, una canalización podría contener un conjunto de actividades que ingieren y limpian datos de registro y luego inician un flujo de datos para analizar los datos de registro. La canalización nos permite gestionar las actividades como un conjunto en lugar de cada una individualmente. 

**Características clave de los Pipelines en Fabric:**  
✅ **Orquestación de procesos ETL/ELT** con lógica condicional y ejecución programada.  
✅ **Integración con múltiples fuentes** como **Azure SQL, OneLake, AWS S3, Google Cloud** y más.  
✅ **Automatización de flujos de datos** entre Dataflows Gen2, Lakehouses y Data Warehouses.  
✅ **Escalabilidad y paralelización**, permitiendo el procesamiento eficiente de grandes volúmenes de datos​.
### **📌 Principales características de los Pipelines en Fabric**

✔ **Definición visual o basada en código:** Se pueden construir desde una interfaz gráfica o con JSON.  
✔ **Activación basada en eventos:** Los pipelines pueden ejecutarse según reglas de negocio o disparadores temporales.  
✔ **Escalabilidad:** Soporta cargas de trabajo que van desde megabytes hasta petabytes de datos.  
✔ **Integración con múltiples fuentes:** SQL, OneLake, Azure Data Lake, APIs, entre otros.

📌 **Ejemplo de caso de uso:**  
Imagina que una empresa necesita **extraer datos de ventas desde un sistema SAP, transformarlos y almacenarlos en un Data Warehouse en Fabric**. Un **Pipeline de Data Factory** puede:  

1️⃣ **Ejecutar un proceso de extracción** desde SAP.  
2️⃣ **Transformar los datos con un Notebook en Spark**.  
3️⃣ **Cargar los datos en OneLake** para su análisis en Power BI.
### 🔹 **Principales Componentes de un Pipeline**

Un pipeline de Data Factory en Microsoft Fabric se compone de:

1️⃣ **Actividades:** Representan pasos dentro del pipeline, como copia de datos, transformación o ejecución de scripts.  
2️⃣ **Conjuntos de Datos:** Conexiones a fuentes y destinos de datos.  
3️⃣ **Flujos de Control:** Reglas de ejecución como condicionales y bucles.  
4️⃣ **Eventos y Programadores:** Permiten ejecutar el pipeline en función de triggers específicos​.

#### **Actividades** 

Las actividades en una canalización definen acciones a realizar con los datos. Por ejemplo, podemos usar una actividad de copia para copiar datos de SQL Server a Azure Blob Storage. Luego, usaremos una actividad de Dataflow o una actividad de Notebook para procesar y transformar datos del almacenamiento de blobs a un grupo de Azure Synapse Analytics sobre el cual se crean soluciones de informes de inteligencia empresarial.

Microsoft Fabric tiene tres tipos de actividades: actividades de **movimiento de datos**, actividades de **transformación de datos** y actividades de **control**.

##### **Actividades de movimiento de datos**
Realmente solo tenemos una actividad que es la actividad de copia de datos. Para copiar datos de un origen a un destino, el servicio que ejecuta la actividad de copia realiza estos pasos:

1. Lee datos desde un almacén de datos de origen.
2. Realiza procesos de serialización y deserialización, compresión y descompresión, asignación de columnas, etc. Realiza estas operaciones en función de la configuración.
3. Escribe datos en el almacén de datos de destino.

##### **Actividades de transformación**
Son las actividades que nos permiten realizar transformaciones sobre los datos. Son las siguientes:

| Actividad de transformación de datos | Entorno de procesos                                          |
| ------------------------------------ | ------------------------------------------------------------ |
| Copia de datos                       | Administrador de proceso de Microsoft Fabric                 |
| Dataflow Gen2                        | Administrador de proceso de Microsoft Fabric                 |
| Eliminación de datos                 | Administrador de proceso de Microsoft Fabric                 |
| Fabric Notebook                      | Clústeres de Apache Spark administrados por Microsoft Fabric |
| Actividad de HDInsight               | Clústeres de Apache Spark administrados por Microsoft Fabric |
| Definición de trabajos de Spark      | Clústeres de Apache Spark administrados por Microsoft Fabric |
| Procedimiento almacenado             | Azure SQL, Azure Synapse Analytics o SQL Server              |
| Script de SQL                        | Azure SQL, Azure Synapse Analytics o SQL Server              |
##### **Actividades de Flujo de Control**

Son las actividades que nos permiten modificar el flujo de ejecución de nuestro pipeline, tales como Bucles, actividades, condicionales, notificaciones, etc.. 
### 🔹 **Ejemplo de un pipeline en Fabric**

Un pipeline típico puede extraer datos desde **un ERP en SQL Server**, transformarlos con un **Notebook en Spark**, y cargarlos en **un Data Warehouse en Fabric** para su consumo en Power BI​.


---

## **2. Actividad de Copia en Detalle**

### 🔹**Comportamiento de la actividad de copia**
En la actividad de copia de datos, podemos elegir entre los siguientes modos de carga de datos.
- **Modo de copia completa**: cada trabajo de copia que se ejecuta copia todos los datos del origen al destino a la vez.
- **Modo de copia incremental**: la ejecución del trabajo inicial copia todos los datos y el trabajo posterior solo copia los cambios desde la última ejecución. Los datos modificados se anexan al almacén de destino. En el modo de copia incremental, deberemos de seleccionar una columna incremental para cada tabla para identificar los cambios. El trabajo de copia usa esta columna como marca de agua, comparando su valor con el mismo desde la última ejecución para copiar solo los datos nuevos o actualizados. La columna incremental debe ser una marca de tiempo o un INT incremental.

También podemos elegir cómo se escriben los datos en el almacén de destino.

De manera predeterminada, el trabajo de Copia **anexa** datos al destino, de modo que no se pierda ningún historial de cambios. Pero también podemos ajustar el comportamiento de escritura a **upsert** o **sobrescribir**.

- Cuando se copian datos en el almacén de almacenamiento: las nuevas filas de las tablas o archivos se copian en archivos nuevos en el destino. Si ya existe un archivo con el mismo nombre en el almacén de destino, se sobrescribirá.
- Al copiar datos en una base de datos: las nuevas filas de las tablas o archivos se anexan a las tablas de destino. Podemos cambiar el comportamiento de escritura a upsert (en SQL DB o SQL Server) o sobrescribir (en tablas de Fabric Lakehouse).

### 🔹 **Escalabilidad y Rendimiento de la Actividad de Copia**

Las canalizaciones de Data Factory ofrecen una arquitectura sin servidor que permite el paralelismo en distintos niveles. Esta arquitectura hace posible el desarrollo de canalizaciones que maximizan el rendimiento del movimiento de datos para nuestro entorno. Estas canalizaciones hacen un uso completo de los siguientes recursos:

- Ancho de banda de red entre los almacenes de datos de origen y destino
- Operaciones de entrada/salida por segundo (IOPS) y ancho de banda del almacén de datos de origen o destino

La copia puede escalarse en diferentes niveles:

- El **flujo de control** puede iniciar varias actividades de copia en paralelo, por ejemplo, mediante un bucle ForEach.
- Una sola actividad de copia puede aprovechar los **recursos de proceso escalables**.
    - Puede especificar la optimización de rendimiento inteligente como máximo para cada actividad de copia y sin servidor.
- Una única actividad de copia lee y escribe en el almacén de datos **mediante varios subprocesos** en paralelo.

![Actividad Copia Configuración](<imagenes/Actividad Copia Configuracion.png>)

#### **Copia Paralela**

Podemos establecer el valor de la propiedad "Grado de paralelismo de copia" en la configuración de la actividad.  Esta propiedad se define como el número máximo de subprocesos dentro de la actividad de copia. Los subprocesos operan en paralelo. Estos subprocesos leen desde el origen o escriben en los almacenes de datos de destino.

La copia paralela es independiente de la configuración de optimización de rendimiento inteligente. Para cada ejecución de la actividad de copia, el servicio aplica dinámicamente la configuración de copia paralela óptima en función del patrón de datos y el par de destino de origen.

Para controlar la carga en las máquinas que hospedan los almacenes de datos o para optimizar el rendimiento de la copia, podemos modificar el valor predeterminado y especificar un valor para el grado de paralelismo. El valor debe ser un entero mayor o igual que 1. En tiempo de ejecución, y para obtener el mejor rendimiento, la actividad de copia usa un valor inferior o igual al valor que ha establecido.

#### **Optimización Inteligente del rendimiento**

La optimización del rendimiento inteligente permite al servicio optimizar el rendimiento mediante la combinación de los factores de asignación de recursos de CPU, memoria y red y el coste esperado de ejecutar una única actividad de copia. Las opciones permitidas para habilitar una ejecución de actividad de copia de forma inteligente son **Automático, Estándar, Equilibrado, Máximo**. También podemos especificar el valor **entre 4 y 256**.

En la tabla siguiente se muestra el valor recomendado en diferentes escenarios de copia:

Expandir tabla

|Valor|Descripción|
|---|---|
|**Automático**|Permitir que el servicio aplique dinámicamente la optimización óptima del rendimiento en función del patrón de datos y el par de destino de origen.|
|**Estándar**|Permitir que el servicio aplique dinámicamente la optimización del rendimiento en los recursos de proceso estándar en función del patrón de datos y el par de destino de origen.|
|**Equilibrada**|Permitir que el servicio aplique dinámicamente la optimización del rendimiento que equilibra el rendimiento y los recursos de proceso disponibles en función del patrón de datos y el par de destino de origen.|
|**Máxima**|Permitir que el servicio aplique dinámicamente la optimización del rendimiento mediante el uso de los recursos de proceso máximos disponibles en función del patrón de datos y el par de destino de origen.|

#### **Optimización al leer del origen**
La actividad de copia también tiene configuraciones de optimización en la lectura de datos, que dependen de los orígenes de datos que utilicemos. Si nos fijamos en el caso concreto, por ejemplo de un origen SQL Server, vemos las siguientes opciones:

![PArtición lectura origen SQL pipeline](<imagenes/Partición lectura origen SQL pipeline.png>)

Al habilitar la copia con particiones, la actividad de copia ejecuta consultas en paralelo en el origen de SQL Server para cargar los datos por particiones. El grado en paralelo se controla mediante el valor `parallelCopies` de la actividad de copia. Por ejemplo, si establecemos `parallelCopies` en cuatro, el servicio genera y ejecuta al mismo tiempo cuatro consultas de acuerdo con la configuración y la opción de partición que hemos especificado, y cada consulta recupera una porción de datos de SQL Server.

### 🔹 **Carga Incremental**

La actividad de copia, a diferencia del dataflow, no está orientada a aplicar transformaciones, por lo que no tenemos una configuración concreta para la carga incremental. Sin embargo, esto depende de los tipo de origen de datos que manejemos. Por ejemplo, en caso de los ficheros tenemos esta configuración:

![Filtro modificación ficheros pipelines](<imagenes/Filtro modificación ficheros pipelines.png>)

Esta opción comprueba la fecha de modificación de los ficheros, y si se encuentra en el intervalo especificado, los lee, y sino, los descarta. 

---


## **3. Automatización de cargas ELT y administración de dependencias**

### 🔹 **Automatización de cargas en Fabric Data Factory**

Los pipelines permiten configurar **flujos de trabajo completamente automatizados**, asegurando que los datos sean procesados sin intervención manual.

📌 **Métodos de automatización en Data Factory:**  
✅ **Programación basada en tiempo:** Ejecución de pipelines a intervalos definidos.  
✅ **Eventos y Triggers:** Disparo automático cuando nuevos datos están disponibles.  
✅ **Condicionales y Flujos de decisión:** Dependencias entre tareas dentro del pipeline.

En el caso concreto de los triggers y evento, estos se disparan creando una alerta sobre un eventstream de un Azure Blob Storage. Esta es la única configuración soportada por el momento. 

![Triggers Pipelines](<imagenes/Triggers Pipelines.png>)

### 🔹 **Administración de dependencias en pipelines**

En escenarios donde las tareas deben ejecutarse en orden, es necesario definir **dependencias** entre actividades.

📌 **Tipos de dependencias en Data Factory:**

- **Encadenamiento de actividades:** Una actividad solo inicia si la anterior se completa con éxito.
- **Ejecución paralela:** Varias actividades pueden ejecutarse al mismo tiempo para optimizar rendimiento.
- **Reintentos automáticos:** Si una tarea falla, se pueden configurar intentos adicionales​

Las dependencias entre las actividades del pipeline, se configuran a la hora de conectar las actividades.

![Dependencias de Actividades pipeline](<imagenes/Dependencias de Actividades pipeline.png>)

- Flecha gris, para decidir que actividad ejecutar cuando se omita la ejecución de la actividad actual
- Verde, para cuando se ejecute correctamente
- Roja para cuando falle
- Azul, siempre que finalice

🔹 **Ejemplo de un flujo ELT automatizado**  

1️⃣ Un **Pipeline en Data Factory** extrae datos de una API y almacena en OneLake.  
2️⃣ Se activa un **Notebook en Spark** para transformar los datos.  
3️⃣ Se ejecuta una consulta SQL para cargar datos en un **Data Warehouse en Fabric**.  
4️⃣ **Power BI actualiza automáticamente los dashboards** cuando los datos están listos​


---

## **4. Monitorización de procesos de carga y troubleshooting**

### 🔹 **Herramientas de monitorización en Fabric Data Factory**

Microsoft Fabric incluye herramientas avanzadas para monitorear la ejecución de los pipelines y resolver errores rápidamente.

📌 **Opciones de monitorización disponibles:**  
✅ **Fabric Monitor:** Proporciona logs en tiempo real y estadísticas de ejecución.  
✅ **Registro de errores en ejecución:** Muestra detalles de cada actividad y su estado.  
✅ **Alertas y notificaciones:** Configuración de alertas en caso de fallos​fabric-fundamentals.


### 🔹 **Uso de Copilot para Troubleshooting**

Fabric Data Factory incluye **Copilot** (a partir de F64), una herramienta de IA que ayuda a identificar y solucionar problemas en pipelines​.

📌 **Ejemplo de troubleshooting con Copilot:**  
1️⃣ Se detecta una falla en la actividad de copia de datos.  
2️⃣ Copilot analiza los logs y proporciona una descripción del error.  
3️⃣ Se sugiere una solución, como **ajustar el formato del archivo fuente o modificar permisos en la base de datos**​fabric-fundamentals.

🔹 **Ejemplo real de monitorización**  
Una empresa usa Fabric para integrar datos de distintos departamentos. Un pipeline programado diariamente **falla intermitentemente** debido a cambios en la estructura de los archivos de origen. **Fabric Monitor** y **Copilot** identifican el problema y sugieren una transformación automática para corregirlo​.

---

## **5. Hands-On: Orquestando procesos**

### 🔹 **Objetivo del ejercicio**

En este laboratorio, el objetivo es entender como orquestar realmente las ingestas de datos desde "el exterior" a Microsoft Fabric, generando las transformacions con Dataflows de Generación 2, y orquestando el proceso con la actividad de Dataflows de las Pipelines. Utilizaremos el Dataflow generado en el ejercicio anterior

### 🔹 **Pasos del ejercicio**

1.  Crea un elemento de tipo **Data pipeline**. 
2. En la opción de Comenzar con un lienzo en blanco, selecciona, Actividad de canalización y selecciona **Flujo de Datos**. 
3. En la pestaña de configuración, selecciona el Dataflow generado en el ejercicio anterior
4. Agrega una actividad de **Teams** y conéctala cuando finalice correctamente la actividad de Flujo de Datos. 
5. Desde la pestaña de Configuración inicia sesión en Teams
6. En Post-In selecciona donde quieres publicar. Tenemos dos opciones: Canal o Chat de Grupo
7. Compón un mensaje 
8. Ejecuta el pipeline. Debería de ejecutarse correctamente y llegarte el mensaje a Teams

![Mensaje en Teams de pipeline](<imagenes/Mensaje Teams pipeline.png>)

---

## **6. Conclusión y Preguntas Clave**

✅ **Los Pipelines en Data Factory permiten automatizar flujos ETL y orquestar cargas de datos.**  
✅ **Las dependencias entre actividades aseguran que las cargas de datos se ejecuten de forma ordenada.**  
✅ **Las herramientas de monitoreo y troubleshooting facilitan la detección y corrección de errores.**  
✅ **El uso de Copilot permite optimizar el mantenimiento y resolución de problemas en pipelines.**

### **Preguntas de reflexión**

9. ¿Cuáles son las ventajas de usar triggers en vez de programaciones manuales en un pipeline?
10. ¿Cómo se pueden optimizar los pipelines para manejar grandes volúmenes de datos?
11. ¿Cómo se puede aprovechar Copilot para mejorar la depuración de errores en pipelines?