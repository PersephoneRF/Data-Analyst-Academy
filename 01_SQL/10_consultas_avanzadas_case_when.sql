-- el gerente quiere un reporte como este 

| Cliente | Ciudad   | Total Comprado | Categoría         |
| ------- | -------- | -------------: | ----------------- |
| Carlos  | Bogotá   |            190 | Cliente Premium   |
| Sofía   | Bogotá   |             90 | Cliente Frecuente |
| Ana     | Medellín |             30 | Cliente Ocasional |
| Luis    | Cali     |             25 | Cliente Ocasional |


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


with suma_total_cliente > (
    select id_cliente
           sum(total) as suma_total
    from ventas
    group by id_clientes
) 

select c.nombre as cliente ,
       c.ciudad
       stc.suma_total as total_comprado,

       case
           when total_comprado > 150 then 'CLIENTE PREMIUM'
           when total_comprado >= 80 then 'CLIENTE FRECUENTE'
           ELSE 'CLIENTE OCASIONAL'
        END AS categoria
from clientes as c
inner join suma_total_cliente as stc
on c.id_cliente = stc.id_cliente
order by total_comprado desc;




