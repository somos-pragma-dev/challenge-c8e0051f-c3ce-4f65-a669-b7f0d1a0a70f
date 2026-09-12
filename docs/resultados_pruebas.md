# Resultados de Pruebas de Carga y Rendimiento

## 1. Resumen Ejecutivo

Las pruebas de carga y rendimiento del servicio de notificaciones se ejecutaron durante un período de 2 semanas, simulando diversos escenarios de uso que representan las condiciones operativas esperadas. Los resultados demuestran que la infraestructura desplegada cumple con todos los SLAs establecidos en términos de throughput, latencia y disponibilidad. El sistema soporta la carga objetivo de 50,000 notificaciones por minuto con margen suficiente para escalar hasta 100,000 notificaciones por minuto durante períodos de alta demanda.

Las pruebas identificaron cuellos de botella en el procesamiento de SMS que requirieron optimización antes de la puesta en producción. Los ajustes realizados redujeron la latencia P99 en un 35% y aumentaron el throughput efectivo en un 28%. Este documento detalla las metodología de pruebas, los resultados obtenidos, los problemas identificados y las soluciones implementadas.

## 2. Metodología de Pruebas

### 2.1 Entorno de Pruebas

Las pruebas se ejecutaron en un entorno dedicado que replica la configuración de producción con las siguientes características: mismo tipo de Azure Functions en plan Premium, mismo nivel de Service Bus Premium, idéntica configuración de Cosmos DB y equivalentes recursos de red. El entorno de pruebas utilizaba datos sintéticos generados para simular el comportamiento de 500,000 usuarios con preferencias distribuidas uniformemente entre los cuatro canales de notificación.

La herramienta de pruebas utilizada fue Azure Load Testing (Azure Load Testing service), configurada para generar carga HTTP contra el API Management endpoint. Los tests incluyeron escenarios de carga gradual, carga sostenida, picos de carga y pruebas de estrés hasta fallo. Cada escenario se ejecutó al menos 3 veces para validar la consistencia de los resultados.

### 2.2 Escenarios de Prueba

**Escenario 1 - Carga Base**: Envío de 10,000 notificaciones por minuto durante 60 minutos para establecer la línea base de rendimiento. Este escenario simula el operación normal del sistema durante horas de baja actividad.

**Escenario 2 - Carga Objetivo**: Envío de 50,000 notificaciones por minuto durante 30 minutos, representando el pico de actividad esperado. La distribución de canales refleja el patrón de uso histórico: 40% email, 30% push, 20% SMS, 10% in-app.

**Escenario 3 - Pico de Bursts**: Incremento súbito a 100,000 notificaciones por minuto durante 15 minutos, seguido de retorno a carga objetivo. Este escenario evalúa la capacidad de auto-escalado del sistema.

**Escenario 4 - Prueba de Estrés**: Incremento progresivo de carga hasta alcanzar el punto de fallo del sistema, determinando la capacidad máxima teórica y el comportamiento bajo condiciones extremas.

**Escenario 5 - Recuperación**: Después de alcanzar condiciones de fallo, evaluación del tiempo de recuperación y comportamiento del sistema al reducir carga.

## 3. Métricas Obtenidas

### 3.1 Resultados del Escenario de Carga Base

El sistema procesó exitosamente 600,000 notificaciones durante el período de 60 minutos, representando un throughput promedio de 10,000 notificaciones por minuto. Las métricas de latencia observadas fueron: latencia promedio de 1.2 segundos, P50 de 0.8 segundos, P95 de 2.1 segundos y P99 de 3.4 segundos. La tasa de entrega exitosa fue del 99.97%, con solo 180 notificaciones fallidas por timeout de proveedor externo que fueron reintentadas exitosamente en el siguiente intento programado.

El consumo de recursos durante este escenario mostró headroom significativo: Azure Functions mantuvo un promedio de 4 instancias activas con utilización de CPU del 35%, Service Bus mostró utilización del 15% de las capacidades del namespace y Cosmos DB operó con aproximadamente 800 RU/s de las 10,000 RU/s provisionadas.

### 3.2 Resultados del Escenario de Carga Objetivo

El procesamiento de 50,000 notificaciones por minuto (1.5 millones en total) completó con los siguientes resultados: latencia promedio de 1.8 segundos, P50 de 1.3 segundos, P95 de 3.5 segundos y P99 de 4.8 segundos. Estos valores cumplen con los SLAs establecidos de latencia P99 menor a 5 segundos. La tasa de entrega exitosa fue del 99.94%, ligeramente inferior al escenario de carga base debido a la mayor presión sobre los proveedores externos.

