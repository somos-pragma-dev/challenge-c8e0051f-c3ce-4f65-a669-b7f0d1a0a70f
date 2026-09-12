# Requisitos y Restricciones del Servicio de Notificaciones

## 1. Propósito del Documento

Este documento establece los requisitos funcionales y no funcionales, así como las restricciones técnicas y operacionales que rigen el diseño e implementación del servicio de notificaciones en Microsoft Azure. La definición clara de estos elementos constituye la base para todas las decisiones arquitectónicas subsecuentes y permite validar el cumplimiento de las expectativas del negocio.

## 2. Actores del Sistema

### 2.1 Actores Principales

El servicio de notificaciones interactúa con múltiples actores que definen los flujos de comunicación y los patrones de uso:

- **Aplicaciones Productoras**: Sistemas backend que generan eventos de notificación. Incluyen el servicio de pedidos, el módulo de facturación, el sistema de autenticación y el motor de recomendaciones. Cada aplicacion puede enviar hasta 10,000 notificaciones por minuto en picos de carga.

- **Usuarios Finales**: Consumidores de notificaciones a través de múltiples canales. El sistema debe soportar un mínimo de 500,000 usuarios activos mensuales con capacidad de expansión lineal hasta 5,000,000 sin modificaciones arquitectónicas.

- **Administradores**: Personal operativo que gestiona configuraciones, monitorea el estado del servicio y responden a incidentes. Acceso basado en roles con privilegios mínimos mediante Azure Active Directory.

- **Sistemas de Terceros**: Integraciones con proveedores de SMS, correo electrónico y push notifications. El sistema debe poder cambiar de proveedor sin impacto en las aplicaciones consumidoras.

### 2.2 Patrones de Comunicación

Los productores de eventos utilizan un patrón de publicación-suscripción implementado mediante Azure Service Bus. Las aplicaciones consumidoras se conectan a topics específicos por tipo de notificación: transacciones, marketing, alertas de seguridad y notificaciones del sistema. Cada topic soporta hasta 100 suscripciones concurrentes con reglas de filtrado basadas en atributos del mensaje.

## 3. Requisitos Funcionales

### 3.1 Envío de Notificaciones

El servicio debe soportar el envío de notificaciones a través de múltiples canales con las siguientes capacidades:

- **Correo Electrónico**: Envío mediante Azure Communication Services con capacidad de 50,000 correos por hora. Plantillas dinámicas con soporte para contenido HTML y texto plano. Incluye rastreo de aperturas y clics con retención de datos por 90 días.

- **SMS**: Integración con proveedores de SMS vía API REST. Tasa de éxito mínima del 99.5% para mensajes cortos (menos de 160 caracteres). Soporte para mensajes largos mediante concatenación automática con costo por segmento.

- **Push Notifications**: Envío a dispositivos iOS y Android mediante Azure Notification Hubs. Soporte para notificaciones enriquecidas con imágenes y acciones. Registro de dispositivos con tokens actualizables y manejo de notificaciones silenciosas.

- **Notificaciones In-App**: Almacenamiento en Azure Cosmos DB con sincronización en tiempo real mediante SignalR. Historial de notificaciones accesible por 30 días para usuarios activos.

### 3.2 Gestión de Preferencias

Los usuarios deben poder gestionar sus preferencias de notificación a través de una API REST dedicada. Las opciones configurables incluyen: canal preferido por tipo de notificación, frecuencia de resumen diario/semanal, silencio por horario específico y opt-out por categoría. Los cambios de preferencia se propagan en menos de 5 segundos a todos los componentes del sistema.

### 3.3 Programación de Notificaciones

Soporte para programación de notificaciones con las siguientes características: programación con hasta 30 días de anticipación, zonas horarias del recipientrespectadas, cancelaciones con hasta 1 hora antes del envío programadas y notificaciones recurrentes con patrones configurables (diaria, semanal, mensual).

## 4. Requisitos No Funcionales

### 4.1 Rendimiento

- **Latencia de Procesamiento**: El tiempo desde que un evento se publica hasta que la notificación se encola para envío no debe exceder 500 milisegundos en el percentil 99 (P99).

- **Throughput**: Capacidad de procesar 50,000 notificaciones por minuto con burst de hasta 100,000 durante 15 minutos sin degradación de servicio.

- **Tiempo de Respuesta API**: Las llamadas a la API de gestión deben completarse en menos de 200 milisegundos P99 para operaciones de lectura y 500 milisegundos P99 para operaciones de escritura.

### 4.2 Disponibilidad

- **SLA General**: Disponibilidad del 99.95% medida mensualmente, excluyendo ventanas de mantenimiento programadas con notificación previa de 72 horas.

