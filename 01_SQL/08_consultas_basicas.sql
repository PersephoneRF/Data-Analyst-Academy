--tarea
-- unicamente consulta principal paso 1
SELECT  id_cliente , sum(total) as total_comprado
FROM ventas
group by id_cliente 

--paso 2

SELECT avg(total_comprado)
FROM ( 
    SELECT id_cliente, sum(total) as total_comprado
    FROM ventas 
    group by id_cliente

) as resumen;

-- paso 3 toda la consulta resultado promedio de las suma de ventas totales por clientes



SELECT AVG(resumen.ventas_totales) resumen_total
FROM (
    SELECT id_cliente , sum(total) as ventas_totales
FROM ventas 
group by id_cliente

     )  AS resumen



--ticket  # 15
/* De: Director Financiero

Buenos días.

Necesito un reporte con los clientes cuyo total de compras sea superior al promedio de compras por cliente.

Quiero visualizar:

Nombre del cliente.
Ciudad.
Total comprado.

Ordenado del mayor al menor. */

-- ventas
| id_venta | fecha      | id_cliente | id_producto | cantidad | total |
| -------: | ---------- | ---------: | ----------: | -------: | ----: |
|        1 | 2026-07-01 |        101 |           1 |        2 |    50 |
|        2 | 2026-07-01 |        102 |           2 |        1 |    30 |
|        3 | 2026-07-02 |        101 |           3 |        4 |    80 |
|        4 | 2026-07-02 |        103 |           1 |        1 |    25 |
|        5 | 2026-07-03 |        104 |           2 |        3 |    90 |
|        6 | 2026-07-03 |        101 |           2 |        2 |    60 |

--clientes
| id_cliente | nombre | ciudad   |
| ---------: | ------ | -------- |
|        101 | Carlos | Bogotá   |
|        102 | Ana    | Medellín |
|        103 | Luis   | Cali     |
|        104 | Sofía  | Bogotá   |

--productos

| id_producto | nombre |
| ----------: | ------ |
|           1 | Pan    |
|           2 | Leche  |
|           3 | Huevos |



SELECT c.nombre,
       c.ciudad,
       sum(v.total) as total_comprado
FROM ventas as v
INNER JOIN clientes as c
ON v.id_cliente = c.id_cliente

GROUP BY c.id_cliente,
         c.nombre,
         c.ciudad
HAVING sum(v.total) > (
    SELECT AVG(resumen.suma_total)
    FROM (
        SELECT v.id_cliente,
               sum(v.total) as suma_total
        FROM ventas as v
        GROUP BY v.id_cliente

    ) AS resumen
)

ORDER BY total_comprado DESC;