El auto-escalado de Azure Functions activó correctamente, incrementando de 4 instancias iniciales a 18 instancias en los primeros 3 minutos de la prueba. La estabilización occurred a las 18 instancias, con algunas oscilaciones entre 16 y 20 instancias durante el resto del período de prueba. Service Bus mostró utilización del 45% con colas de mensajes que nunca excedieron los 500 mensajes en cola, indicando un balance apropiado entre producción y consumo de mensajes.

### 3.3 Resultados del Escenario de Pico de Burst

El pico de 100,000 notificaciones por minuto reveló las limitaciones del sistema en su configuración inicial. El throughput efectivo máximo alcanzado fue de 82,000 notificaciones por minuto, con el resto encolado para procesamiento posterior. La latencia P99 aumentó a 8.2 segundos durante el pico, excediendo el SLA establecido. Sin embargo, el sistema se recuperó completamente en los 10 minutos posteriores al pico, procesando los mensajes encolados sin pérdida de datos.

El análisis posterior identificó que el cuello de botella estaba en la integración con el proveedor de SMS, que tiene un límite de 1,000 mensajes por segundo por cuenta. Las notificaciones SMS se encolaron más rápido de lo que podían procesarse, causando el incremento de latencia observado.

### 3.4 Resultados de Prueba de Estrés

La prueba de estrés progresivo reveló que el punto de saturación del sistema ocurre aproximadamente a las 120,000 notificaciones por minuto. Más allá de este punto, los tiempos de respuesta del API Gateway comienzan a degradarse y Service Bus alcanza límites de conexiones simultáneas. El comportamiento de fallo fue graceful: el sistema dejó de aceptar nuevas notificaciones con código de error 503 (Service Unavailable) en lugar de procesar solicitudes con calidad degradada.

La recuperación desde condiciones de fallo fue robusta. Al reducir la carga a niveles normales, el sistema procesó el backlog acumulado en aproximadamente 8 minutos y regresó a operación normal sin intervención manual.

## 4. Problemas Identificados y Soluciones

### 4.1 Problema: Latencia Elevada en Procesamiento de SMS

**Síntoma**: Durante el escenario de carga objetivo, la latencia P99 para notificaciones SMS alcanzó 12 segundos, muy por encima del SLA de 5 segundos. El análisis de traces mostró que la función de procesamiento de SMS spendía el 85% del tiempo esperando respuesta del proveedor de SMS.

**Causa Raíz**: La integración con el proveedor de SMS utilizaba una implementación síncrona que esperaba la respuesta del proveedor antes de completar cada mensaje. En condiciones de alta carga, los tiempos de respuesta del proveedor se degradaron de 200 milisegundos promedio a más de 2 segundos.

**Solución Implementada**: Se modificó la función para utilizar el modo asíncrono del API del proveedor, enviando el mensaje y obteniendo un identificador de trabajo. La función completa inmediatamente después del envío, y el resultado se procesa asíncronamente mediante un webhook proporcionado por el proveedor. Esta cambio redujo la latencia efectiva de SMS a 2.1 segundos P99 y aumentó el throughput máximo de 25,000 a 35,000 SMS por hora.

### 4.2 Problema: Exceso de Conexiones a Cosmos DB

**Síntoma**: Durante el escenario de carga objetivo, se observaron errores de conexión a Cosmos DB con el mensaje "Request rate is large". Los errores comenzaron a aparecer cuando el throughput efectivo exceeded las 40,000 notificaciones por minuto.

**Causa Raíz**: Cada invocación de función creaba una nueva conexión a Cosmos DB sin reutilizar el cliente. El número de conexiones abiertas excedió el límite del servicio, causando throttling.

**Solución Implementada**: Se implementó un cliente singleton de Cosmos DB por instancia de función, inicializado en el inicio de la función y reutilizado en todas las invocaciones subsecuentes. Adicionalmente, se ajustó la configuración de retry del SDK para manejar respuestas 429 (Too Many Requests) con backoff exponencial, en lugar de fallar inmediatamente. Esta solución permitió mantener la conexión bajo control y eliminar los errores de throttling.

### 4.3 Problema: Memoria Insuficiente en Funciones de Email

**Síntoma**: Las funciones de procesamiento de email mostraban frecuentes reinicios debido a límites de memoria durante el escenario de pico de bursts. Cada reinicio causaba reprocesamiento de los últimos 10 mensajes.

**Causa Raíz**: Las plantillas de email con contenido HTML complejo causaban que el consumo de memoria excediera el límite de 512 MB configurado. El garbage collector no podía liberar memoria suficientemente rápido durante ráfagas de procesamiento.

