# **¿Qué es Microsoft Fabric?** 

## **1. Introducción a Microsoft Fabric**

### 🔹 **¿Qué es Microsoft Fabric?**

Microsoft Fabric es una plataforma **unificada de datos y análisis** que permite a las organizaciones integrar, procesar y analizar datos en un entorno centralizado. Diseñada como una solución **SaaS (Software as a Service)**, Fabric simplifica la gestión de datos eliminando la necesidad de combinar múltiples servicios y herramientas.

![Fabric SaaS](<imagenes/Fabric SaaS.png>)

Microsoft Fabric ofrece un conjunto de servicios que incluyen:

- **Data Engineering:** Procesamiento de datos a gran escala con Spark.
- **Data Factory:** Orquestación de cargas de datos con Dataflows Gen2 y Pipelines.
- **Data Science:** Creación y despliegue de modelos de Machine Learning con integración en Azure AI.
- **Data Warehouse:** Un servicio de almacenamiento y análisis optimizado para SQL.
- **Real-Time Analytics:** Procesamiento de eventos en tiempo real.
- **Power BI:** Visualización y exploración de datos con modelos semánticos.

💡 **Diferencia clave:** Mientras que otras soluciones requieren ensamblar múltiples servicios de diferentes proveedores, Microsoft Fabric proporciona un **ecosistema completo y unificado** bajo una única interfaz.

### 🔹 **Principales ventajas de Microsoft Fabric**

✅ **Unificación de almacenamiento** con **OneLake**: Todos los datos en un solo lago de datos, sin necesidad de replicarlos en diferentes sistemas.  
✅ **Simplicidad operativa:** Eliminación de la complejidad de integración entre herramientas y plataformas.  
✅ **Capacidad de análisis en tiempo real:** Permite tomar decisiones informadas con datos en streaming.  
✅ **Inteligencia Artificial integrada:** Fabric cuenta con capacidades de **Copilot** para asistir a los usuarios en la exploración y análisis de datos.

---

## **2. Comparación entre Microsoft Fabric y Power BI: ¿Cuándo usar cada uno?**

Tanto **Microsoft Fabric como Power BI** forman parte del ecosistema de datos de Microsoft, pero tienen propósitos distintos.

| **Característica**         | **Microsoft Fabric**                                                                                       | **Power BI**                                                                    |
| -------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Propósito**              | Plataforma completa de datos que abarca ingesta, almacenamiento, transformación, modelado y visualización. | Herramienta de Business Intelligence (BI) centrada en modelado y visualización. |
| **Almacenamiento**         | Utiliza **OneLake**, un lago de datos unificado basado en Azure Data Lake Storage Gen2.                    | Depende de datasets importados o conexiones en vivo.                            |
| **Procesamiento**          | Soporta **ETL, Machine Learning, Streaming, Data Warehousing y más**.                                      | Se enfoca en **modelado de datos y visualización**.                             |
| **Usuarios clave**         | **Ingenieros de datos, científicos de datos, arquitectos de soluciones**.                                  | **Analistas de negocio, directivos, usuarios de negocio**.                      |
| **Integración con Fabric** | Nativo, todos los datos están en OneLake y pueden ser usados sin movimiento de datos.                      | Consume datos de Fabric pero depende de datasets creados externamente.          |

📌 **¿Cuándo usar cada uno?**  
✅ **Si se necesita una solución completa de datos**, desde ingesta hasta visualización → **Microsoft Fabric**.  
✅ **Si solo se requiere análisis y visualización de datos** sin procesamiento complejo → **Power BI**.  
✅ **Si ya se usa Power BI y se quiere integrar con una plataforma más robusta**, Fabric proporciona un backend potente para centralizar los datos y los procesos de ingeniería y ciencia de datos necesarios.

---

## **3. Integración de Microsoft Fabric con otras herramientas de Microsoft**

Microsoft Fabric está diseñado para trabajar de manera **nativa con el ecosistema de Microsoft**, incluyendo:
### 🔹 **OneLake y Azure Data Services**
- **OneLake** es el lago de datos unificado que elimina la fragmentación de datos en la organización.
- Se integra con **Azure Data Factory** y **Azure Synapse Analytics**, facilitando la migración desde estos servicios hacia Fabric.
### 🔹 **Power BI y Microsoft Fabric**
- Power BI **consume directamente los datos de Fabric** sin necesidad de duplicaciones.
- Los modelos semánticos en Power BI pueden basarse en **Data Warehouses y Lakehouses** dentro de Fabric.
### 🔹 **Inteligencia Artificial y Machine Learning**
- **Azure AI** permite entrenar y desplegar modelos de IA sobre los datos almacenados en Fabric.
- Soporte para **Spark y MLlib** dentro de los Notebooks de Fabric.
### 🔹 **Orquestación de Datos**
- **Dataflows Gen2 y Pipelines** permiten el diseño de ETL de manera eficiente.
- Fabric soporta conectores para **Snowflake, Google BigQuery y Databricks**, facilitando la integración con otras plataformas.

