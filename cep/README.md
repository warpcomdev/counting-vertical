# Reglas de CEP

A continuación, un volcado de referencia de las reglas utilizada para el CEP en este vertical, tomado en el entorno de LAB. Tras el volcado, se proporciona una explicación de alto nivel de las distintas reglas.

```json

{
    "error": null,
    "data": [
        {
            "_id": "5efaea85a56522380a10de37",
            "name": "replica_accesos",
            "text": "select \"replica_accesos\" as ruleName, numberOfIncoming? as numberOfIncoming, numberOfOutgoing? as numberOfOutgoing, zoneRef? as zoneRef, current_timestamp().format(\"yyyy-MM-dd'T'HH:mm:ss.SSSX\") as timeinstant from iotEvent where type?='Access' and zoneRef? is not null and cast(zoneRef?, string) != '' and numberOfOutgoing? is not null and cast(cast(numberOfOutgoing?,string),double) >= 0 and numberOfIncoming? is not null and cast(cast(numberOfIncoming?,string),double)>= 0",
            "action": {
                "type": "update",
                "parameters": {
                    "id": "${zoneRef}",
                    "type": "Zone",
                    "attributes": [
                        {
                            "name": "numberOfIncoming",
                            "value": "${numberOfIncoming}",
                            "type": "Number"
                        },
                        {
                            "name": "numberOfOutgoing",
                            "value": "${numberOfOutgoing}",
                            "type": "Number"
                        },
                        {
                            "name": "TimeInstant",
                            "value": "${timeinstant}",
                            "type": "DateTime"
                        }
                    ]
                }
            },
            "subservice": "/aforo",
            "service": "alcobendas"
        },
        {
            "_id": "5f0ea67c5705450e458df133",
            "name": "resetea_ocupacion",
            "text": "select \"resetea_ocupacion\" as ruleName, *, current_timestamp().format(\"yyyy-MM-dd'T'HH:mm:ss.SSSX\") as timeinstant from pattern [every timer:at(0, 0, *, *, *, 0, 'CET')]",            
            "action": [
                {
                    "type": "update",
                    "parameters": {
                        "filter": {
                            "type": "Zone"
                        },
                        "attributes": [
                            {
                                "name": "numberOfIncoming",
                                "type": "Number",
                                "value": 0
                            },
                            {
                                "name": "numberOfOutgoing",
                                "type": "Number",
                                "value": 0
                            },
                            {
                                "name": "occupancy",
                                "type": "Number",
                                "value": 0
                            },
                            {
                                "name": "percentageOfOccupation",
                                "type": "Number",
                                "value": 0.1
                            },
                            {
                                "name": "DateCalculatedOccupancy",
                                "value": "${timeinstant}",
                                "type": "DateTime"
                            }
                        ]
                    }
                },
                {
                    "type": "update",
                    "parameters": {
                        "filter": {
                            "type": "Access",
                            "limit": 200
                        },
                        "attributes": [
                            {
                                "name": "occupancy",
                                "type": "Number",
                                "value": 0
                            },
                            {
                                "name": "percentageOfOccupation",
                                "type": "Number",
                                "value": 0
                            },
                            {
                                "name": "dateCalculatedOccupancy",
                                "value": "${timeinstant}",
                                "type": "DateTime"
                            }
                        ]
                    }
                }
            ],
            "subservice": "/aforo",
            "service": "alcobendas"
        },
        {
            "_id": "5f034cc9f0f2cc305967c249",
            "name": "calcula_ocupacion",
            "text": "select \"calcula_ocupacion\" as ruleName, *, current_timestamp().format(\"yyyy-MM-dd'T'HH:mm:ss.SSSX\") as timeinstant, ( case when ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) < 0 then 0 else ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) end ) as updatedOccupancy, ( case when ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) < 0 then 0 else ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) end ) / cast(cast(capacity?, string), double) as percentage from iotEvent where (type ?= 'Access' or type ?= 'Zone') and capacity? is not null and cast(cast(capacity? ,string), double) > 0 and numberOfIncoming? is not null and cast(cast(numberOfIncoming?, string), double) >= 0 and numberOfOutgoing? is not null and cast(cast(numberOfOutgoing?, string), double) >= 0",
            "action": {
                "type": "update",
                "parameters": {
                    "attributes": [
                        {
                            "name": "occupancy",
                            "value": "${updatedOccupancy}",
                            "type": "Number"
                        },
                        {
                            "name": "percentageOfOccupation",
                            "value": "${percentage}",
                            "type": "Number"
                        },
                        {
                            "name": "dateCalculatedOccupancy",
                            "value": "${timeinstant}",
                            "type": "DateTime"
                        }
                    ]
                }
            },
            "subservice": "/aforo",
            "service": "alcobendas"
        },
        {
            "_id": "5f049438ac6d61560e00df1f",
            "name": "replica_ocupacion",
            "text": "select \"replica_ocupacion\" as ruleName, numberOfIncoming? as numberOfIncoming, numberOfOutgoing? as numberOfOutgoing, source? as source, sourceType? as sourceType, sourcePath? as sourcePath, current_timestamp().format(\"yyyy-MM-dd'T'HH:mm:ss.SSSX\") as timeinstant, ( case when ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) < 0 then 0 else ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) end ) as updatedOccupancy, ( case when ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) < 0 then 0 else ( (case when occupancy? is null or occupancy? = '[?]' then 0 else cast(cast(occupancy?, string), double) end) + cast(cast(numberOfIncoming?, string), double) - cast(cast(numberOfOutgoing?, string), double) ) end ) / cast(cast(capacity?, string), double) as percentage from iotEvent where (type? = 'Access' or type? = 'Zone') and capacity? is not null and cast(cast(capacity? ,string), double) > 0 and numberOfIncoming? is not null and cast(cast(numberOfIncoming?, string), double) >= 0 and numberOfOutgoing? is not null and cast(cast(numberOfOutgoing?, string), double) >= 0 and source? is not null and cast(source?, string) != '' and sourceType? is not null and cast(sourceType?, string) != '' and sourcePath? is not null and cast(sourcePath?, string) != '' and",
            "action": {
                "type": "update",
                "parameters": {
                    "type": "${sourceType}",
                    "id": "${source}",
                    "subservice": "${sourcePath}",
                    "attributes": [
                        {
                            "name": "numberOfIncoming",
                            "value": "${numberOfIncoming}",
                            "type": "Number"
                        },
                        {
                            "name": "numberOfOutgoing",
                            "value": "${numberOfOutgoing}",
                            "type": "Number"
                        },
                        {
                            "name": "occupancy",
                            "value": "${updatedOccupancy}",
                            "type": "Number"
                        },
                        {
                            "name": "percentageOfOccupation",
                            "value": "${percentage}",
                            "type": "Number"
                        },
                        {
                            "name": "dateCalculatedOccupancy",
                            "value": "${timeinstant}",
                            "type": "DateTime"
                        }
                    ]
                }
            },
            "subservice": "/aforo",
            "service": "alcobendas"
        },
    ],
    "count": 6
}
```

