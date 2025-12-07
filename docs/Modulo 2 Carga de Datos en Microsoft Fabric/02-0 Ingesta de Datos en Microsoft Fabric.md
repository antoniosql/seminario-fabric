# **Ingesta de Datos en Microsoft Fabric**


En este módulo veremos las opciones que tenemos para cargar datos en Microsoft Fabric, como primer paso en cualquier proyecto de Analítica, puesto que necesitamos los datos disponibles para poder comenzar con los procesos de desarrollo. En este tema veremos:

✅ **Introducción a la carga de Datos en Fabric** 
✅**Dataflows de Generación 2**
✅**Orquestando cargas con Pipelines de Data Factory**
✅**Desarrollo con Apache Spark**

# **Introducción a la Carga de Datos en Microsoft Fabric**
Disponemos de diferentes mecanismos para disponibilizar los datos en Microsoft Fabric tales como:
- Cargar los datos manualmente
- Accesos directos en nuestros lakehouses
- Mirrror de Bases de Datos en datawarehouse
- Cargas de Datos con Dataflows de Generación 2
- Actividad de Copia de Datos en Pipelines
- Notebooks de Apache Spark

Pero antes de evaluar estas opciones es necesario conectarnos a los orígenes, utilizando las conexiones y los gateways

## **1.Del ETL al ELT**

Con el aumento paulatino en la cantidad de datos generados y que necesitamos utilizar para nuestros análisis, los patrones de carga de datos ha evolucionado del patrón ETL (Extracción, Transformación y Carga) al nuevo patrón ELT (Extracción, Carga y Transformación).  Ambos modelos tienen como objetivo procesar y estructurar la información, pero sus enfoques varían según la infraestructura y las necesidades de las empresas.

| Característica                             | ETL                                                                                | ELT                                                                                               |
| ------------------------------------------ | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| **Orden de Procesamiento**                 | Extracción → Transformación → Carga                                                | Extracción → Carga → Transformación                                                               |
| **Dónde se realizan las transformaciones** | En un motor de procesamiento intermedio                                            | Directamente en el Data Lake o Data Warehouse                                                     |
| **Escalabilidad**                          | Limitada por la capacidad del servidor ETL                                         | Altamente escalable, aprovecha el poder del Data Lake y del Data Warehouse                        |
| **Tiempo de procesamiento**                | Más lento debido a la transformación previa a la carga                             | Más rápido, ya que los datos sin procesar se almacenan primero y luego se transforman en paralelo |
| **Casos de uso recomendados**              | Integración de múltiples fuentes con reglas de negocio complejas antes de la carga | Análisis masivo de datos, Big Data, Machine Learning, análisis en tiempo real                     |
Tradicionalmente, las empresas utilizaban **ETL** debido a las limitaciones en almacenamiento y computación. Antes de la llegada de los Data Lakes, los datos debían ser transformados antes de cargarlos en un Data Warehouse, ya que este último requería una estructura optimizada para consultas. Con los ELT, lo que hacemos es realizar la ingesta de los datos en bruto, y aplicar posteriormente las transformaciones necesarias para cada caso de uso. 

Sin embargo, la explosión del **Big Data** y el abaratamiento del almacenamiento en la nube han impulsado **ELT**, donde los datos se almacenan primero en bruto y se transforman solo cuando es necesario, utilizando el poder de cómputo de soluciones modernas como **Microsoft Fabric**.

## **2.Conexiones de Datos**

El primer paso para configurar una ingesta de datos, es obviamente conectarnos el origen donde se encuentran los datos y para ello disponemos de una opción de configuración donde podremos ver las conexiones creadas, así como crear nuevas conexiones. 

![[Administrar Conexiones y puertas de enlace.png]]


Dentro de esta opción, podremos configurar tanto Conexiones a nuestros orígenes de datos, como las puertas de enlace que tengamos desplegadas para acceso a datos locales, o para acceso a datos de la nube que están en una red virtual, tal y como podemos apreciar en la imagen. 

![[Administrar Conexiones.png]]

Lo recomendable es gestionar las conexiones y las puertas de enlace, desde esta opción centralizada de configuración, para poder reutilizarlas, asignando permisos a aquellos usuarios que queramos que puedan utilizar dichas conexiones. Cuando seleccionamos la opción de crear una nueva conexión, veremos las tres opciones comentadas: local, nube o red virtual. Para las opciones de red virtual y local, es necesario referenciar a un gateway que ya tengamos instalado y configurado. Veremos como crearlos en el siguiente apartado. 
Por lo que respecta a las conexiones de Nube dependiendo del tipo de conexión la parametrización será diferente, pero básicamente necesitaremos los datos para crear una cadena de conexión. Tal y como se aprecia también en la imagen, ahora mismo los dataflows no soportan la utilización de estas conexiones de la nube, debiendo de crearlas desde el propio entorno de los dataflows. Se espera que en breve también soporte la reutilización de este tipo de conexiones. 

