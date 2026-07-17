| id_venta | fecha      | id_cliente | id_producto | cantidad | total |
| -------: | ---------- | ---------: | ----------: | -------: | ----: |
|        1 | 2026-07-01 |        101 |           1 |        2 |    50 |
|        2 | 2026-07-01 |        102 |           2 |        1 |    30 |
|        3 | 2026-07-02 |        101 |           3 |        4 |    80 |
|        4 | 2026-07-02 |        103 |           1 |        1 |    25 |
|        5 | 2026-07-03 |        104 |           2 |        3 |    90 |
|        6 | 2026-07-03 |        101 |           2 |        2 |    60 |


--datos

SELECT id_producto, sum(cantidad) as total_vendido
FROM ventas
group by id_producto
order by total_vendido DESC;