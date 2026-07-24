--Buenos días.

--Necesito un informe con estas condiciones:

--Solo quiero analizar clientes de Bogotá.
--De esos clientes, muéstrame únicamente los que hayan comprado más de $100 en total.
--Quiero ver:
--Nombre del cliente.
--Ciudad.
--Total comprado.
--Ordena el resultado del mayor al menor.

--Gracias.

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


SELECT c.nombre  as cliente , c.ciudad , sum(v.total) as Total_comprado
FROM ventas as v
INNER JOIN clientes as c
ON v.id_cliente = c.id_cliente
where c.ciudad = 'Bogotá'
group by v.id_cliente, c.nombre , c.ciudad
having sum(v.total) > 100
ORDER BY Total_comprado DESC;