- **Recuperación ante Desastres**: Objetivo de Tiempo de Recuperación (RTO) de 15 minutos y Objetivo de Punto de Recuperación (RPO) de 5 minutos para la región primaria.

- **Redundancia**: Despliegue en múltiples zonas de disponibilidad dentro de la región primaria. Failover automático a región secundaria con detección de fallos en menos de 60 segundos.

### 4.3 Seguridad

- **Cifrado**: Todos los datos en reposo cifrados con claves gestionadas por Azure Key Vault (CMK). Datos en tránsito mediante TLS 1.2 mínimo con soporte para TLS 1.3.

- **Control de Acceso**: Autenticación mediante Azure AD con tokens JWT. Autorizacion basada en roles con segregación clara entre operadores, administradores y sistemas.

- **Auditoría**: Todos los accesos y operaciones registradas en Azure Log Analytics con retención de 365 días. Trazabilidad completa de cada notificación desde su origen hasta su entrega final.

### 4.4 Escalabilidad

- **Escala Horizontal**: Los componentes de procesamiento se despliegan comoAzure Functions con auto-escalado basado en métricas personalizadas. Configuración de mínimo 3 instancias siempre activas y máximo 50 instancias durante picos.

- **Particionamiento**: Azure Service Bus configurado con 16 particiones por namespace para distribución uniforme de carga. Cosmo DB con rendimiento aprovisionado de 10,000 RU/s escalable a 100,000 RU/s sin tiempo de inactividad.

## 5. Restricciones Técnicas

### 5.1 Limitaciones de Plataforma

- Las Azure Functions del plan Consumption tienen un límite de ejecución de 10 minutos por invocación; las notificaciones que requieran procesamiento extenso deben implementarse con Durable Functions o dividirse en pasos menores.

- Azure Notification Hubs tiene un límite de 60 dispositivos por registro masivo; operaciones de registro deben procesarse en lotes.

- Los recursos de Azure tienen cuotas regionales que deben monitorearse; el equipo de operaciones debe solicitar incrementos de cuota con al menos 2 semanas de anticipación.

### 5.2 Restricciones de Costos

- El presupuesto operativo mensual no debe exceder $15,000 USD para la carga base de 500,000 usuarios activos. Cada incremento de 100,000 usuarios adicionales debe mantenerse dentro de un incremento de costo proporcional no mayor al 15%.

- El almacenamiento de datos de notificación (excluyendo logs) no debe exceder 500 GB mensuales para la base de usuarios especificada.

- Los costos de terceros (SMS, email transaccional) deben mantenerse por debajo de $0.02 por notificación entregada exitosamente.

### 5.3 Conformidad Regulatoria

- Todos los datos de usuarios almacenados en la Unión Europea deben permanecer en regiones de la UE mientras el RGPD sea aplicable. Las transferencias fuera de la UE requieren mecanismos de transferencia aprobados.

- Los registros de consentimiento de usuarios deben mantenerse durante toda la vida de la relación con el usuario más 3 años adicionales para cumplimiento legal.

- Las notificaciones de marketing requieren consentimiento explícito doble opt-in conforme a las mejores prácticas de la industria y requisitos legales locales.

## 6. SLAs de Operación

### 6.1 Métricas de Servicio

| Métrica | Objetivo | Medición |
|---------|----------|----------|
| Notificaciones entregadas exitosamente | > 99.9% | Por canal y total |
| Latencia promedio end-to-end | < 2 segundos | P50 |
| Latencia P99 end-to-end | < 5 segundos | P99 |
| Tiempo de recuperación ante fallos | < 15 minutos | MTTR |
| Disponibilidad mensual | 99.95% | Azure Monitor |

### 6.2 Procesos de Monitoreo

- **Alertas Automáticas**: Se generan alertas cuando la tasa de error excede 0.1%, la latencia P99 supera 5 segundos por más de 5 minutos, o cualquier componente alcanza el 80% de su capacidad máxima.

- **Dashboard Operativo**: Panel en Azure Dashboard con vista en tiempo real de métricas clave, incluyendo tasa de entrega por canal, cola de mensajes pendientes, uso de recursos y costos acumulados.

- **Revisión Semanal**: Reunión de equipo para analizar tendencias, identificar patrones anómalos y planificar mejoras incrementales.

## 7. Matriz de Trazabilidad

Cada requisito funcional se mapea a componentes específicos de la infraestructura para asegurar la cobertura completa durante las pruebas de validación. Esta matriz facilita la identificación de impacto cuando se requieren cambios y permite priorización basada en criticidad del requisito.