# Simulaciones

Este directorio contiene dos recursos:

* urbo2-counting-entities.csv: fichero que entidades del vertical (estático)
* urbo2-counting-simulation.json: fichero de simulación del vertical (dinámico)
Ambos usan como caso de ejemplo (pe. geo-localización de las entidades, etc.) el de la smartcity de Santander (aunque se encuentra desplegado en el servicio alcobendas).

## Fichero CSV

Este fichero ha de ser cargado utilizando el Portal de la Plataforma, como paso previo al lanzamiento de la simulación.

## Simulación

El simulador es un programa en node (version de referencia: 8.12). Para instalarlo basta simplemente con clonar el repositorio e instalar sus dependencias:

```
$ git clone https://github.com/telefonicaid/fiware-device-simulator.git
$ cd fiware-device-simulator
$ npm install
```

Una vez instalado, para arrancar la simulación (desde el directorio del simulador):

```
$ node bin/fiwareDeviceSimulatorCLI -c /path/to/urbo2-beaches-simulation.json -p 60000
```

El simulador muestra trazas de progreso de este estilo:

```
{"time":"2019-05-23T16:18:52.660Z","lvl":"INFO","msg":"progress-info { totalUpdateRequests: '4 updates',\n  throughput: '0.00 updates/sec.',\n  errorUpdateRequests: '0 updates',\n  errorUpdateRequestsX100: '0.00%',\n  delayedUpdateRequests: '0 updates',\n  delayedUpdateRequestsX100: '0.00%',\n  elapsedTime: '19 minutes, 0.969 seconds',\n  pendingTime: 'N/A',\n  simulatedElapsedTime: '19 minutes, 0.969 seconds',\n  simulatedPendingTime: 'N/A' }"}
```

Lo importante para saber que todo va bien es ver que el número totalUpdateRequests crece y que el número errorUpdateRequests es 0 o muy próximo a cero (puede ocurrir algún error puntual de conexión o cualquier otro tipo de error).

## Lanzamiendo mediante forever
Puede lanzarse el simulador para que ejecute de forma continuada en una máquina de backoffice mediante forever:

Sirva el siguiente ejemplo:

```
forever start /opt/fiware-device-simulator/bin/fiwareDeviceSimulatorCLI -c /opt/urbo2_simulations/urbo2-beaches-simulation.json -p 60000
```

## Cambio de la programación
Si se quiere cambiar la frecuencia de actualización basta con cambiar los valores en el campo schedule de urbo2-beaches-simulation.json. Pe. una actualización cada 5 minutos quedaría así:

```
"schedule": "48 */5 * * * *"
...
"schedule": "4 */5 * * * *"
```
