--tabla registro_ventas

| id_operacion | codigo_asesor | fecha_operacion | monto_facturado |
| -----------: | ------------: | --------------- | --------------: |
|            1 |           201 | 2026-07-02      |          300000 |
|            2 |           201 | 2026-07-08      |          400000 |
|            3 |           201 | 2026-07-20      |          200000 |
|            4 |           202 | 2026-07-05      |          500000 |
|            5 |           202 | 2026-07-15      |          300000 |
|            6 |           203 | 2026-07-04      |          250000 |
|            7 |           203 | 2026-07-18      |          350000 |
|            8 |           204 | 2026-07-03      |          600000 |
|            9 |           204 | 2026-07-21      |          400000 |
|           10 |           205 | 2026-07-10      |          450000 |
|           11 |           205 | 2026-07-25      |          250000 |
|           12 |           206 | 2026-07-12      |          700000 |


--tabla equipo_comercial

| codigo_asesor | asesor | sede     |
| ------------: | ------ | -------- |
|           201 | Carlos | Bogotá   |
|           202 | Laura  | Bogotá   |
|           203 | Miguel | Bogotá   |
|           204 | Andrea | Cali     |
|           205 | Sofía  | Cali     |
|           206 | Daniel | Medellín |



--Requerimientos


--| Ciudad | Asesor | Total vendido | Promedio ciudad | Diferencia | Ranking | % participación | Bono     |
| ------ | ------ | ------------: | --------------: | ---------: | ------: | --------------: | -------- |
| Bogotá | Carlos |        900000 |          766666 |     133334 |       1 |          39.13% | BONO     |
| Bogotá | Laura  |        800000 |          766666 |      33334 |       2 |          34.78% | BONO     |
| Bogotá | Miguel |        600000 |          766666 |    -166666 |       3 |          26.09% | SIN BONO |

--


with total_facturado_asesor as (
    select rv.codigo_asesor,
           ec.asesor,
           ec.sede,
           sum(rv.monto_facturado) as total_vendido
    from registro_ventas as rv
    inner join equipo_comercial as ec
        on rv.codigo_asesor = ec.codigo_asesor

    group by rv.codigo_asesor,
             ec.asesor,
             ec.sede

),

promedio_ciudades as (
    select tfa.sede,
           avg(tfa.total_vendido) as promedio
    from total_facturado_asesor as tfa
    group by tfa.sede
),

ranking_sede as (
    select tfa.codigo_asesor,
           tfa.asesor,
           tfa.sede,
           tfa.total_vendido,
           row_number() over (
            partition by tfa.sede
            order by tfa.total_vendido desc
           ) as top_mejores
    from total_facturado_asesor as tfa

)

select tfa.sede,
       tfa.asesor,
       tfa.total_vendido,
       pc.promedio,
       (tfa.total_vendido - pc.promedio) as diferencia,
       rs.top_mejores,
       (tfa.total_vendido / sum(tfa.total_vendido) over (
        partition by tfa.sede
       )) * 100 as porcentaje_participacion,
       case 
           when rs.top_mejores <= 3
            and  tfa.total_vendido > pc.promedio
                  then 'BONO'
                 else 'SIN BONO'
        end as bono

from total_facturado_asesor as tfa
inner join promedio_ciudades as pc
      on tfa.sede = pc.sede
inner join ranking_sede as rs
      on tfa.codigo_asesor = rs.codigo_asesor

order by tfa.sede asc ,
         rs.top_mejores asc






