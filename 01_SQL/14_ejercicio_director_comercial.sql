/* Hola Richard.

Necesitamos un reporte para la reunión de resultados.

Queremos conocer el ranking de nuestros asesores según las ventas del mes.

Es importante que, si dos asesores tienen exactamente las mismas ventas, ambos aparezcan con la misma posición.

Gracias. */

--tablas
--ventas_asesores
| id_asesor | ventas_mes |
| --------: | ---------: |
|         1 |    1000000 |
|         2 |     900000 |
|         3 |     900000 |
|         4 |     750000 |
|         5 |     600000 |

--asesores

| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|         1 | Carlos | Bogotá   |
|         2 | Laura  | Cali     |
|         3 | Miguel | Medellín |
|         4 | Ana    | Bogotá   |
|         5 | Sofía  | Cali     |


select dense_rank() over (
              order by va.ventas_mes desc
                   ) as ranking ,
        a.nombre as asesor,
        a.ciudad,
        va.ventas_mes as ventas
from ventas_asesores as va
inner join asesores as a
on va.id_asesor = a.id_asesor
order by ranking;

      