---

## **4. Licenciamiento y Unidades de Capacidad en Microsoft Fabric**

Microsoft Fabric se ofrece bajo un modelo de **Capacidad (Capacity-based licensing)**. Esto significa que los recursos están disponibles en función del nivel de capacidad contratado.

### 🔹 **Capacidades y SKUs disponibles**

Fabric utiliza **unidades de capacidad (CU)**, que definen la cantidad de recursos disponibles en una suscripción.

| **Capacidad**        | **Unidades de Capacidad (CU)** | **Casos de Uso**                                                   |
| -------------------- | ------------------------------ | ------------------------------------------------------------------ |
| **F2**               | 2 CU                           | Pruebas y pequeños proyectos.                                      |
| **F4**               | 4 CU                           | Modelado de datos y cargas de trabajo ligeras.                     |
| **F8**               | 8 CU                           | Proyectos medianos con ETL y análisis en Power BI.                 |
| **F16**              | 16 CU                          | Workloads más exigentes con integración de ML y big data.          |
| **F32 y superiores** | 32 CU o más                    | Implementaciones a gran escala con cargas de trabajo distribuidas. |

📌 **Facturación basada en Capacidad**

- La capacidad se crea a nivel de **tenant** en Entra ID (anteriormente Azure AD).
- Se puede compartir entre varios **workspaces** dentro del mismo tenant
- Podemos tener tantas capacidades como queramos, asignadas a diferentes espacios de trabajo
- Los precios varían según el **nivel de capacidad** y el consumo de recursos.

Existen algunas funcionalidades, como las de Copilot, que solo están disponibles a partir de la F64. A partir de esta SKU F64, no es necesario disponer de licenciamiento de Power BI para poder visualizar informes, solo los usuarios que necesiten publicar contenido, necesitarían licenciamiento de Power BI Pro

![[Costes Fabric.png]]
					*Precios a fecha 10 de Febrero de 2025*

Realmente el coste se establece por CU, que es la unidad mínima que se puede reservar, y pueden reservarse unidades impares y el coste se establece a día de hoy (Febrero 2025) en 150,33€ por CU, sin reserva y para todo el mes. Con este cálculo, podemos también saber cuando nos costaría cada CU por hora, tomando unas 720 horas mensuales, tendríamos un coste hora de CU de 0,21€/hora


### 🔹 **Fabric Trial: Evaluación Gratuita**

Microsoft ofrece una **versión de prueba gratuita** de Fabric con **64 CU durante 60 días**. Esta trial permite experimentar con todas las funcionalidades antes de adquirir una suscripción, y nos permite hacer las pruebas necesarias, para ver que capacidad es la que necesitamos realmente. 

💡 **¿Cómo elegir la capacidad correcta?**
- Si tu empresa solo usa Fabric para Power BI, una **capacidad baja (F2-F4)** puede ser suficiente.
- Si necesitas **procesamiento de grandes volúmenes de datos**, se recomienda **F16 en adelante**.
- Para análisis en tiempo real y machine learning, es mejor optar por **F32 o superior**.

### 🔹**Pero entonces, ¿Qué licenciamos?**

Realmente, es la intersección entre el espacio de trabajo y el usuario, es decir, un usuario sin licenciamiento de Power BI Pro, podría, por ejemplo, visualizar informes que estuviesen publicados en un espacio de trabajo que tiene asignada una capacidad F64 o superior, pero no podría acceder a informes que estuviesen desplegados en espacios de trabajo con capacidades inferiores o con licenciamiento Power BI Pro. 
Es importante mencionar también, que los costes mostrados, son de pago por uso, sin ningún tipo de compromiso, es decir, podemos parar e iniciar la capacidad de Fabric, y pagar únicamente por el tiempo en el que esté activa. El coste mostrado, es el que tendrían esas capacidades en caso de que estuviesen iniciadas continuamente. Si optamos por tener un descuento por compromiso de uno o tres años, entonces se nos cobrará el importe acordado al compromiso, independientemente de que esté la capacidad iniciada o pausada. 

El detalle de los costes podemos verlo en este enlace https://azure.microsoft.com/es-es/pricing/details/microsoft-fabric/ 

### 🔹 **Capacidades y Consumos**

#### ¿Qué es una Unidad de Capacidad (CU)?####

En Microsoft Fabric, una **Unidad de Capacidad (CU)** es la medida que define la cantidad de recursos de cómputo y almacenamiento asignados a una capacidad específica. Estas unidades determinan el rendimiento y la eficiencia de las cargas de trabajo que se ejecutan en la plataforma. Las capacidades se ofrecen en diferentes tamaños o SKU, que van desde F2 (2 CUs) hasta F2048 (2048 CUs), permitiendo a las organizaciones seleccionar la capacidad que mejor se adapte a sus necesidades operativas.

