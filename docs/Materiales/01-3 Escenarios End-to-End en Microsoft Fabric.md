## **1. ETL con Microsoft Fabric: Uso de Dataflows Gen2 y Pipelines**

### 🔹 **Introducción a los procesos ETL en Fabric**

En Microsoft Fabric, los procesos ETL (Extract, Transform, Load) pueden realizarse a través de tres  herramientas principales:

1. **Dataflows Gen2** (para transformaciones sin código o de bajo código).
2. **Pipelines en Data Factory** (para cargas y orquestación más avanzadas).
3. **Notebooks** de PySpark, con código completamente personalizable

Ambas herramientas están diseñadas para simplificar la ingesta y transformación de datos, integrándose con **OneLake, Lakehouses y Data Warehouses**.

### 🔹 **Dataflows Gen2: Transformaciones sin código**

Los **Dataflows Gen2** permiten la creación de procesos ETL en un entorno visual, facilitando:  
✅ Conexión con múltiples fuentes de datos, incluyendo **OneLake, SQL, SaaS y APIs**.  
✅ Uso de **Power Query** para transformaciones sin necesidad de programación.  
✅ **Automatización de cargas periódicas** con programación de actualizaciones.

📌 **Ventajas de Dataflows Gen2**

- Ideal para **usuarios de negocio y analistas de datos** que necesitan transformar datos sin escribir código.
- Se ejecuta directamente en **Microsoft Fabric**, evitando la necesidad de exportaciones a otros servicios.
- Puede alimentar **modelos semánticos de Power BI** sin pasos adicionales.

Una de las grandes diferencias entre los Dataflows tradicionales y los Dataflows de Generación 2, es que estos últimos pueden almacenar el resultado de sus ejecuciones en diferentes destinos
![[Dataflow Gen2 Destinos.png]]
### 🔹 **Pipelines de Data Factory: Orquestación avanzada**

Los **Pipelines en Data Factory** dentro de Fabric proporcionan una solución **más avanzada y escalable** para la integración de datos:  
✅ Permite la creación de **flujos de trabajo de datos complejos** con múltiples pasos.  
✅ Integración con **Azure Data Factory** para reutilización de flujos existentes.  
✅ Soporta **activadores y ejecución basada en eventos**, lo que facilita la automatización de cargas.

📌 **Diferencias entre Dataflows Gen2 y Pipelines**

|**Característica**|**Dataflows Gen2**|**Pipelines en Data Factory**|
|---|---|---|
|**Orientación**|Usuarios de negocio, analistas|Ingenieros de datos, arquitectos|
|**Código necesario**|No-Code/Low-Code (Power Query)|Requiere configuración avanzada|
|**Escalabilidad**|Adecuado para volúmenes moderados de datos|Ideal para cargas de datos masivas|
|**Automatización**|Programaciones básicas|Orquestación avanzada con dependencias|

🔹 **Ejemplo práctico**: Un **Dataflow Gen2** puede usarse para transformar datos de ventas en bruto en **OneLake**, mientras que un **Pipeline** se encargará de la carga incremental en un **Data Warehouse**​fabric-fundamentals.
### 🔹 **Notebooks de PySpark**

Para cargas de trabajo que requieran de la flexibilidad que proporciona un lenguaje de programación como Python, escalando a través de Apache Spark, tenemos la posibilidad de escribir todos nuestros procesos utilizando Notebooks de PySpark. Son una opción flexible, porque además de tener a nuestra disposición una gran cantidad de librerías para procesado, y toda la potencia de los clústeres de Apache Spark, estos Notebooks son la opción que más nos aísla de Microsoft Fabric. Si por ejemplo, el día de mañana queremos migrar alguna carga de trabajo a Databricks, podríamos reutilizar una gran cantidad de ese código, algo que no es posible si utilizamos Dataflows y muy complicado con los Pipelines de Data Factory. 

---

## **2. Almacenamiento y Análisis: Integración con Lakehouses y Data Warehouses**

### 🔹 **Lakehouses en Microsoft Fabric**

El **Lakehouse** es una combinación de **Data Lake y Data Warehouse**, permitiendo almacenar y analizar datos en un único entorno.

✅ Basado en el formato **Delta Lake**, lo que permite transacciones ACID y versionado de datos.  
✅ Integrado con **OneLake**, lo que elimina la duplicación de datos.  
✅ Soporta acceso desde **T-SQL y Spark**, facilitando la colaboración entre equipos de datos.

📌 **Cuándo usar un Lakehouse**

- Si se necesitan **tanto análisis estructurados como semiestructurados** en un mismo entorno.
- Cuando los **científicos de datos y analistas** deben trabajar sobre el mismo conjunto de datos.
- Para **procesamiento en batch y en tiempo real** dentro de Fabric​.

### 🔹 **Data Warehouses en Microsoft Fabric**

Un **Data Warehouse en Fabric** es una solución de almacenamiento estructurado, optimizada para consultas SQL y análisis de datos transaccionales.

✅ Usa **T-SQL nativo**, facilitando la migración desde bases de datos SQL tradicionales.  
✅ Soporta consultas de alto rendimiento y escalabilidad automática.  
✅ Permite la integración con **Power BI y otros servicios de Fabric**.

📌 **Cuándo usar un Data Warehouse**

