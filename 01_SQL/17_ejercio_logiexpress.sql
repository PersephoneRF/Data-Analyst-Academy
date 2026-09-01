--Requerimiento

| Ciudad | Conductor | Total facturado | Promedio ciudad | Diferencia | Ranking |
| ------ | --------- | --------------: | --------------: | ---------: | ------: |









--tabla envios

| id_envio | id_conductor | ciudad   | valor_envio |
| -------: | -----------: | -------- | ----------: |
|        1 |            1 | Bogotá   |       45000 |
|        2 |            1 | Bogotá   |       55000 |
|        3 |            2 | Bogotá   |       70000 |
|        4 |            3 | Cali     |       65000 |
|        5 |            3 | Cali     |       35000 |
|        6 |            4 | Cali     |       90000 |
|        7 |            5 | Medellín |      120000 |
|        8 |            5 | Medellín |       30000 |
|        9 |            2 | Bogotá   |       50000 |
|       10 |            4 | Cali     |       45000 |

--tabla conductores
| id_conductor | nombre |
| -----------: | ------ |
|            1 | Carlos |
|            2 | Laura  |
|            3 | Miguel |
|            4 | Andrea |
|            5 | Sofía  |


with total_facturado_conductor as (
    select e.id_conductor,
           c.nombre,
           e.ciudad,
          sum(e.valor_envio) as total_facturado
from envios as e
inner join conductores as c
on e.id_conductor = c.id_conductor
group by e.id_conductor, e.ciudad, c.nombre


),

promedio_ciudad as (
    select ciudad,
           avg(total_facturado) as promedio
    from total_facturado_conductor
    group by ciudad
)


select tfc.ciudad,
       tfc.nombre as conductor,
       tfc.total_facturado,
       pc.promedio,
       (tfc.total_facturado - pc.promedio) as diferencia,
       rank() over(
        partition by tfc.ciudad
        order by tfc.total_facturado desc 
               
       ) as Ranking_total



from total_facturado_conductor as tfc
inner join promedio_ciudad as pc
on tfc.ciudad = pc.ciudad
order by tfc.ciudad asc, Ranking_total asc






       
