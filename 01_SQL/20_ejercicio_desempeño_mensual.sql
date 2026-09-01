-- tabla ventas_asesores

| id_venta | id_asesor | fecha      | valor_venta |
| -------: | --------: | ---------- | ----------: |
|        1 |       101 | 2026-07-02 |      450000 |
|        2 |       101 | 2026-07-05 |      350000 |
|        3 |       101 | 2026-06-20 |      900000 |
|        4 |       102 | 2026-07-04 |      700000 |
|        5 |       102 | 2026-07-12 |      250000 |
|        6 |       102 | 2026-06-15 |      400000 |
|        7 |       103 | 2026-07-08 |      300000 |
|        8 |       103 | 2026-07-15 |      200000 |
|        9 |       104 | 2026-07-10 |      900000 |
|       10 |       104 | 2026-07-18 |      100000 |
|       11 |       105 | 2026-07-20 |      500000 |
|       12 |       105 | 2026-07-25 |      150000 |


--tabla asesores

| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|       101 | Carlos | Bogotá   |
|       102 | Laura  | Bogotá   |
|       103 | Miguel | Cali     |
|       104 | Andrea | Cali     |
|       105 | Sofía  | Medellín |

--Requerimiento del director

/* "Quiero conocer el desempeño de los asesores durante julio.

Necesito saber cuánto vendió cada asesor, cuál fue su posición dentro de su ciudad y qué porcentaje representa su facturación respecto al total vendido por todos los asesores de su ciudad.

Además, quiero identificar al asesor número 1 de cada ciudad." */

| Ciudad | Asesor | Total vendido | Ranking ciudad | % del total ciudad | Es líder |
| ------ | ------ | ------------: | -------------: | -----------------: | -------- |


with total_vendido_asesor as (
    select va.id_asesor,
           a.nombre,
           a.ciudad,
           sum(va.valor_venta) as total_vendido
    from ventas_asesores as va
    inner join asesores as a
           on va.id_asesor = a.id_asesor
    where va.fecha >= '2026-07-01' AND 
          va.fecha <  '2026-08-01'
    group by va.id_asesor,
             a.nombre,
             a.ciudad

),

ranking_ciudades as (
    select tva.ciudad,
           tva.nombre,
           tva.total_vendido,
           rank() over (
           partition by tva.ciudad
           order by tva.total_vendido desc
           ) as ranking_ciudad
    from total_vendido_asesor as tva

)


select rc.ciudad,
       rc.nombre,
       rc.total_vendido,
       rc.ranking_ciudad,
       (rc.total_vendido / sum(rc.total_vendido ) over (
                                                  partition by rc.ciudad)) * 100 
                                                  as porcentaje_del_total_ciudad,
        case 
            when rc.ranking_ciudad = 1 then 'SI'
                                       ELSE 'NO'
            END AS es_lider

from ranking_ciudades  as rc     
order by rc.ranking_ciudad asc, rc.ciudad asc

       