## replica_accesos

Esta regla se activa cada vez que llega una actualización de un evento `Access`. Se verifican que lo atributos `source`, `numberOfIncoming` y `numberOfOutgoing` son válidos. La regla actualiza la entidad de tipo `Zone` correspondiente (usando el `zoneRef` para identificar el entity ID de dicha zona) con esos mismos valores de `numberOfIncoming` y `numberOfOutgoing`.

La regla se ha construido a partir del EPL especificado en el fichero [replica_accesos.epl](replica_accesos.epl). Este fichero puede validarse en el [simulador de reglas EPL online](https://esper-epl-tryout.appspot.com/epltryout/mainform.html), utilizando el siguiente evento:

```epl
iotEvent={type="Access",zoneRef="test",numberOfIncoming=500,numberOfOutgoing=10}
```

Observar que se marca esta actualización en la entidad con la fecha `TimeInstant`, lo que dispara una nueva notificación a CEP para calcular los totales de la zona.

## calcula_ocupacion

Actualiza los valores de ocupación y porcentajes en base a los valores de `capacity`, `numberOfOutgoing` y `numberOfIncoming`, considerando estos valores como 0 en los casos degenerados (negativos, etc.).

La regla se ha construido a partir del EPL especificado en el fichero [calcula_ocupacion.epl](calcula_ocupacion.epl). Este fichero puede validarse en el [simulador de reglas EPL online](https://esper-epl-tryout.appspot.com/epltryout/mainform.html), utilizando el siguiente evento:

```epl
iotEvent={type="Access",capacity=1500,occupation=50,numberOfIncoming=500,numberOfOutgoing=10}
```

El 0.001 es debido a un bug actual en el gauge de Urbo y no sería necesario una vez se solucione dicho bug. Observar que se marca esta actualización en la entidad con la fecha `dateCalculatedOccupancy`.

## replica_ocupacion

Esta regla se activa cada vez que llega una actualización de un evento `Access` o `Zone`. Se verifican que los atributos `source`, `'sourcePath`, `sourceType`, `capacity`, `numberOfIncoming` y `numberOfOutgoing` son válidos.

La regla actualiza una **entidad externa**, como puede ser por ejemplo un objeto tipo `Beach` en el subservicio de playas, o un objeto tipo `Building` en el subservicio de patrimonio. La entidad externa se identifica mediante los campos `source`, `sourceType` y `sourcePath` de la entidad `Zone`.

La regla se ha construido a partir del EPL especificado en el fichero [replica_ocupacion.epl](replica_ocupacion.epl). Este fichero puede validarse en el [simulador de reglas EPL online](https://esper-epl-tryout.appspot.com/epltryout/mainform.html), utilizando el siguiente evento:

```epl
iotEvent={type="Access",capacity=1500,source="Sardinero1",sourceType="Beach",sourcePath="/playas",numberOfIncoming=50,numberOfOutgoing=10}
```

El 0.001 es debido a un bug actual en el gauge de Urbo y no sería necesario una vez se solucione dicho bug. Observar que se marca esta actualización en la entidad con la fecha `dateCalculatedOccupancy`.

## resetea_ocupacion

Regla estilo cron que a media noche pone a 0 las ocupaciones de todas las zonas y accesos.
