--tabla ventas_asesores

| id_venta | id_asesor | fecha      | valor_venta |
| -------: | --------: | ---------- | ----------: |
|        1 |       101 | 2026-07-02 |      300000 |
|        2 |       101 | 2026-07-08 |      400000 |
|        3 |       101 | 2026-07-20 |      200000 |
|        4 |       102 | 2026-07-05 |      500000 |
|        5 |       102 | 2026-07-15 |      300000 |
|        6 |       103 | 2026-07-04 |      250000 |
|        7 |       103 | 2026-07-18 |      350000 |
|        8 |       104 | 2026-07-03 |      600000 |
|        9 |       104 | 2026-07-21 |      400000 |
|       10 |       105 | 2026-07-10 |      450000 |
|       11 |       105 | 2026-07-25 |      250000 |
|       12 |       106 | 2026-07-12 |      700000 |


-- tabla asesores

| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|       101 | Carlos | Bogotá   |
|       102 | Laura  | Bogotá   |
|       103 | Miguel | Bogotá   |
|       104 | Andrea | Cali     |
|       105 | Sofía  | Cali     |
|       106 | Daniel | Medellín |

--📋 Requerimiento


--| Ciudad | Asesor | Total vendido | Promedio ciudad | Diferencia | % participación ciudad | Ranking |
| ------ | ------ | ------------: | --------------: | ---------: | ---------------------: | ------: |


with total_facturado_asesor as (
    select va.id_asesor,
           a.nombre,
           a.ciudad,
           sum(va.valor_venta) as total_vendido
    from ventas_asesores as va
    inner join asesores as a
           on va.id_asesor = a.id_asesor
    where va.fecha >= '2026-07-01'
    and   va.fecha <  '2026-08-01'
    
    group by va.id_asesor,
           a.nombre,
           a.ciudad

),

promedio_ciudades as (
    select tfa.ciudad,
           avg(tfa.total_vendido) as promedio
    from total_facturado_asesor as tfa
    group by tfa.ciudad
)

select tfa.ciudad,
       tfa.nombre as asesor,
       tfa.total_vendido,
       pc.promedio,
       (tfa.total_vendido - pc.promedio) as diferencia,
       (tfa.total_vendido / sum(tfa.total_vendido)
        over (
        partition by tfa.ciudad
       )) * 100 as por_participacion,

       rank() over(
        partition by tfa.ciudad
        order by tfa.total_vendido desc
       ) as ranking_asesores

from total_facturado_asesor as tfa
inner join promedio_ciudades as pc
       on tfa.ciudad = pc.ciudad

order by  tfa.ciudad asc,
          ranking_asesores asc;
