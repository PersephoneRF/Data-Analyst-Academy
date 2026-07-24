
--CTE de la tabla temporal donde se regitran el total de compras que han hecho cada cliente


/* El Director Financiero ahora quiere un reporte mucho más simple.

Ya no necesita comparar contra el promedio.

Solo quiere una tabla con:

Nombre del cliente.
Ciudad.
Total comprado.

Ordenado del mayor al menor.
 */


with total_por_cliente as (
    select id_cliente,
           sum(total) as ventas_totales
    from ventas
    group by id_cliente
)

select c.nombre , c.ciudad , total_por_cliente.ventas_totales
from clientes as c
inner join total_por_cliente
on c.id_cliente = total_por_cliente.id_cliente
order by total_por_cliente.ventas_totales desc;


---- si tuvieras que crear la misma consulta del ejercicio 8 pero utlizando CTE

with total_suma_cliente as (
    select id_cliente,
    sum(total) as total_customer
    from ventas
    group by id_cliente
),


promedio_total as (
    select avg(tsc.total_customer) as promedio
    from total_suma_cliente as tsc
)

select c.nombre,
       c.ciudad,
       sum(total) as total_comprado
from ventas as v
inner join clientes as c
on v.id_cliente = c,id_cliente
group by c.id_cliente,
         c.nombre,
         c.ciudad
having sum(v.total) > (
    select promedio
    from promedio_total

)

order by total_comprado desc;


