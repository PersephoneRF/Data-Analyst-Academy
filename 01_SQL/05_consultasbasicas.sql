--data
| Cliente | Ciudad   | Total |
| ------- | -------- | ----: |
| Carlos  | Bogotá   |    50 |
| Ana     | Medellín |    30 |
| Luis    | Cali     |    25 |
| Sofía   | Bogotá   |    90 |
| Carlos  | Bogotá   |    80 |
| Carlos  | Bogotá   |    60 |


--quremos agrupar por ciudad pero unicamnete los cleintes que se encuetran en bogota

SELECT clientes.nombre  as cliente, clientes.ciudad , sum(ventas.total) as Total_comprado
FROM ventas
INNER JOIN clientes
on ventas.id_cliente = clientes.id_cliente
where clienntes.ciudad = 'Bogotá'
group by ventas.id_cliente, clientes.nombre , clientes.ciudad
order by Total_comprado DESC;