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


/* Empresa: FreshMarket

FreshMarket es una cadena de supermercados con presencia en varias ciudades del país.

El director comercial necesita identificar a los clientes más importantes por ciudad para lanzar una campaña de fidelización.

Tiene las siguientes tablas. */

--tabla ventas

| id_venta | fecha      | id_cliente | total_compra |
| -------: | ---------- | ---------: | -----------: |
|        1 | 2026-07-01 |        101 |       350000 |
|        2 | 2026-07-01 |        102 |       220000 |
|        3 | 2026-07-02 |        101 |       180000 |
|        4 | 2026-07-03 |        103 |       500000 |
|        5 | 2026-07-04 |        104 |       150000 |
|        6 | 2026-07-05 |        102 |       280000 |
|        7 | 2026-07-06 |        105 |       450000 |
|        8 | 2026-07-07 |        103 |       300000 |
|        9 | 2026-07-08 |        104 |       200000 |


--tabla clientes

| id_cliente | nombre | ciudad   |
| ---------: | ------ | -------- |
|        101 | Carlos | Bogotá   |
|        102 | Laura  | Bogotá   |
|        103 | Miguel | Cali     |
|        104 | Ana    | Cali     |
|        105 | Sofía  | Medellín |

      
/* El director quiere un reporte con las siguientes columnas:

Ciudad	Cliente	Total comprado	Ranking ciudad	Categoría

Donde:

El Total comprado sea la suma de todas las compras del cliente.
El Ranking ciudad clasifique a los clientes dentro de su propia ciudad, del mayor al menor total comprado.
La Categoría se defina así:
Más de 600.000 → CLIENTE VIP
Entre 300.000 y 600.000 → CLIENTE FRECUENTE
Menos de 300.000 → CLIENTE OCASIONAL

Finalmente, el reporte debe mostrarse ordenado por:

Ciudad.
Ranking. */


with comprado_por_cliente as (
    select 
           v.id_cliente,
           sum(v.total_compra) as total_comprado,
           c.ciudad,
           c.nombre,
           rank() over(
                partition by c.ciudad
                order by sum(v.total_compra) desc
           ) as ranking
    from ventas as v
    inner join clientes as c
    on v.id_cliente = c.id_cliente
    group by v.id_cliente ,
             c.ciudad ,
             c.ciudad,
             c.nombre,

)


select cpc.ciudad,
       cpc.nombre,
       cpc.total_comprado,
       cpc.ranking,
       case 
           when cpc.total_comprado > 600000 then 'CLIENTE VIP'
           when cpc.total_comprado >= 300000  then 'CLIENTE FRECUENTE'
           ELSE 'CLIENTE OCASIONAL'
        END AS categoria
from comprado_por_cliente as cpc
order by cpc.ciudad desc , cpc.ranking desc;
