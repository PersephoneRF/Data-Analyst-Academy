/* Necesito un reporte para la reunión del lunes.

Quiero conocer nuestros clientes más importantes.

El reporte debe mostrar:

Nombre del cliente.
Ciudad.
Total comprado.
Categoría del cliente.

Las categorías serán:

Más de 150 → Cliente Premium.
Desde 80 hasta 150 → Cliente Frecuente.
Menos de 80 → Cliente Ocasional.

Ordena el reporte del cliente que más compró al que menos compró. */


--tablas 
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


with total_comprado_cliente as (
    select id_cliente,
            sum(total) as suma_total
    from ventas
    group by id_cliente

)

select c.nombre,
       c.ciudad ,
       tcc.suma_total as total_comprado,
       case
           when tcc.suma_total > 150 then 'CLIENTE PREMIUM'
           when tcc.suma_total >= 80 then 'CLIENTE FRECUENTE'
           ELSE 'CLIENTE OCASIONAL'
        END AS categoria
        

from  clientes as c
inner join total_comprado_cliente as tcc
on c.id_cliente = tcc.id_cliente
order by total_comprado DESC;
