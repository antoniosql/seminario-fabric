# **Fabric Databases**

## **1. Introducción**

El aumento de la cantidad de datos disponibles y la creciente demanda de análisis en tiempo real han llevado a la integración de múltiples servicios en una única plataforma. Microsoft Fabric agrupa herramientas de ingeniería de datos, inteligencia en tiempo real, data warehousing, data science y business intelligence en un entorno SaaS unificado. En este contexto, la introducción de una **base de datos transaccional** en Fabric – denominada Fabric Databases – responde a las siguientes necesidades:

- **Gestión de cargas operativas (OLTP):** Permite almacenar y gestionar transacciones operativas en tiempo real, esenciales para aplicaciones empresariales que requieren integridad y coherencia en los datos.
- **Integración nativa con el ecosistema Fabric:** Al estar basado en la tecnología de Azure SQL Database, se integra perfectamente con otros componentes como OneLake, Data Factory, Data Warehouse y herramientas de análisis.
- **Simplificación de la arquitectura:** Con Fabric Databases se evita la dispersión de servicios de múltiples proveedores, centralizando la gestión de datos transaccionales en un solo entorno.

---

## **2. Características de Fabric Databases**

### 🔹**Arquitectura y Tecnología Subyacente**

Fabric Databases se basa en el mismo **SQL Database Engine** que Azure SQL Database. Esta base de datos transaccional está diseñada para ser:

- **Fácil de configurar y administrar:** Su implementación en el entorno Fabric permite a los desarrolladores centrarse en la creación de soluciones sin preocuparse por la infraestructura subyacente.
- **Integrada con OneLake:** Los datos operacionales se replican de forma continua en OneLake, lo que permite el análisis en tiempo real y la integración con otros servicios analíticos de Fabric.
- **Optimizada para OLTP:** Está diseñada para soportar un alto volumen de transacciones concurrentes, garantizando consistencia y baja latencia.
---
### 🔹**Transaccionalidad y Replicación**

Las Fabric Databases están especialmente optimizadas para operaciones transaccionales. Entre sus ventajas se destacan:

- **Soporte para transacciones ACID:** Garantiza la atomicidad, consistencia, aislamiento y durabilidad en cada operación.
- **Replicación en tiempo real:** Mediante la tecnología de mirroring, los datos se replican casi en tiempo real hacia OneLake, lo que posibilita escenarios de análisis sin duplicar la carga en la base de datos transaccional. Por eso disponemos de un endpoint analítico de SQL y un modelo semántico en modo Direct Lake. 
- **Integración con servicios de análisis:** Gracias a la replicación, los datos pueden ser consultados tanto mediante SQL como con herramientas de Apache Spark y Power BI, facilitando el cruce de información entre entornos operativos y analíticos.
---
### 🔹**Integración y Ecosistema**

Dentro de Microsoft Fabric, las Fabric Databases permiten:

- **Conectividad nativa con otras cargas de trabajo:** Como Data Engineering, Data Warehouse y Real-Time Intelligence.
- **Uso compartido de datos:** Los usuarios pueden compartir y acceder a la base de datos a través de la funcionalidad de Graph API, que facilita la gestión y el descubrimiento de datos en el entorno Fabric.
- **Soporte para operaciones avanzadas:** Se incorpora soporte para operaciones vectoriales, fundamentales para soluciones de IA generativa y la implementación del patrón RAG (Retrieval-Augmented Generation).

> 📌 **Nota:** La integración con OneLake garantiza que siempre se trabaje con una única copia de los datos, eliminando la duplicidad y facilitando la gobernanza.

---

## **3. Guía de Decisión: ¿Cuándo Utilizar Fabric Databases o Azure SQL Database?**

Elegir entre Fabric Databases y Azure SQL Database depende de varios factores que deben alinearse con las necesidades del negocio y la arquitectura del sistema. A continuación, se presenta una guía de decisión detallada:

### 🔹**Factores a Considerar**

