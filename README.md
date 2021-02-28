# counting-vertical

Este directorio contiene las herramientas e información necesarias
para la instanciación del vertical de conteo.

El vertical de conteo es genérico; las entidades creadas en este vertical son entidades intermedias para el conteo, y no tienen vocación de ser entidades directamente utilizadas en los paneles o el comandado. 

En lugar de eso, las entidades simplemente calculan la ocupación de una zona en función del flujo de entradas y salidas por sus diferentes accesos, y actualizan con los totales alguna entidad en un servicio externo, que es la que realmente representa el objeto controlado.

Nombre de subservicio a usar para este vertical: `/conteo`.
Observar que en el caso de usar este vertical en modo mancomunado
este subservicio vendrá precedido del nombre del scope.

## Changelog

TBD.