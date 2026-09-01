/* 📧 Requerimiento

La empresa MarketPro quiere analizar el desempeño de sus asesores comerciales.

Tenemos estas tablas:

*/

--tabla ventas_asesores 

| id_venta | id_asesor | mes   | valor_venta |
| -------: | --------: | ----- | ----------: |
|        1 |       101 | Julio |      450000 |
|        2 |       101 | Julio |      350000 |
|        3 |       102 | Julio |      700000 |
|        4 |       102 | Julio |      250000 |
|        5 |       103 | Julio |      300000 |
|        6 |       103 | Julio |      200000 |
|        7 |       104 | Julio |      900000 |
|        8 |       104 | Julio |      100000 |
|        9 |       105 | Julio |      500000 |
|       10 |       105 | Julio |      150000 |

--tabla asesores

| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|       101 | Carlos | Bogotá   |
|       102 | Laura  | Bogotá   |
|       103 | Miguel | Cali     |
|       104 | Andrea | Cali     |
|       105 | Sofía  | Medellín |

-- | Ciudad | Asesor | Ventas totales | Promedio ciudad | Diferencia | Ranking | Desempeño |
| ------ | ------ | -------------: | --------------: | ---------: | ------: | --------- |



with ventas_totales_asesor as(
    select va.id_asesor,
           a.nombre,
           a.ciudad,
           sum(va.valor_venta) as ventas_totales
from ventas_asesores as va
inner join asesores as a
on va.id_asesor = a.id_asesor

group by va.id_asesor,
          a.nombre,
          a.ciudad
),

promedio_ciudad as (
    select vta.ciudad,
           avg(vta.ventas_totales) as promedio_ciu
    from ventas_totales_asesor as vta
    group by vta.ciudad
)

select vta.ciudad,
       vta.nombre as asesor,
       vta.ventas_totales,
       pc.promedio_ciu,
       (vta.ventas_totales - pc.promedio_ciu ) as diferencia,
       rank() over (
        partition by vta.ciudad
        order by vta.ventas_totales desc
       ) as ranking_asesores,
       case 
           when (vta.ventas_totales - pc.promedio_ciu ) > 0 then 'SOBRE EL PROMEDIO'
           when (vta.ventas_totales - pc.promedio_ciu ) = 0 then 'EN EL PROMEDIO'
           ELSE 'POR DEBAJO DEL PROMEDIO'
        END AS Desempeño

from ventas_totales_asesor as vta
inner join promedio_ciudad as pc
on vta.ciudad = pc.ciudad

order by vta.ciudad asc , ranking_asesores asc