- **Integración con Microsoft Fabric:**
    
    - **Fabric Databases:** Son ideales cuando se desea una integración total con el ecosistema Fabric. Se beneficia de la replicación automática hacia OneLake, facilitando escenarios de análisis híbrido.
    - **Azure SQL Database:** Puede ser la opción si la organización ya tiene inversiones previas en Azure y desea aprovechar funcionalidades avanzadas de PaaS sin necesidad de integrarse a un entorno unificado como Fabric.
- **Tipo de Carga de Trabajo:**
    
    - **Transaccional (OLTP):** Para operaciones de alta concurrencia, donde se requiere un control estricto de las transacciones, Fabric Databases ofrece un entorno optimizado.
    - **Analítico (OLAP):** Si la prioridad es el análisis y la generación de reportes en entornos de BI, es posible que se opté por un data warehouse o lakehouse, aprovechando la replicación de datos desde la base operativa.
- **Costo y Escalabilidad:**
    
    - **Fabric Databases:** Al integrarse en el modelo SaaS de Fabric, se obtiene una administración centralizada y escalabilidad automática. Esto puede resultar en un menor costo total de propiedad al evitar la administración de múltiples servicios.
    - **Azure SQL Database:** Puede ofrecer configuraciones personalizadas a nivel de recursos, pero requiere mayor administración y puede ser más costosa en escenarios híbridos donde se necesite replicar y analizar datos.
- **Funcionalidades Específicas:**
    
    - **Soporte para operaciones vectoriales:**
        - Fabric Databases está diseñado para soportar operaciones con vectores, lo que es fundamental para el desarrollo de soluciones de IA generativa y la implementación del patrón RAG.
    - **Acceso y gestión mediante Graph API:**
        - Esta característica, integrada en Fabric Databases, facilita la administración de la base de datos de forma programática y la integración con otros servicios de Microsoft Fabric.
---
### 🔹**Decisión Basada en Escenarios**

> **Escenario 1:**  
> Una organización que desea consolidar sus operaciones transaccionales y analíticas en un único entorno, aprovechando la replicación automática a OneLake y la integración nativa con Power BI, debería optar por Fabric Databases.
> 
> **Escenario 2:**  
> Una empresa con una infraestructura consolidada en Azure, que requiere funcionalidades específicas de Azure SQL Database y no necesita la integración total con el ecosistema Fabric, podría seguir utilizando Azure SQL Database para sus cargas transaccionales.

---
### 🔹**Resumen de la Guía de Decisión**

- **Utilizar Fabric Databases cuando:**
    
    - Se requiera integración completa con Microsoft Fabric.
    - Se busque replicación automática de datos a OneLake para análisis en tiempo real.
    - Se necesiten operaciones vectoriales para soluciones de IA generativa y patrón RAG.
    - Se desee una administración simplificada en un entorno SaaS.
- **Utilizar Azure SQL Database cuando:**
    
    - La organización ya cuenta con una infraestructura consolidada en Azure.
    - Se requieren funcionalidades avanzadas o personalizadas no ofrecidas en Fabric.
    - No se planea aprovechar la integración nativa con otros servicios de Fabric.

> 🔍 **Tip:** Realiza una evaluación detallada de las cargas de trabajo y los requisitos de integración antes de tomar una decisión, considerando tanto aspectos técnicos como estratégicos.

---

## **4. Seguridad en Fabric Databases**

La seguridad es uno de los pilares fundamentales en el diseño y operación de Fabric Databases. La protección de datos sensibles y la gobernanza de la información se logran a través de múltiples capas y herramientas integradas.

### 🔹**Autenticación y Autorización**

- **Microsoft Entra (Azure AD):**  
    Todas las operaciones de acceso a Fabric Databases se realizan mediante la autenticación de Microsoft Entra. Esto asegura que únicamente usuarios, grupos o aplicaciones autorizadas puedan interactuar con la base de datos.
    
- **Control de Acceso Basado en Roles (RBAC):**  
    Se definen roles específicos para los diferentes perfiles de usuario (administradores, desarrolladores, analistas), lo que permite un control granular sobre quién puede leer, escribir o modificar datos.
    
