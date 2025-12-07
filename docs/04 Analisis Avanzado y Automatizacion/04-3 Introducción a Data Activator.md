# **04-03 Introducción a Data Activator**
## **1. Automatización de procesos basada en eventos dentro de Fabric**

### 🔹 **¿Qué es Data Activator?**

**Data Activator** en Microsoft Fabric es un servicio **no-code** que permite la automatización de procesos mediante la detección de eventos en tiempo real. Su objetivo es proporcionar una **respuesta rápida a patrones de datos cambiantes**, permitiendo la activación automática de acciones empresariales​

📌 **Principales capacidades de Data Activator:**  
✅ **Monitorización de eventos en tiempo real.**  
✅ **Definición de reglas y condiciones sin código.**  
✅ **Automatización de respuestas mediante integración con otras herramientas.**

🔹 **Ejemplo de uso:**  
Una empresa de manufactura puede usar **Data Activator** para monitorear sensores IoT en una línea de producción. Si la temperatura supera un umbral crítico, **se genera una alerta y se detiene automáticamente la máquina afectada**​

---

### 🔹 **Cómo funciona Data Activator en Fabric**

📌 **Proceso de automatización basado en eventos:**  
1️⃣ **Detección:** Captura datos desde **EventStream, Power BI o KQL Querysets**.  
2️⃣ **Definición de reglas:** Se establecen condiciones para activar eventos.  
3️⃣ **Acción:** Se desencadenan respuestas automáticas (notificaciones, alertas, flujos de trabajo en Power Automate)​

🔹 **Ejemplo:**  
Si un KPI financiero en Power BI cae por debajo de un umbral, **Data Activator puede enviar un correo a la dirección financiera para revisar el presupuesto**​

---

## **2. Integración con Power Automate para desencadenar acciones**

### 🔹 **Automatización con Power Automate**

Data Activator se puede integrar con **Power Automate** para ejecutar flujos de trabajo empresariales cuando se detectan ciertos eventos​

📌 **Ejemplo de integración:**  
1️⃣ **Data Activator detecta una anomalía en un conjunto de datos en Fabric.**  
2️⃣ **Se activa un flujo de trabajo en Power Automate.**  
3️⃣ **El flujo de trabajo envía una notificación a Teams o crea una tarea en Microsoft Planner.**

🔹 **Ejemplo de código para integración con Power Automate:**

`{   "trigger": "data_activator_event",   "action": {     "type": "send_notification",     "destination": "Microsoft Teams",     "message": "Se ha detectado una anomalía en el sistema financiero."   } }`

📌 **Beneficio:** Automatiza procesos críticos sin intervención manual​

---

## **3. Ejemplo práctico: Notificación automática ante anomalías en los datos**

📌 **Objetivo:** Configurar un sistema de detección automática de anomalías en **un flujo de datos en tiempo real** y generar notificaciones en **Microsoft Teams** cuando se detecten eventos fuera de lo normal

### **Pasos del ejercicio:**

1️⃣ **Configurar un EventStream** en Microsoft Fabric.  
2️⃣ **Definir una condición de anomalía en Data Activator:**

- Se establece una regla para detectar valores atípicos en una serie temporal de transacciones financieras.  
    3️⃣ **Integración con Power Automate:**
- Se crea un flujo que envía una alerta a Teams cuando Data Activator detecta una anomalía.

🔹 **Ejemplo de configuración de Data Activator:**

`SELECT * FROM transacciones_financieras WHERE monto > 10000 AND cliente_riesgo = 'alto'`

📌 **Beneficio:** Permite una **respuesta inmediata a fraudes o errores en transacciones** sin necesidad de intervención manual​

---

## **4. Conclusión y Preguntas Clave**

✅ **Data Activator permite la automatización de acciones basadas en eventos en tiempo real.**  
✅ **Su integración con Power Automate facilita la respuesta rápida a cambios en los datos.**  
✅ **Los negocios pueden reducir riesgos y mejorar la eficiencia operativa con reglas automatizadas.**

### **Preguntas para reflexión y discusión:**

1️⃣ ¿Cuáles son los beneficios de automatizar alertas en comparación con monitoreo manual?  
2️⃣ ¿Cómo se pueden optimizar reglas en Data Activator para reducir falsas alarmas?  
3️⃣ ¿Qué otros casos de uso podrían beneficiarse de Data Activator en su organización?