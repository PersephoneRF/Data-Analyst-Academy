/* Cuando el requerimiento está incompleto

Esta vez el director comercial te manda esto:

"Necesito un reporte de los mejores asesores del mes pasado. Quiero saber quiénes vendieron más, cuánto vendieron */

-- tabla ventas_asesores

| id_venta | id_asesor | fecha      | valor_venta |
| -------: | --------: | ---------- | ----------: |
|        1 |       101 | 2026-07-02 |      450000 |
|        2 |       101 | 2026-07-05 |      350000 |
|        3 |       102 | 2026-07-04 |      700000 |
|        4 |       102 | 2026-07-12 |      250000 |
|        5 |       103 | 2026-07-08 |      300000 |
|        6 |       103 | 2026-07-15 |      200000 |
|        7 |       104 | 2026-07-10 |      900000 |
|        8 |       104 | 2026-07-18 |      100000 |
|        9 |       105 | 2026-07-20 |      500000 |
|       10 |       105 | 2026-07-25 |      150000 |


-- tabla asesores 
| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|       101 | Carlos | Bogotá   |
|       102 | Laura  | Bogotá   |
|       103 | Miguel | Cali     |
|       104 | Andrea | Cali     |
|       105 | Sofía  | Medellín |


/* .

Después de tus preguntas, el director responde:

"Cuando digo mejores asesores, me refiero a quienes generan mayor facturación total durante julio.

Quiero identificar los 3 mejores asesores de cada ciudad.

El objetivo es premiarlos al final del mes.

También quiero saber cuánto vendió cada uno y cuánto estuvo por encima o por debajo del promedio de facturación de su ciudad." */

--| Ciudad | Asesor | Facturación | Promedio ciudad | Diferencia | Ranking |
| ------ | ------ | ----------: | --------------: | ---------: | ------: |


with facturacion_asesor as (
    select va.id_asesor,
           a.nombre,
           a.ciudad,
           sum(va.valor_venta) as total_facturado
    from ventas_asesores as va
    inner join asesores as a
    on va.id_asesor = a.id_asesor
    group by va.id_asesor,
             a.nombre,
             a.ciudad
),

promedio_ciudad as (
    select fa.ciudad,
           avg(fa.total_facturado) as promedio
    from facturacion_asesor as  fa
    group by fa.ciudad
),

ranking_asesores as (
    select fa.id_asesor,
           fa.ciudad,
           fa.total_facturado,
           row_number() over(
            partition by fa.ciudad
            order by fa.total_facturado desc
           ) as ranking_ganadores
    from facturacion_asesor as fa
            

)

select fa.nombre as asesor,
       fa.ciudad,
       fa.total_facturado,
       pc.promedio,
       (fa.total_facturado - pc.promedio ) as diferencia,
       ra.ranking_ganadores

from facturacion_asesor as fa

inner join promedio_ciudad as pc
on fa.ciudad = pc.ciudad
inner join ranking_asesores as ra
on fa.id_asesor = ra.id_asesor

where ra.ranking_ganadores <= 3

order by fa.ranking_ganadores asc, fa.ciudad asc;




       

