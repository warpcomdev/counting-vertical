El modelo del vertical de Conteo de Accesos utiliza los siguentes tipos de entidad:

*	**Access**: Contador de accesos.
*	**Zone**: Zona de conteo (agrupa múltiples Access interconectados).

## Referencia de campos (_Access_)

|         Atributo        |       Tipo       | Frecuency |                                                       Descripción                                                       |                                                Información Adicional                                                |    Ud    |  Rango  |
|:-----------------------:|:----------------:|:---------:|:-----------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------:|:--------:|:-------:|
| id                      | -                | Static    | ID de la entidad                                                                                                        | Ejemplo: acceso1                                                                                                    | -        | -       |
| type                    | Access           | Static    | Tipo de entidad                                                                                                         | Valor: Access                                                                                                       | -        | -       |
| TimeInstant             | DateTime         | HIGH      | Fecha de actualización de la entidad                                                                                    | Ejemplo: 2020-06-15T09:00:00.00Z                                                                                    | -        | -       |
| zoneRef                 | Text             | Static    | Reference a la zona a la que pertenece el acceso                                                                        | Ejemplo: Sardinero                                                                                                  |          |         |
| source                  | Text             | Static    | ID del objeto externo a actualizar                                                                                      | Ejemplo: Acceso1                                                                                                    | -        | -       |
| sourcePath              | Text             | Static    | Subservicio del objeto externo a actualizar                                                                             | Ejemplo: /playas                                                                                                    | -        | -       |
| sourceType              | Text             | Static    | Tipo del objeto externo a actualizar                                                                                    | Ejemplo: Access                                                                                                     | -        | -       |
| period                  | Number           | Static    | Tamaño del periodo de muestreo de la información en minutos                                                             | Ejemplo: 60                                                                                                         | minutos  | >= 0    |
| name                    | Text             | Static    | Nombre del acceso                                                                                                       | Ejemplo: Acesso puerta rodajos                                                                                      | -        | -       |
| description             | TextUnrestricted | Static    | Descripción del acceso                                                                                                  | -                                                                                                                   | -        | -       |
| address                 | TextUnrestricted | Static    | Dirección del acceso                                                                                                    | Ejemplo: Paseo Marítimo, 16,   12100 El Grao de Castellón, Castellón                                                | -        | -       |
| location                | geo:json         | Static    | Posición geográfica [lon, lat]                                                                                          | Ejemplo: "location":   {"type": "geo:json", "value":   {"type": "Point", "coordinates": [0.026029,   39.986109] } } | -        | -       |
| areaServed              | geo:json:area    | Static    | Territorio                                                                                                              |                                                                                                                     | -        | -       |
| category                | Text             | Static    | Categoría de acceso (barrera, yacimiento, edificio, etc). Segun necesidades de cliente                                  | -                                                                                                                   | -        | -       |
| width                   | Number           | Static    | Anchura del acceso                                                                                                      | Ejemplo: 120                                                                                                        | metros   | >0      |
| length                  | Number           | Static    | Longitud del acceso                                                                                                     | Ejemplo: 400                                                                                                        | m        | 0-n     |
| capacity                | Number           | Static    | Capacidad del acceso (cuando   aplique)                                                                                 | Ejemplo:203                                                                                                         | personas | >0      |
| numberOfIncoming        | Number           | HIGH      | Número de personas que acceden   entre medidas                                                                          |                                                                                                                     | personas | >= 0    |
| numberOfOutgoing        | Number           | HIGH      | Número de personas que salen   entre medidas                                                                            |                                                                                                                     | personas | >= 0    |
| occupancy               | Number           | HIGH      | Ultima ocupación conocida                                                                                               | Ejemplo: 231                                                                                                        | personas | >0      |
| percentageOfOccupation  | Number           | HIGH      | Porcentaje de ocupación sobre la   capacidad                                                                            | Ejemplo: 90                                                                                                         | %        | [0-100] |
| dateCalculatedOccupancy | DateTime         | HIGH      | Tiempo en que el CEP calculó la   ocupación                                                                             | Ejemplo: 2020-06-15T09:00:00.00Z                                                                                    | -        | -       |

Ejemplo de `Access` (en NGSIv2):

