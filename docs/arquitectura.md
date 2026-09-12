# Arquitectura del Servicio de Notificaciones

## 1. Visión General de la Solución

El servicio de notificaciones se implementa como una arquitectura de microservicios basada en eventos que aprovecha los servicios gestionados de Azure para maximizar la confiabilidad y minimizar la carga operativa. La arquitectura sigue el patrón de mensajería asíncrona con publicación-suscripción, permitiendo el desacoplamiento entre productores de eventos y consumidores de notificaciones. Este diseño facilita la escalabilidad independiente de cada componente y permite la incorporación de nuevos canales de notificación sin modificar el código de las aplicaciones productoras.

La solución se despliega en una arquitectura de múltiples regiones con capacidad de failover automático. La región primaria reside en Europa Occidental, mientras que la región secundaria está configurada en Norte de Europa. Esta distribución geográfica proporciona resiliencia ante fallos regionales y optimiza la latencia para la mayoría de la base de usuarios.

## 2. Decisiones de Diseño Fundamentales

### 2.1 Selección del Modelo de Ejecución

La decisión de utilizar Azure Functions como motor de ejecución responde a múltiples factores técnicos y económicos. El modelo serverless elimina la necesidad de gestionar infraestructura y permite pagar únicamente por los recursos consumidos, lo cual resulta óptimo para un servicio con patrones de tráfico variables. Las funciones se ejecutan en un plan Premium que proporciona rendimiento precalentado y conexiones de red privadas, combinando la economía del serverless con las capacidades requeridas para cargas de trabajo empresariales.

Cada tipo de notificación se procesa mediante funciones específicas dedicadas, permitiendo optimización individual y aislamiento de fallos. Las funciones de procesamiento de correo electrónico tienen allocated memory de 512 MB, mientras que las de procesamiento de SMS requieren solo 256 MB. Esta granularidad en la configuración optimiza el costo por ejecución.

### 2.2 Estrategia de Mensajería

Azure Service Bus constituye el núcleo de la arquitectura de mensajería, proporcionando capacidades de pub/sub con soporte para suscripciones duraderas y reglas de filtrado complejas. El namespace se configura con un nivel Premium que garantiza recursos dedicados y latencia predecible. Las 16 particiones del namespace permiten el procesamiento paralelo de mensajes y proporcionan resiliencia ante fallos de nodo individual.

Cada canal de notificación tiene un topic dedicado: notifications-email, notifications-sms, notifications-push e notifications-inapp. Esta segregación permite configuraciones de retención específicas por canal, políticas de reintento diferenciadas y métricas de monitoreo independientes. Los mensajes que no pueden procesarse después de 3 intentos se mueven automáticamente a una cola de mensajes fallidos para análisis manual.

### 2.3 Selección de Base de Datos

Azure Cosmos DB se eligió como almacenamiento principal por su distribución global nativa y latencia de lectura inferior a 10 milisegundos. El modelo de consistencia de sesión proporciona un balance apropiado entre rendimiento y garantías de lectura-after-write para las preferencias de usuario. La base de datos se configura con rendimiento automático que escala entre 1,000 y 50,000 RU/s basado en la demanda real.

La estrategia de particionamiento utiliza el identificador de usuario como clave de partición, asegurando que todas las notificaciones de un usuario específico residan en la misma partición física. Este diseño optimiza las consultas de historial por usuario mientras mantiene la distribución uniforme de datos.

## 3. Componentes de la Arquitectura

### 3.1 Capa de Ingesta

El API Gateway de Azure API Management sirve como punto de entrada único para todas las aplicaciones productoras. Proporciona autenticación centralizada mediante Azure AD, limitación de tasa para prevenir abusos y transformación de protocolos. El gateway está configurado en modo de disponibilidad alta con instancias en múltiples zonas de disponibilidad.

Las solicitudes de API se validan contra esquemas JSON predefinidos antes de ser encoladas. Las notificaciones válidas se transforman al formato interno del servicio y se publican en el topic correspondiente de Service Bus. Las solicitudes inválidas retornan errores descriptivos que permiten a las aplicaciones consumidoras corregir sus peticiones.

### 3.2 Capa de Procesamiento

Las Azure Functions del nivel de procesamiento escuchan mensajes de los topics de Service Bus y ejecutan la lógica de negocio específica de cada canal. La función de procesamiento de email se integra con Azure Communication Services, la de SMS con el proveedor de telecomunicaciones configurado, y la de push con Azure Notification Hubs.

Cada función implementa el patrón de procesamiento idempotente utilizando el identificador de mensaje único de Service Bus. Esto garantiza que los reintentos automáticos no resulten en notificaciones duplicadas, un requisito crítico para la experiencia del usuario y la optimización de costos con proveedores terceros.

### 3.3 Capa de Almacenamiento

Cosmos DB almacena el estado de cada notificación enviada, incluyendo metadatos de entrega, intentos de reintento y preferencias de usuario. Las colecciones se configuran con indexación automática en los campos de consulta más frecuentes: userId, status, createdAt y channel.

Azure Blob Storage sirve como repositorio de plantillas de notificación y archivos adjuntos. Las plantillas se versionan utilizando el sistema de versiones nativo de Blob Storage, permitiendo rollbacks rápidos cuando se detectan problemas en plantillas actualizadas.

