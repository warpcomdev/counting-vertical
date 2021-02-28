# Suscripciones requeridas

Las subscripciones imprescindibles para el funcionamiento del vertical son las de CEP, que se encargan de actualizar los contadores de las entidades.

Observar que en el caso de usar el vertical en modo mancomunado habrá que crear este mismo juego de subscripciones en cada uno de los subservicios correspondientes a los elementos del mancomunado.
    
## Subscripción a CEP para accesos

* **Estado**: Activa
* **Descripción**: Envio de notificaciones a CEP para accesos
* **Fecha y hora de expiración**: en blanco
* **Segundos entre notificaciones**: en blanco
* **Protocolo**: HTTP
* **URL de notificación**:
    * Entorno Onpremise: http://iot-perseo-fe:9090/notices
    * Entorno SaaS: http://10.0.0.2:9090/notices
* **Formato de atributos**: legacy
* **Atributos a notificar**: zoneRef, status, capacity, numberOfIncoming, numberOfOutgoing, occupancy, percentageOfOccupation
* **Condición**: TimeInstant
* **Entidades**:
    * ID: `.*` (con checkbox de patrón de búsqueda marcado)
    * Type: Access

## Subscripción a CEP para zonas

* **Estado**: Activa
* **Descripción**: Envio de notificaciones a CEP para zonas
* **Fecha y hora de expiración**: en blanco
* **Segundos entre notificaciones**: en blanco
* **Protocolo**: HTTP
* **URL de notificación**:
    * Entorno Onpremise: http://iot-perseo-fe:9090/notices
    * Entorno SaaS: http://10.0.0.2:9090/notices
* **Formato de atributos**: legacy
* **Atributos a notificar**: source, sourcePath, sourceType, status, capacity, thresholdWarning, thresholdCritical, tefNotif, numberOfIncoming, numberOfOutgoing, occupancy, percentageOfOccupation
* **Condición**: TimeInstant
* **Entidades**:
    * ID: `.*` (con checkbox de patrón de búsqueda marcado)
    * Type: Zone

# Suscripciones opcionales

Las siguientes suscripciones sólo son obligatorias si se quiere almacenar el histórico de accesos. En general, no será necesario almacenar estas entidades, sino las entidades a la s que este vertical hace referencia (las indicadas por los atributos `source` / `sourceType` / `sourcePath`).

## Subscripción a Access

* **Estado**: Activa
* **Descripción**: Envio de notificaciones a POSTGRESQL Access
* **Fecha y hora de expiración**: en blanco
* **Segundos entre notificaciones**: en blanco
* **Protocolo**: HTTP
* **URL de notificación**: 
    * Entorno Onpremise: http://iot-cygnus:5057/notify
    * Entorno SaaS: http://10.0.0.2:5080/notify
* **Formato de atributos**: legacy
* **Atributos a notificar**: TimeInstant, zoneRef, source, sourceType, sourcePath, period, name, description, address, location, areaServed, category, width, length, capacity, numberOfIncoming, numberOfOutgoing, occupancy, percentageOfOccupation, dateCalculatedOccupancy
* **Condición**: dateCalculatedOccupancy
* **Entidades**: 
    * ID: `.*` (con checkbox de patrón de búsqueda marcado) 
    * Type: Access
    
## Subscripción a Zone

* **Estado**: Activa
* **Descripción**: Envio de notificaciones a POSTGRESQL Zone
* **Fecha y hora de expiración**: en blanco
* **Segundos entre notificaciones**: en blanco
* **Protocolo**: HTTP
* **URL de notificación**: 
    * Entorno Onpremise: http://iot-cygnus:5057/notify
    * Entorno SaaS: http://10.0.0.2:5080/notify
* **Formato de atributos**: legacy
* **Atributos a notificar**: TimeInstant, source, sourcePath, sourceType, name, description, address, location, areaServed, category, width, length, occupationRate, capacity, numberOfIncoming, numberOfOutgoing, occupancy, percentageOfOccupation, dateCalculatedOccupancy
* **Condición**: dateCalculatedOccupancy
* **Entidades**: 
    * ID: `.*` (con checkbox de patrón de búsqueda marcado) 
    * Type: Zone