- **Políticas de Seguridad:**  
    Se implementan políticas de encriptación en reposo y en tránsito, garantizando que los datos estén protegidos contra accesos no autorizados.
    
---
### 🔹**Acceso a Través de Graph API**

El acceso programático a Fabric Databases se facilita mediante el uso de Graph API, lo que ofrece beneficios como:

- **Gestión Centralizada:**  
    Permite a los administradores gestionar permisos, auditar accesos y realizar configuraciones de seguridad de forma centralizada.
    
- **Integración con Herramientas Externas:**  
    Con Graph API, es posible integrar la gestión de la base de datos con otros sistemas empresariales o plataformas de monitoreo, automatizando procesos de seguridad y respuesta ante incidentes.
    
- **Consultas y Operaciones Automatizadas:**  
    Las operaciones de lectura, escritura y actualización pueden ser automatizadas, lo que agiliza procesos como la generación de reportes o la actualización de políticas de seguridad.
    
---
### 🔹**Medidas Adicionales de Seguridad**

- **Auditoría y Monitoreo de Accesos:**  
    Se implementan registros de auditoría y monitoreo continuo a través de dashboards de rendimiento que permiten detectar patrones sospechosos y actuar proactivamente.
    
- **Protección de Datos Sensibles:**  
    Funcionalidades como el enmascaramiento de datos dinámico, seguridad a nivel de filas (RLS) y objetos (OLS) aseguran que los usuarios solo puedan acceder a la información que les corresponde.
    

---

## **5. Monitorización de Fabric Databases**

La monitorización es clave para asegurar el rendimiento y la estabilidad de las operaciones transaccionales. Fabric Databases integra diversas herramientas y métricas que facilitan el seguimiento del estado del sistema.

### 🔹**Herramientas de Monitorización Integradas**

- **Performance Dashboard:**  
    Una herramienta nativa que muestra indicadores clave como el uso de CPU, la latencia de consultas y el volumen de transacciones. Esto permite identificar cuellos de botella y optimizar recursos.
    
- **Dynamic Management Views (DMVs):**  
    Las DMVs ofrecen una visión detallada de las operaciones de la base de datos, permitiendo a los administradores ejecutar consultas para detectar incidencias en el flujo de transacciones y cambios en el rendimiento.
    
- **Alertas y Notificaciones:**  
    Se pueden configurar alertas para recibir notificaciones automáticas en caso de que se superen ciertos umbrales, facilitando una respuesta rápida ante problemas críticos.
---
### 🔹**Integración con Power BI y Otras Herramientas**

- **Dashboards Personalizados:**  
    Utilizando Power BI, es posible crear dashboards que integren datos de monitorización, facilitando la visualización en tiempo real de la salud del sistema.
    
- **Reportes Programados:**  
    La generación de reportes periódicos ayuda a mantener un historial de rendimiento, lo que permite analizar tendencias y planificar mejoras a largo plazo.
---
## **6. Conclusión**

La incorporación de Fabric Databases en Microsoft Fabric representa un avance significativo en la forma en que las organizaciones gestionan sus operaciones transaccionales y analíticas. Al integrar capacidades de seguridad, monitorización, acceso programático mediante Graph API y soporte a operaciones vectoriales para soluciones de IA generativa, Fabric Databases no solo optimiza la eficiencia operativa, sino que también abre nuevas oportunidades para innovar en la inteligencia artificial y en la toma de decisiones basada en datos. La decisión entre utilizar Fabric Databases o Azure SQL Database dependerá de la infraestructura existente, la necesidad de integración y los objetivos estratégicos de cada organización.

### 🔹**Reflexiones Finales**

✅ **Fabric permite permite implementar el concepto de transalytics a través de un motor SQL incluido en el producto.**  
✅ **DIsponemos de integración directa con Onelake y por lo tanto con Direct Lake para la analítica de los datos disponibles en esas base de datos.**  
✅ **Se nos habilitan nuevas opciones para el desarrollo de soluciones y aplicaciones basadas en datos**