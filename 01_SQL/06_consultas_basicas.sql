-- datos
--ventas
| id_venta | id_cliente | total |
| -------: | ---------: | ----: |
|        1 |        101 |    50 |
|        2 |        102 |    30 |
|        3 |        101 |    80 |
|        4 |        103 |    25 |
|        5 |        104 |    90 |
|        6 |        101 |    60 |

--clientes
| id_cliente | nombre | ciudad   |
| ---------: | ------ | -------- |
|        101 | Carlos | Bogotá   |
|        102 | Ana    | Medellín |
|        103 | Luis   | Cali     |
|        104 | Sofía  | Bogotá   |



--Pero ahora solo quiero ver los clientes que hayan comprado más de $100 en total No quiero ver clientes con compras pequeñas.

SELECT c.nombre as cliente,
       c.ciudad,
       sum(v.total) as  ventas_mas_100
FROM ventas as v 
where c.ciudad = 'bogota'

INNER JOIN clientes as c
on v.id_cliente = c.id_cliente
group by v.id_venta ,
         c.nombre,
         c.ciudad
having sum(v.total) > 100
order by ventas_mas_100 DESC;
