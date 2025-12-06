## **1. Introducción a OneLake: El Data Lake Unificado de Microsoft Fabric**

### 🔹 **¿Qué es OneLake?**

OneLake es el **lago de datos unificado** de Microsoft Fabric, diseñado para centralizar la gestión de datos en toda la organización. Funciona como un **repositorio único**, eliminando los **silos de datos** y simplificando la administración y el acceso a los datos.

![[Onelake.png]]

**Características clave de OneLake:**  
✅ **Almacenamiento centralizado:** Todos los datos en un solo lugar, eliminando la duplicación de información.  
✅ **Compatibilidad con múltiples motores:** Integración con **Spark, SQL, Power BI y Data Factory**.  
✅ **Formato abierto Delta Lake:** Almacenamiento basado en **Delta Lake**, lo que permite transacciones ACID y optimización del rendimiento.  
✅ **Capacidad de uso compartido:** Permite que múltiples equipos accedan a los mismos datos sin necesidad de copiarlos.  
✅ **Gestión sencilla con Shortcuts:** Los datos pueden estar distribuidos en múltiples ubicaciones, pero OneLake los expone como si fueran locales.

---

## **2. Arquitectura de OneLake: Diferencias con los Data Lakes Tradicionales**

OneLake introduce una arquitectura innovadora que mejora las limitaciones de los **Data Lakes tradicionales**.

### 🔹 **Comparación entre OneLake y los Data Lakes Tradicionales**

|**Característica**|**OneLake (Microsoft Fabric)**|**Data Lakes Tradicionales**|
|---|---|---|
|**Unificación de datos**|Almacena todos los datos en un solo repositorio con acceso global.|Cada equipo o departamento suele tener su propio almacenamiento.|
|**Formato de almacenamiento**|Basado en **Delta Lake** para transacciones ACID y optimización.|Generalmente almacena datos en formatos como Parquet, ORC o Avro, sin soporte nativo para transacciones.|
|**Gestión y Gobernanza**|Integrado con **Microsoft Purview** para gobierno y cumplimiento de datos.|Se requiere configuración manual de seguridad y acceso.|
|**Integración con Microsoft Fabric**|**Integrado de forma nativa con Data Factory, Data Science, Power BI y Real-Time Analytics.**|Normalmente requiere conectores o procesos ETL adicionales.|
|**Estrategia Multicloud**|Permite integrar datos desde otras nubes como AWS y Google Cloud usando **Shortcuts**.|Generalmente aislado dentro de un solo proveedor de nube.|
|**Gestión de costos**|Optimización automática de almacenamiento y procesamiento con **fabric capacity units (CU)**.|Costos variables según el uso de almacenamiento y cómputo sin una estrategia unificada.|

### 🔹 **Arquitectura de OneLake**

OneLake está basado en **tres conceptos clave**:

1️⃣ **Tenant único:** OneLake se implementa a nivel de **tenant** en Microsoft Entra ID (Azure AD), proporcionando un único punto de acceso a los datos.  
2️⃣ **Workspaces:** Los datos se organizan en **Workspaces**, que representan áreas de trabajo separadas para distintos equipos y proyectos.  
3️⃣ **Shortcuts:** Permiten acceder a datos en otras ubicaciones **sin copiarlos**, facilitando el análisis distribuido y reduciendo costos de almacenamiento.

📌 **Ventaja clave:** OneLake actúa como el **OneDrive para datos**, donde cada equipo puede crear su propio **Lakehouse o Data Warehouse** sin preocuparse por la infraestructura. 

---

## **3. Seguridad, Gobernanza y Control de Acceso en OneLake**

### 🔹 **Seguridad y Protección de Datos en OneLake**

OneLake hereda los controles de seguridad de **Microsoft Entra ID (Azure AD)** y Microsoft Purview, asegurando que los datos estén protegidos y cumplan con las regulaciones empresariales.

**⚡ Principales medidas de seguridad:**  
✅ **Autenticación y control de acceso basado en roles (RBAC):** Permite definir permisos a nivel de usuario, grupo o aplicación.  
✅ **Etiquetado de Sensibilidad:** Integración con **Microsoft Purview** para clasificar datos confidenciales y aplicar restricciones.  
✅ **Cifrado en reposo y en tránsito:** Uso de **Azure Key Vault** para gestionar claves de cifrado y proteger la información.  
✅ **Data Masking y Row-Level Security (RLS):** Controla qué usuarios pueden ver datos específicos dentro de un mismo conjunto de datos.

📌 **Caso de uso real:**  
Una empresa de retail puede almacenar **datos de clientes en OneLake** y usar **Row-Level Security** para que solo los empleados de cada país accedan a la información de sus respectivas regiones.

Algunos de estos mecanismos de seguridad, todavía están en preview, puedes ver los detalles aquí: https://learn.microsoft.com/en-us/fabric/onelake/security/fabric-onelake-security

Si no vamos a proporcionar acceso externo a través del API de Onelake a usuarios o aplicaciones, no tenemos necesidad de aplicar permisos directamente a los usuarios sobre los ficheros almacenados en Onelake. Podemos dar permisos a un usuario, por ejemplo, para que pueda acceder al SQL Endpoint que se genera para un lakehouse, sin necesidad de proporcionarle acceso a los ficheros subyacentes. 
### 🔹 **Gobernanza y Cumplimiento en OneLake**