### 3.4 Capa de Seguridad

Azure Key Vault almacena todos los secretos de la aplicación: claves de API de proveedores terceros, cadenas de conexión de Service Bus y tokens de autenticación. El acceso a los secretos se controla mediante políticas de acceso con principio de mínimo privilegio, y toda recuperación de secreto se audita en Log Analytics.

Azure AD proporciona autenticación y autorización para todos los componentes. Las identidades gestionadas de los servicios de Azure se utilizan siempre que es posible, eliminando la necesidad de almacenar credenciales. Para las integraciones que requieren secretos explícitos, estos se recuperan en tiempo de ejecución desde Key Vault.

### 3.5 Capa de Monitoreo

Azure Monitor proporciona observabilidad completa del sistema. Application Insights captura telemetría de alto nivel de las Azure Functions, incluyendo tiempos de ejecución, dependencias externas y excepciones. Las métricas se consolidan en un workbook operativo que muestra el estado de salud del sistema en tiempo real.

Azure Log Analytics sirve como repositorio central de logs, permitiendo consultas complejas para diagnóstico de problemas y análisis de tendencias. Las alertas se configuran mediante Azure Monitor Alerts y se notifican al equipo de operaciones a través de canales configurados (email, SMS, webhook a sistema de tickets).

## 4. Trade-offs y Justificaciones

### 4.1 Consistencia vs. Disponibilidad

La arquitectura acepta eventual consistency para las preferencias de usuario, permitiendo que los cambios se propaguen en hasta 5 segundos. Esta decisión reduce significativamente la latencia de escritura y permite escalar horizontalmente sin cuello de botella en la capa de datos. El tradeoff es aceptable porque las preferencias de notificación no son críticas para la operación del servicio y los usuarios esperan cierta latencia en la aplicación de cambios.

### 4.2 Costo vs. Rendimiento

El uso de Azure Functions en plan Premium en lugar de un clúster de AKS dedicado representa un ahorro estimado del 40% en costos operativos para la carga esperada. El tradeoff es la pérdida de control granular sobre el entorno de ejecución y límites de tiempo por función. Mitigamos esto diseñando las funciones para completar en menos de 5 minutos y utilizando Durable Functions para procesos de larga duración.

### 4.3 Complejidad vs. Mantenibilidad

La decisión de utilizar múltiples servicios de Azure especializados (Service Bus, Cosmos DB, Notification Hubs, Communication Services) aumenta la complejidad operativa pero proporciona capacidades que requerirían desarrollo significativo si se implementaran internamente. El equipo de operaciones debe monitorear múltiples servicios, pero cada uno está gestionado por Microsoft, reduciendo la carga de mantenimiento de infraestructura.

### 4.4 Acoplamiento vs. Testing

Aunque las Azure Functions están coupled con los servicios de Azure específicos, el diseño utiliza abstracciones que facilitan el testing. Las dependencias externas se inyectan como parámetros, permitiendo sustituir implementaciones reales por mocks durante las pruebas unitarias. Las pruebas de integración utilizan entornos efímeros de Azure que se crean y destruyen automáticamente.

## 5. Patrones de Diseño Implementados

### 5.1 Circuit Breaker

Las integraciones con proveedores terceros implementan el patrón circuit breaker para prevenir fallos en cascada. Cuando la tasa de error de un proveedor excede el umbral configurado (5% en 30 segundos), el circuito se abre y las notificaciones se reintentan automáticamente una vez que el proveedor se recupera. Los cambios de estado del circuit breaker se registran para análisis posterior.

### 5.2 Retry con Exponente Backoff

Los reintentos de procesamiento utilizan un algoritmo de backoff exponencial con jitter: primer intento a los 5 segundos, segundo a los 25 segundos, tercer intento a los 125 segundos. El jitter previene thundering herd cuando múltiples instancias fallan simultáneamente. Después de 3 intentos fallidos, el mensaje se mueve a la cola de mensajes fallidos para intervención manual.

### 5.3 Event Sourcing

El estado de cada notificación se mantiene como una secuencia de eventos en Cosmos DB, permitiendo reconstruir el estado actual y analizar la historia de procesamiento. Este patrón facilita el debugging de incidentes y proporciona datos para análisis de tendencias y optimización de procesos.

## 6. Consideraciones de Seguridad

### 6.1 Red

Todos los recursos de procesamiento se despliegan en una red virtual dedicada con subredes aisladas para cada tipo de componente. Las Azure Functions utilizan Private Endpoint para acceder a Service Bus y Cosmos DB sin exponer estos servicios a internet. El tráfico entre componentes nunca sale de la red de Azure.

### 6.2 Cifrado

Cosmos DB utiliza cifrado en reposo con claves gestionadas por Microsoft por defecto. Para cumplimiento regulatorio, se habilita el cifrado con claves gestionadas por el cliente almacenadas en Key Vault, permitiendo rotación de claves controlada y auditoría de acceso.

### 6.3 Compliance

La arquitectura está diseñada para cumplir con los requisitos del RGPD. Los datos de usuarios europeos se almacenan exclusivamente en regiones de la UE. Los mecanismos de eliminación de datos están implementados para soportar el derecho al olvido. Los registros de consentimiento se mantienen con integridad criptográfica.