```
{
    "id": "Sardinero1_A1",
    "type": "Access",
    "TimeInstant": {
        "type": "DateTime",
        "value": "2020-06-03T12:00:00.00Z"
    },
    "zoneRef": {
        "type": "Text",
        "value": "Sardinero1"
    },
    "name": {
        "type": "Text",
        "value": "Primer acceso Sardinero"
    },
    "description": {
        "type": "Text",
        "value": "Primer acceso Sardinero",
    },
    "address": {
        "type": "Text",
        "value": "Av. Manuel García Lago, 2, 39005 Santander, Cantabria"
    },
    "location": {
        "type": "geo:json",
        "value": {
            "type": "Point",
            "coordinates": [
                -3.787358,
                43.477326
            ]
        }
    },
    "areaServed": {
        "type": "geo:json:area",
        "value": "{
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [[[-3.7831592559814453,43.47420887282295],[-3.7836098670959473,43.47366386812342],[-3.7830412387847896,43.47303321369392],[-3.782869577407837,43.47314221616454],[-3.7812387943267827,43.471982108353174],[-3.781346082687378,43.47186531774241],[-3.781099319458008,43.47174852690596],[-3.7803804874420166,43.47192760609625],[-3.7802946567535405,43.47191982005554],[-3.7800264358520512,43.471756312968736],[-3.780069351196289,43.471600591522446],[-3.7790071964263916,43.471405939150344],[-3.7783956527709956,43.47144486967492],[-3.7781703472137447,43.47164730799847],[-3.7776231765747075,43.47191203401381],[-3.7778162956237793,43.471982108353174],[-3.7782990932464595,43.471787457209864],[-3.7789535522460933,43.47182638748867],[-3.7802731990814213,43.47232469284277],[-3.7820756435394283,43.47343029317614],[-3.7831592559814453,43.47420887282295]]]}}
    },
    "category": {
        "type": "Text",
        "value": "Public"
    },
    "width": {
        "type": "Number",
        "value": "23"
    },
    "length": {
        "type": "Number",
        "value": "123"
    },
    "capacity": {
        "type": "Number",
        "value": "150"
    }
}
```

## Referencia de campos (_Zone_)

|         Atributo        |       Tipo       | Frecuency |                                                                               Descripción                                                                              |                                                Información Adicional                                                |    Ud    |  Rango  |
|:-----------------------:|:----------------:|:---------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------:|:--------:|:-------:|
| id                      | -                | Static    | ID de la entidad                                                                                                                                                       | Ejemplo: laconcha                                                                                                   | -        | -       |
| type                    | -                | Static    | Tipo de entidad                                                                                                                                                        | Valor: AccessZone                                                                                                   | -        | -       |
| TimeInstant             | DateTime         | LOW       | Fecha de actualización de la   entidad                                                                                                                                 | Ejemplo: 2020-06-15T09:00:00.00Z   (Datos desde las 09:00 a las 10:00h)                                             | -        | -       |
| source                  | Text             | Static    | ID del objeto externo a   actualizar                                                                                                                                   | Ejemplo: zona1                                                                                                      | -        | -       |
| sourcePath              | Text             | Static    | Subservicio del objeto externo a   actualizar                                                                                                                          | Ejemplo: /playas                                                                                                    | -        | -       |
| sourceType              | Text             | Static    | Tipo del objeto externo a   actualizar                                                                                                                                 | Ejemplo: AccessZone                                                                                                 | -        | -       |
| name                    | Text             | Static    | Nombre de la zona                                                                                                                                                      | Ejemplo: Playa del Pinar                                                                                            | -        | -       |
| description             | TextUnrestricted | Static    | Descripción de la zona                                                                                                                                                 | -                                                                                                                   | -        | -       |
| address                 | TextUnrestricted | Static    | Dirección de la zona                                                                                                                                                   | Ejemplo: Paseo Marítimo, 16,   12100 El Grao de Castellón, Castellón                                                | -        | -       |
| location                | geo:json         | Static    | Posición geográfica [lon, lat]                                                                                                                                         | Ejemplo: "location":   {"type": "geo:json", "value":   {"type": "Point", "coordinates": [0.026029,   39.986109] } } | -        | -       |
| areaServed              | geo:json:area    | Static    | Territorio                                                                                                                                                             |                                                                                                                     | -        | -       |
| category                | Text             | Static    | Categoría de zona (pública,   privada, gratuita, de pago, etc) según necesidades del cliente                                                                           | -                                                                                                                   | -        | -       |
| width                   | Number           | Static    | Ancho de la zona                                                                                                                                                       | Ejemplo: 50                                                                                                         | m        | 0-n     |
| length                  | Number           | Static    | Longitud de la zona                                                                                                                                                    | Ejemplo: 400                                                                                                        | m        | 0-n     |
| occupationRate          | Text             | Static    | Nivel de ocupación típico                                                                                                                                              | Posibles valores: low, medium,   high                                                                               | -        | -       |
| capacity                | Number           | Static    | Aforo bruto. Se obtiene   dividiendo la superficie total de la zona entre la distancia mínima de   seguridad interpersonal determinada por las autoridades competentes | Ejemplo: 100                                                                                                        | personas | 0-n     |
| numberOfIncoming        | Number           | HIGH      | Medida periodica de personas que   entran entre medidas                                                                                                                | Ejemplo: 67                                                                                                         | personas | >=0     |
| numberOfOutgoing        | Number           | HIGH      | Medida periodica de personas que   salen entre medidas                                                                                                                 | Ejemplo: 45                                                                                                         | personas | >=0     |
| occupancy               | Number           | HIGH      | Ultima ocupación conocida                                                                                                                                              | Ejemplo: 231                                                                                                        | personas | >0      |
| percentageOfOccupation  | Number           | HIGH      | %Ocupacion sobre última   ocupación conocida                                                                                                                           | Ejemplo: 35                                                                                                         | %        | [0-100] |
| dateCalculatedOccupancy | DateTime         | HIGH      | Fecha en que CEP calculó la   ocupación                                                                                                                                | Ejemplo:   2020-06-29T20:02:00.551Z                                                                                 | -        | -       |