OneLake ofrece capacidades avanzadas de **gestión y cumplimiento de datos**, ayudando a las organizaciones a cumplir con normativas como **GDPR, HIPAA y SOC 2**.

**Funciones clave de gobernanza en OneLake:**  
🔹 **Auditoría y Monitorización:** Microsoft Fabric registra automáticamente el acceso y las modificaciones a los datos en **Microsoft Purview**.  
🔹 **Data Lineage:** Permite rastrear el origen y transformación de los datos a lo largo del tiempo.  
🔹 **Gestión de Retención y Eliminación:** Se pueden definir políticas para retención y eliminación segura de datos.

📌 **Ventaja clave:** OneLake garantiza que todos los datos dentro de **Microsoft Fabric** se gestionen de manera centralizada, evitando inconsistencias y riesgos de cumplimiento.

Todo esto podemos verlo desde el hub de Onlake que tenemos en el portal, donde no solo podemos ver los recursos disponibles, sino también monitorizar y ver las configuraciones de Gobierno y linaje. 

![[Onelake Catalogo.png]]

---

## **4.Costes en OneLake**

Microsoft Fabric usa un modelo de **licenciamiento basado en capacidades (Capacity-based licensing)**, lo que impacta el rendimiento, pero los costes de Onelake no están incluidos en esa capacidad.

### 🔹 **¿Cómo funcionan las Unidades de Capacidad (CU) en OneLake?**

OneLake consume **Capacidad de Fabric (CU)** según el nivel de procesamiento y almacenamiento requerido para las operaciones de procesamiento de datos.

|**Capacidad**|**Unidades de Capacidad (CU)**|**Casos de Uso en OneLake**|
|---|---|---|
|**F2**|2 CU|Pruebas y pequeños volúmenes de datos.|
|**F4**|4 CU|Ingesta de datos en ETL ligero.|
|**F8**|8 CU|Workloads intermedios con análisis SQL.|
|**F16**|16 CU|Procesamiento avanzado con Spark y ML.|
|**F32+**|32 CU o más|Análisis en tiempo real y grandes volúmenes de datos.|
Como hemos comentado, el coste real del almacenamiento no está incluido en las CU y está reflejado en este imagen

![[Onelake Costs.png]]
Debemos de tener en cuenta que:
- Si eliminamos un espacio de trabajo, se nos sigue cobrando durante el periodo de retención
- La caché está relacionada con el análisis en tiempo real (KQL y Data activator)

📌 **Optimización de Costos en OneLake**  
✅ **Uso de Shortcuts:** Accede a datos en **AWS, Google Cloud o Azure Data Lake** sin duplicarlos. Pagamos por la transferencia de datos 
✅ **Autoscaling de Capacidad:** OneLake ajusta automáticamente el consumo de recursos según la carga de trabajo.  
✅ **Optimización de Consultas:** Uso de formatos optimizados como **Delta Lake** para mejorar el rendimiento y reducir costos de almacenamiento.

El detalle de las operaciones y los costes podéis consultarlo en este enlace https://learn.microsoft.com/es-es/fabric/onelake/onelake-consumption 

---
## **5. Onelake Explorer**

Disponemos de una aplicación, denominada **Onelake Explorer** que nos permite acceder al contenido de nuestro Onelake, y navegar por él, como si estuviésemos utilizando Onedrive. 

![[Onelake Explorer.png]]
Al crear, actualizar o eliminar un archivo a través del Explorador de archivos de Windows, se sincronizan automáticamente los cambios en el servicio OneLake, y podemos tener replicados en local. Además los shortcuts que tengamos creados, aparecen como si estuviesen los datos realmente almacenados en nuestro OneLake, proporcionando una capa de abstracción completa a como y donde los datos están realmente almacenados. 

---
## **6. Conectando a Onelake**

Podemos acceder de forma abierta a los contenidos de Onelake a través de las API y los SDK de Azure Data Lake Storage (ADLS) gen2. Tan solo debemos de conocer la URI del recurso al que queremos acceder, que tendrá un formato de este estilo:

`https://onelake.dfs.fabric.microsoft.com/<workspace>/<item>.<itemtype>/<path>/<fileName>`

Podemos utilizar también el GUID de los elementos de esta forma:

`https://onelake.dfs.fabric.microsoft.com/<workspaceGUID>/<itemGUID>/<path>/<fileName>`

Para más información sobre estos accesos puedes revisar la documentación en este punto: https://learn.microsoft.com/es-es/fabric/onelake/onelake-access-api 

---

## **7. Conclusión y Preguntas Clave**

### 🔹 **Resumen de conceptos clave**

✅ **OneLake es el Data Lake unificado de Microsoft Fabric, diseñado para eliminar los silos de datos.**  
✅ **Su arquitectura permite integración con múltiples motores y uso compartido de datos sin duplicaciones.**  
✅ **Ofrece medidas avanzadas de seguridad y cumplimiento con Microsoft Purview y Azure AD.**  
✅ **El consumo de recursos en OneLake se basa en Unidades de Capacidad (CU), permitiendo escalar según las necesidades del negocio.**

### 🔹 **Preguntas para reflexión y discusión**

1. ¿Cómo impactaría OneLake en la estrategia de almacenamiento de mi empresa?
2. ¿Cuáles son las ventajas de OneLake frente a los Data Lakes tradicionales en mi caso de uso?
3. ¿Cómo puedo optimizar costes en OneLake utilizando Shortcuts y estrategias de gobernanza?