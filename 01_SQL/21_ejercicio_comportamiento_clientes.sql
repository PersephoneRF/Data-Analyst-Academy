--tabla compras 

| id_compra | id_cliente | fecha      | valor_compra |
| --------: | ---------: | ---------- | -----------: |
|         1 |        201 | 2026-07-02 |       250000 |
|         2 |        201 | 2026-07-10 |       300000 |
|         3 |        202 | 2026-07-04 |       500000 |
|         4 |        202 | 2026-07-15 |       200000 |
|         5 |        203 | 2026-07-05 |       150000 |
|         6 |        203 | 2026-07-20 |       100000 |
|         7 |        204 | 2026-07-08 |       700000 |
|         8 |        204 | 2026-07-22 |       300000 |
|         9 |        205 | 2026-07-11 |       400000 |
|        10 |        205 | 2026-07-25 |       100000 |
|        11 |        206 | 2026-07-12 |       600000 |
|        12 |        206 | 2026-07-28 |       100000 |


-- tabla clientes

| id_cliente | nombre | ciudad   |
| ---------: | ------ | -------- |
|        201 | Carlos | Bogotá   |
|        202 | Laura  | Bogotá   |
|        203 | Miguel | Cali     |
|        204 | Andrea | Cali     |
|        205 | Sofía  | Medellín |
|        206 | Daniel | Bogotá   |


--requerimiento

El director comercial dice:

/* "Quiero analizar las compras realizadas durante julio.

Necesito saber cuánto compró cada cliente, cuál es su posición frente a los demás clientes de su ciudad y qué porcentaje representa su compra respecto al total comprado en su ciudad.

Además, quiero identificar a los clientes que están dentro del grupo de los dos clientes que más compraron en cada ciudad." */

--| Ciudad | Cliente | Total comprado | Posición | % ciudad | ¿Top 2? |
| ------ | ------- | -------------: | -------: | -------: | ------- |


with facturacion_total_cliente as (
    select c.id_cliente,
           cl.nombre,
           cl.ciudad,
           sum(c.valor_compra) as total_comprado,
           count(c.id_cliente) as cantidad_compra
    from compras as c
    inner join clientes as cl
             on c.id_cliente = cl.id_cliente
    where c.fecha >= '2026-07-01'
     AND  c.fecha <'2026-08-01'
    group by c.id_cliente,
             cl.nombre,
             cl.ciudad
),

ranking_clientes as (
          
    select ftc.id_cliente,
           ftc.ciudad,
           ftc.nombre,
           ftc.total_comprado,
           ftc.cantidad_compra,
           row_number() over (
            partition by ftc.ciudad
            order by ftc.total_comprado desc,
                     ftc.cantidad_compra desc,
                     ftc.id_cliente  desc
           ) as posicion
    from facturacion_total_cliente as ftc

        
)

select rc.ciudad,
       rc.nombre as cliente,
       rc.total_comprado,
       rc.posicion,
       (rc.total_comprado / sum(rc.total_comprado) over (
                                                   partition by rc.ciudad
       )) * 100 as porcentaje_participacion,
       case 
           when rc.posicion <= 2 then 'si'
           else 'no'
        end as top_2
from ranking_clientes as rc

order by rc.ciudad asc ,
         rc.posicion asc