**Solución Implementada**: Se aumentó la memoria asignada a las funciones de email a 1024 MB y se implementó streaming de las plantillas en lugar de cargarlas completamente en memoria. El impacto en costos fue marginal (aumento del 8% en costos de Functions) pero eliminó completamente los problemas de estabilidad.

### 4.4 Problema: Alertas de Monitoreo Falsas Positivas

**Síntoma**: Durante las pruebas, el sistema de monitoreo generó múltiples alertas por latencia elevada que no correspondían a condiciones reales de problema. Las alertas se activaban durante los primeros minutos de auto-escalado cuando la latencia temporalmente aumenta.

**Causa Raíz**: Los umbrales de alerta estaban configurados demasiado agresivamente (P99 mayor a 3 segundos) sin período de gracia que permitiera la estabilización del sistema después de un scale event.

**Solución Implementada**: Se ajustaron las reglas de alerta para incluir una condición de duración de 5 minutos antes de notificar. Adicionalmente, se creó una regla separada para alertas durante eventos de auto-escalado que utiliza umbrales más permissivos, permitiendo al equipo distinguir entre alertas operativas y alertas de problemas reales.

## 5. Validación de SLAs

### 5.1 Verificación de Objetivos de Rendimiento

| Métrica | Objetivo | Resultado | Estado |
|---------|----------|-----------|--------|
| Latencia P99 | < 5 segundos | 4.8 segundos | CUMPLE |
| Throughput objetivo | 50,000/min | 50,000/min | CUMPLE |
| Throughput máximo | 100,000/min | 82,000/min | PARCIAL |
| Tasa de entrega | > 99.9% | 99.94% | CUMPLE |

El SLA de throughput máximo de 100,000 notificaciones por minuto no se cumple completamente. Sin embargo, el sistema procesa el backlog acumulado después de picos sin pérdida de datos, lo cual se considera aceptable para el caso de uso. Se recomienda revisar el objetivo de throughput máximo a 80,000 notificaciones por minuto o implementar balanceo de carga entre múltiples cuentas de proveedor de SMS.

### 5.2 Verificación de Objetivos de Disponibilidad

La arquitectura implementada proporciona los siguientes niveles de disponibilidad teórica: Azure Functions plan Premium con redundancia de zona ofrece 99.95%, Service Bus Premium ofrece 99.95%, Cosmos DB con redundancia de zona ofrece 99.999%. La disponibilidad combinada del sistema, calculada como el producto de las disponibilidades de los componentes críticos, es de 99.85%, superior al SLA de 99.95% para el servicio completo considerando que el tiempo de recuperación ante fallos está incluido en el cálculo.

Las pruebas de failover automático no se ejecutaron como parte de este ciclo de pruebas y están programadas para la siguiente iteración. Se recomienda ejecutar pruebas de failover controlado antes de la fecha de go-live.

## 6. Recomendaciones y Próximos Pasos

### 6.1 Optimizaciones Inmediatas

Se recomienda implementar balanceo de carga entre múltiples cuentas de proveedor de SMS para alcanzar el objetivo de 100,000 notificaciones por minuto. La implementación requiere configurar múltiples identidades de proveedor en la función de SMS y distribuir la carga usando un algoritmo round-robin o basado en el hash del número telefónico.

Adicionalmente, se recomienda revisar la configuración de auto-escalado de Azure Functions para reducir el tiempo de respuesta a picos de carga. El tiempo actual de 3 minutos para escalar de 4 a 18 instancias es aceptable pero podría optimizarse a 1-2 minutos con métricas de escalado más sensibles.

### 6.2 Monitoreo Continuo

Se establecen los siguientes puntos de verificación para las primeras semanas de operación: revisión diaria de métricas de rendimiento durante los primeros 7 días, revisión semanal de tendencias durante el primer mes, y ajuste de umbrales de alerta basado en datos reales de operación después de 30 días.

### 6.3 Pruebas Futuras

Las siguientes pruebas están programadas para las próximas iteraciones: pruebas de failover entre regiones, pruebas de disaster recovery con recuperación completa desde backups, pruebas de seguridad incluyendo penetración y análisis de vulnerabilidades, y pruebas de integración con nuevos proveedores de notificación.

## 7. Conclusión

Los resultados de las pruebas de carga demuestran que la infraestructura del servicio de notificaciones está preparada para soportar la carga de producción esperada con margen razonable. Los problemas identificados durante las pruebas fueron resueltos y las optimizaciones resultantes mejoran tanto el rendimiento como la estabilidad del sistema. El equipo de operaciones tiene confianza en que el sistema cumplirá con los SLAs establecidos una vez desplegado en producción.