Ejemplo de `Zone` (en NGSIv2):

```
{
    "id": "Sardinero1",
    "type": "Zone",
    "TimeInstant": {
        "type": "DateTime",
        "value": "2020-06-03T12:00:00.00Z"
    },
    "source": {
        "type": "Text",
        "value": "Sardinero1"
    },
    "sourceType": {
        "type": "Text",
        "value": "Beach",
    },
    "sourcePath": {
        "type": "Text",
        "value": "/playas",
    },
    "name": {
        "type": "Text",
        "value": "Playa Sardinero"
    },
    "description": {
        "type": "Text",
        "value": "Playa Sardinero",
    },
    "address": {
        "type": "Text",
        "value": "Av. Manuel García Lago, 2, 39005 Santander, Cantabria"
    },
    "location": {
        "type": "geo:json",
        "value": {
            "type": "Point",
            "coordinates": [
                -3.787358,
                43.477326
            ]
        }
    },
    "areaServed": {
        "type": "geo:json:area",
        "value": "{
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [[[-3.7831592559814453,43.47420887282295],[-3.7836098670959473,43.47366386812342],[-3.7830412387847896,43.47303321369392],[-3.782869577407837,43.47314221616454],[-3.7812387943267827,43.471982108353174],[-3.781346082687378,43.47186531774241],[-3.781099319458008,43.47174852690596],[-3.7803804874420166,43.47192760609625],[-3.7802946567535405,43.47191982005554],[-3.7800264358520512,43.471756312968736],[-3.780069351196289,43.471600591522446],[-3.7790071964263916,43.471405939150344],[-3.7783956527709956,43.47144486967492],[-3.7781703472137447,43.47164730799847],[-3.7776231765747075,43.47191203401381],[-3.7778162956237793,43.471982108353174],[-3.7782990932464595,43.471787457209864],[-3.7789535522460933,43.47182638748867],[-3.7802731990814213,43.47232469284277],[-3.7820756435394283,43.47343029317614],[-3.7831592559814453,43.47420887282295]]]}}
    },
    "category": {
        "type": "Text",
        "value": "Public"
    },
    "status": {
        "type": "Text",
        "value": "OK"
    },
    "width": {
        "type": "Number",
        "value": "23"
    },
    "length": {
        "type": "Number",
        "value": "123"
    },
    "occupationRate": {
        "type": "Number",
        "value": "High"
    },
    "capacity": {
        "type": "Number",
        "value": "150"
    }
}
```
