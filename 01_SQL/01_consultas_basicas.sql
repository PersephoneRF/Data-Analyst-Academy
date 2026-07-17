-- Consulta 1

Obtén el número total de ventas.

| id_venta | fecha      | id_cliente | id_producto | cantidad | total |
| -------: | ---------- | ---------: | ----------: | -------: | ----: |
|        1 | 2026-07-01 |        101 |           1 |        2 |    50 |
|        2 | 2026-07-01 |        102 |           2 |        1 |    30 |
|        3 | 2026-07-02 |        101 |           3 |        4 |    80 |
|        4 | 2026-07-02 |        103 |           1 |        1 |    25 |
|        5 | 2026-07-03 |        104 |           2 |        3 |    90 |
|        6 | 2026-07-03 |        101 |           2 |        2 |    60 |

SELECT count(id_venta) FROM  ventas


-- Consulta 2

Obtén el ingreso total
SELECT sum(total) FROM ventas


--Consulta 3

Intenta obtener el número de clientes diferentes.

SELECT  count(DISTINCT id_cliente) as numero_clientes FROM ventas