#### Gestión Dinámica de Recursos: Bursting y Smoothing####

Para optimizar el uso de los recursos y manejar eficientemente las fluctuaciones en la demanda, Microsoft Fabric implementa dos mecanismos clave: **Bursting** y **Smoothing**.

El **Bursting** permite que una capacidad consuma más CUs de las asignadas temporalmente para completar tareas que requieren un alto rendimiento en menos tiempo. Por ejemplo, si una capacidad F2 tiene 2 CUs asignadas, pero una carga de trabajo intensa necesita más recursos, el sistema puede proporcionar capacidad adicional momentáneamente para acelerar la ejecución de la tarea. Este enfoque es especialmente útil para manejar picos de demanda sin necesidad de escalar permanentemente la capacidad contratada.

El **Smoothing** se encarga de equilibrar el consumo de CUs a lo largo del tiempo, distribuyendo el uso de los recursos para evitar picos y optimizar la eficiencia. Después de un período de bursting, el sistema "suaviza" el consumo adicional distribuyéndolo en intervalos de tiempo específicos: para operaciones interactivas, el consumo se promedia en un mínimo de 5 minutos, mientras que para trabajos en segundo plano o programados, se extiende hasta 24 horas. Este mecanismo permite que las organizaciones planifiquen su capacidad en función del uso promedio en lugar del máximo, optimizando así los costos y recursos.

Es importante tener en cuenta que, aunque el bursting y smoothing ofrecen flexibilidad, existen límites definidos para evitar el uso excesivo de recursos. Si una capacidad excede continuamente su rendimiento asignado, se aplicarán políticas de regulación o "throttling", donde las nuevas tareas no se ejecutarán hasta que haya suficientes recursos disponibles. Además, las capacidades pueden pausarse y reanudarse según sea necesario, y se facturan por segundo, lo que permite un control más preciso de los costos operativos.

Fabric está diseñado para ofrecer un rendimiento óptimo, permitiendo que las operaciones utilicen más CU de las asignadas temporalmente. Para gestionar este comportamiento, se implementa un proceso de **suavizado** que promedia el uso de CU en intervalos de tiempo específicos: 
- **Operaciones Interactivas**: El consumo de CU se suaviza durante un mínimo de 5 minutos, permitiendo manejar picos temporales sin aplicar limitaciones inmediatas. 
- **Operaciones en Segundo Plano**: Para tareas de larga duración, el suavizado se extiende hasta 24 horas, facilitando la ejecución de trabajos programados sin preocuparse por picos de carga.

La limitación se aplica en fases, dependiendo del nivel de consumo de CU: 
1. **Alerta de Consumo Completo**: Cuando una capacidad consume el 100% de sus CU aprovisionadas, se envía una alerta al administrador, indicando que podría ser necesario ajustar la capacidad. 
2. **Primera Fase de Limitación**: Si el consumo excede las CU disponibles para los próximos 10 minutos, se introduce un retraso de 20 segundos en las nuevas operaciones interactivas. 
3. **Segunda Fase de Limitación**: Si la deuda de CU alcanza una hora, las solicitudes interactivas adicionales son rechazadas, pero las operaciones en segundo plano continúan ejecutándose. 
4. **Fase Crítica de Limitación**: Si la deuda de CU llega a 24 horas, todas las operaciones, incluidas las de segundo plano, son rechazadas hasta que la deuda se reduzca.

Para recuperar una capacidad que ha entrado en un estado de limitación severa, podemos tomar las siguientes acciones: 
- **Esperar**: Permitir que la capacidad se recupere naturalmente a medida que la deuda de CU se reduce con el tiempo. 
- **Ajustar la SKU**: Incrementar temporalmente el tamaño de la SKU de la capacidad para proporcionar más recursos y acelerar la recuperación. 
- **Reasignar Áreas de Trabajo**: Mover áreas de trabajo de menor prioridad o que consumen muchos recursos a otras capacidades para equilibrar la carga.

Para monitorizar los consumos y ver el detalle, disponemos de una aplicación, llamada **Microsoft Fabric Capacity Metrics** https://learn.microsoft.com/es-es/fabric/enterprise/metrics-app 

![[Fabric Capacity Metrics.png]]

---
## **5. Resumen de Capacidades**

A continuación, verás una tabla resumen de lo que proporciona cada una de las capacidades de Fabric en cuanto a recursos