![[Nueva conexion.png]]

Una vez tengamos esa conexión creada, podremos utilizarla en nuestros pipelines, y en los modemos semánticos de Power BI, para el acceso a esos datos. 

Adicionalmente si seleccionamos la conexión, tendremos la posibilidad de configurar permisos y compartir la conexión con otros usuarios de nuestro tenant, tal y como muestra la imagen
![[Permisos Conexiones.png]]
## **3.Data Gateways (Puertas de Enlace)**

Microsoft Fabric es una solución en la nube, y es muy probable que dispongamos de datos que estén en local en nuestra infraestructura, o incluso en máquinas virtuales (IaaS) en una nube pública o un hosting. En este caso, es necesario configurar un Data Gateway que actúe de pasarela entre la nube de Microsoft y la ubicación en la que se encuentran los datos. 
Existen dos tipos diferentes de Data Gateways o puertas de enlace de datos locales, cada uno para un escenario diferente.

- **Puerta de enlace de datos local**: permite que varios usuarios se conecten a múltiples fuentes de datos locales. Con una instalación de puerta de enlace única, puede utilizar una puerta de enlace de datos local con todos los servicios compatibles. Esta puerta de enlace se adapta bien a escenarios complejos en los que varias personas acceden a múltiples fuentes de datos.
- **Puerta de enlace de datos local (modo personal)**: permite que un usuario se conecte a fuentes de datos y no se puede compartir con otros. Una puerta de enlace de datos local (modo personal) solo se puede usar con Power BI. Esta puerta de enlace es ideal para escenarios en los que usted es el único que crea informes y no necesita compartir ninguna fuente de datos con otros.

Además, hay una puerta de enlace de datos de red virtual (VNet) que permite que varios usuarios se conecten a múltiples fuentes de datos protegidas por redes virtuales. No se requiere instalación porque es un servicio administrado por Microsoft. Esta puerta de enlace se adapta bien a escenarios complejos en los que varias personas acceden a múltiples fuentes de datos.

Los usuarios de la organización pueden acceder a datos locales a los que ya tienen autorización de acceso desde servicios en la nube como Power BI, Power Platform y Microsoft Fabric. Pero antes de que esos usuarios puedan conectar el servicio en la nube a la fuente de datos local, es necesario instalar y configurar una puerta de enlace de datos local.

### Cómo funciona?

A continuación se muestra el diagrama de funcionamiento de estas puertas de enlace:

![[Arquitectura Gateways.png]]

1. El servicio en la nube crea una consulta y las credenciales cifradas para la fuente de datos local. La consulta y las credenciales se envían a la cola de la puerta de enlace para su procesamiento cuando la puerta de enlace sondea el servicio periódicamente. 
2. El servicio en la nube de puerta de enlace analiza la consulta y envía la solicitud a Azure Relay.
3. Azure Relay envía las solicitudes pendientes a la puerta de enlace cuando sondea periódicamente. Tanto la puerta de enlace como el servicio Power BI están implementados para aceptar únicamente tráfico TLS 1.2.
4. La puerta de enlace recibe la consulta, descifra las credenciales y se conecta a una o más fuentes de datos con esas credenciales.
5. La puerta de enlace envía la consulta a la fuente de datos para su ejecución.
6. Los resultados se envían desde la fuente de datos a la puerta de enlace y luego al servicio en la nube. Luego, el servicio utiliza los resultados.

La instalación de estas puertas de enlace, puede realizarse en cualquier equipo de la red local (o DMZ) que tenga acceso a los orígenes de datos a los que se quiere acceder. El acceso al instalador lo tenemos en el área de descargas del portal de Microsoft Fabric. Una vez finalizada la descarga, cuando lancemos la ejecución y aceptemos la licencia , nos solicitará iniciar sesión, para poder crear la puerta de enlace en MIcrosoft Fabric, solicitándonos un nombre, y una clave de recuperación:
![[Configuración Gateway.png]]

Al finalizar la configuración, ya nos aparecerá la puerta de enlace en el portal de Fabric, y podremos utilizarla para nuevas conexiones!