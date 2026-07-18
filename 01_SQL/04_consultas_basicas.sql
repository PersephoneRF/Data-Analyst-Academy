-- tabla ventas

| id_venta | id_cliente | id_producto | total |
| -------: | ---------: | ----------: | ----: |
|        1 |        101 |           1 |    50 |
|        2 |        102 |           2 |    30 |
|        3 |        101 |           3 |    80 |
|        4 |        103 |           1 |    25 |
|        5 |        104 |           2 |    90 |
|        6 |        101 |           2 |    60 |


-- tabla clientes

| id_cliente | nombre | ciudad   |
| ---------: | ------ | -------- |
|        101 | Carlos | Bogotá   |
|        102 | Ana    | Medellín |
|        103 | Luis   | Cali     |
|        104 | Sofía  | Bogotá   |


SELECT clientes.nombre as cliente, clientes.ciudad , sum(ventas.total) as Total_comprado
FROM ventas
INNER JOIN clientes
ON ventas.id_cliente = clientes.id_cliente
group by ventas.id_cliente, clientes.nombre , cliente.ciudad
order by Total_comprado DESC;