| Capacidad | CU   | Memoria Máxima | Power BI v-cores | Spark vCores | Max Spark vCores con Burst Factor | Limite de Cola | Tareas Dataflow Gen2 en paralelo | Refresco del modelo en paralelo |     |     |
| --------- | ---- | -------------- | ---------------- | ------------ | --------------------------------- | -------------- | -------------------------------- | ------------------------------- | --- | --- |
| F2        | 2    | 3              | 0.25             | 4            | 20                                | 4              | 96                               | 1                               |     |     |
| F4        | 4    | 3              | 0.5              | 8            | 24                                | 4              | 96                               | 2                               |     |     |
| F8        | 8    | 3              | 1                | 16           | 48                                | 8              | 96                               | 5                               |     |     |
| F16       | 16   | 5              | 2                | 32           | 96                                | 16             | 96                               | 10                              |     |     |
| F32       | 32   | 10             | 4                | 64           | 192                               | 32             | 96                               | 20                              |     |     |
| F64       | 64   | 25             | 8                | 128          | 384                               | 64             | 384                              | 40                              |     |     |
| F128      | 128  | 50             | 16               | 256          | 768                               | 128            | 384                              | 80                              |     |     |
| F256      | 256  | 100            | 32               | 512          | 1536                              | 256            | 384                              | 160                             |     |     |
| F512      | 512  | 200            | 64               | 1024         | 3072                              | 512            | 1536                             | 320                             |     |     |
| F1024     | 1024 | 400            | 128              | 2048         | 6144                              | 1024           | 1536                             | 640                             |     |     |
| F2048     | 2048 | 400            |                  | 4096         | 12288                             | 2048           | 1536                             | 1280                            |     |     |
|           |      |                |                  |              |                                   |                |                                  |                                 |     |     |

El detalle completo puedes revisarlo en este enlace https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-what-is#capacities-and-skus

---


## **6. Creación del recurso Fabric**

Tal y como hemos comentado, para crear una capacidad de Fabric, es necesario crear un recurso de Fabric en una suscripción de Azure. A la hora de crear el recurso, debemos de especificar las propiedades que se muestran en la siguiente imagen:


![[Crear Recurso Fabric.png]]
En la actualidad, Fabric soporte el concepto de multiregión, por lo que no tenemos por qué crear nuestra capacidad en la misma región en la que esté nuestro tenant (que será donde estén los recursos de Power BI y nuestro Onelake) , pero eso puede tener implicaciones de rendimiento, por lo que no es aconsejable. Las capacidades pueden escalar de tamaño en cualquier momento, y podemos agregar más administradores en caso de que lo necesitemos. 

### 🔹 **Asignar la capacidad al espacio de trabajo**

Una vez que tenemos la capacidad creada, e iniciada, podemos asignar esa capacidad a nuestros espacios de trabajo, tanto en el momento de su creación, como una vez estén creados desde la configuración del espacio de trabajo. Para ello es necesario que el usuario que está configurando el espacio de trabajo, tenga permisos sobre esa capacidad para poder asignarla.

![[Asignar Capacidad.png]]

Del mismo modo, si tenemos permisos de administración, desde la administración del portal, podemos ver las capacidades que tenemos desplegadas en nuestro tenant, y los permisos que tenemos sobre ellas, así como los espacios de trabajo que están utilizando esas capacidades. 

### 🔹 **Pausar e iniciar la capacidad de Fabric**

Tal y como hemos comentado, sino hemos adquirido la capacidad de Fabric con un compromiso de utilización, solo pagaremos por ella cuando la instancia esté iniciada. Obviamente, cuando una capacidad de Fabric está pausada, no es posible acceder a los objetos de Fabric que esté sirviendo esa capacidad en los espacios de trabajo en los que esté asignada, ni siquiera a lo almacenado en Onelake. 

Pausar e iniciar la capacidad es una tarea que debemos de realizar en el portal de Azure, como se muestra en la imagen

![[Pausar capacidad.png]]

No tenemos una forma "directa" de automatizar el pausado e inicio de la capacidad, pero es posible realizarlo de múltiples maneras, con un script a través del API, utilizando Power Automate, o directamente con recursos de Automatización de Azure, dependiendo de con que solución nos encontremos más cómodos.  

---

## **7. Conclusión y Preguntas Clave**

### 🔹 **Resumen de conceptos clave**

✅ **Microsoft Fabric es una plataforma unificada para gestión de datos y analítica avanzada.**  
✅ **Ofrece capacidades de almacenamiento, procesamiento y visualización en un solo entorno.**  
✅ **Power BI y Microsoft Fabric están integrados, pero Fabric es una solución más completa.**  
✅ **El modelo de licenciamiento se basa en unidades de capacidad (CU) con diferentes SKUs disponibles.**

### 🔹 **Preguntas para reflexionar y discusión**

2. ¿Cómo Fabric puede ayudar a mi organización a reducir los silos de datos?
3. ¿Qué diferencias clave encuentro entre Fabric y Power BI en mi caso de uso?
4. ¿Cuál es la capacidad ideal para mi empresa en función del volumen de datos?

---