- Si los datos son **estructurados** y requieren consultas SQL optimizadas.
- Cuando se necesita **compatibilidad con herramientas de análisis basadas en SQL**.
- Si los datos deben **mantenerse en un formato relacional con transacciones ACID**.

🔹 **Ejemplo práctico**: Un **Lakehouse** puede almacenar grandes volúmenes de datos en bruto de sensores IoT, mientras que un **Data Warehouse** almacena versiones agregadas para análisis financieros​.

Otro criterio de selección, está relacionado con los conocimientos que tengan los equipos para el desarrollo y mantenimiento de la solución. Teniendo en cuenta que el almacenamiento se realiza en Onelake y en formato Delta, es relevante el hecho de que los equipos deban de conocer o familiarizarse con Notebooks y PySpark, o por el contrario conocimientos de T-SQL. 

---

## **3. Caso práctico: Diseño de una solución de datos escalable**

### 🔹 **Escenario realista: Plataforma de Análisis de Ventas**

Se diseñará una solución que permita a una empresa de retail analizar sus ventas y optimizar la distribución de productos en sus tiendas.

#### **Requerimientos**

1️⃣ **Ingesta de datos de ventas en tiempo real** desde múltiples sistemas POS.  
2️⃣ **Procesamiento de datos con Dataflows Gen2** para limpieza y transformación.  
3️⃣ **Carga en OneLake** utilizando Pipelines de Data Factory.  
4️⃣ **Uso de un Lakehouse** para almacenar datos históricos en bruto.  
5️⃣ **Creación de un Data Warehouse** para consultas SQL optimizadas.  
6️⃣ **Modelado en Power BI** para generación de informes interactivos.

#### **Arquitectura de la solución**

4. **Extracción de datos** desde bases de datos SQL y APIs de terceros.
5. **Transformación en Dataflows Gen2** para limpieza y agregaciones.
6. **Carga en OneLake y procesamiento con Spark en un Lakehouse**.
7. **Creación de un modelo analítico en un Data Warehouse** para consultas SQL.
8. **Publicación en Power BI** con dashboards en tiempo real.

🔹 **Beneficios de esta arquitectura:**  
✅ **Eficiencia y escalabilidad:** Fabric maneja grandes volúmenes de datos sin sobrecargar sistemas transaccionales.  
✅ **Análisis en tiempo real:** Las decisiones pueden tomarse con información actualizada al minuto.  
✅ **Reducción de costos:** No se requiere infraestructura dedicada, todo funciona en la nube con escalabilidad automática.

📌 **Resultado esperado:**  
Con esta solución, los equipos de ventas y finanzas pueden acceder a datos en tiempo real sobre el desempeño de productos en distintas ubicaciones, optimizando la cadena de suministro y aumentando la rentabilidad​.

---
## **4. Escenarios y Arquitecturas**

### 🔹 **El más sencillo**
Imaginemos que queremos actualizar nuestra arquitectura Power BI, porque tenemos más necesidades de carga de datos, o simplemente queremos comenzar a analizar datos no estructuras de un modo más ágil. En un escenario de este estilo, podríamos tener:
- Un espacio de trabajo con una capacidad F2 o F4, iniciada únicamente en los momentos en los que necesitamos realizar la carga y procesamiento de los datos
- Nuestros procesos de ingeniería de datos para limpieza y demás tareas que dejen los datos listos en nuestro warehouse
- Otro espacio de trabajo en el que tengamos los modelos semánticos de Power BI, en modo import, y sus correspondientes informes
De esta forma, podemos disponer de las capacidades de Fabric de un modo económico, al estar pagando únicamente por el tiempo en el que realizamos las cargas de datos. Al tener los modelos semánticos en Modo Import, no necesitamos que la capacidad de Fabric esté iniciada cuando los usuarios acceden a los informes. 

### 🔹 **Monolítico**
En un escenario de este tipo, disponemos únicamente de una capacidad que está asignada a un único espacio de trabajo de Fabric, para dar soporte, por ejemplo, a lo comentado en la sección anterior. 
![[Despliegue Monolitico.png]]

### 🔹 **Capacidad Compartida**
Disponemos de una única capacidad de Fabric que es compartida por diferentes espacios de trabajo, para dar soporte a las cargas que se ejecuten en dichos espacios de trabajo

![[Despliegue Compartido.png]]

### 🔹 **Escalado**
Para escenarios que requieren de recursos dedicados, o que sea necesario escalar los recursos, podemos disponer de diferentes capacidades asignadas a distintos espacios de trabajo de Fabric

![[Despliegue Escalado.png]]

---

## **5. Conclusión y Preguntas Clave**

✅ **Microsoft Fabric permite diseñar soluciones end-to-end combinando ETL, almacenamiento y análisis en una única plataforma.**  
✅ **Dataflows Gen2 y Pipelines facilitan la ingesta y transformación de datos en Fabric.**  
✅ **El uso combinado de Lakehouses y Data Warehouses proporciona una arquitectura flexible y escalable.**  
✅ **Un diseño bien estructurado en Fabric mejora la eficiencia, reduce costes y habilita análisis avanzados.**

### **Preguntas de reflexión para la sesión**

1. ¿Cuándo deberías utilizar Dataflows Gen2 en lugar de Pipelines en Data Factory?
2. ¿En qué casos es preferible usar un Lakehouse en vez de un Data Warehouse?
3. ¿Cómo asegurarías la escalabilidad de una solución de datos en Fabric para grandes volúmenes de datos?