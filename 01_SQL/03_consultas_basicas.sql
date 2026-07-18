-- ventas

| id_producto | total |
| ----------- | ----: |
| 1           |    50 |
| 2           |    30 |
| 1           |    25 |


--productos

| id_producto | nombre |
| ----------- | ------ |
| 1           | Arroz  |
| 2           | Leche  |



SELECT productos.nombre , ventas.total as total_ventas
FROM ventas
INNER JOIN productos
ON ventas.id_producto = productos.id_producto


-- requerimiento final
| Producto | Total vendido |
| -------- | ------------: |
| Leche    |           180 |
| Pan      |            80 |
| Arroz    |            75 |


SELECT productos.nombre , sum(total) as total_vendido
FROM ventas
INNER JOIN productos
ON ventas.id_producto = productos.id_producto
group by productos.nombre 
order by total_vendido DESC