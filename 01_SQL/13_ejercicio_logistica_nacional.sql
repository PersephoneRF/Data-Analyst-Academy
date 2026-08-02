-- tabla envios

| id_envio | fecha      | id_conductor | ciudad   | valor_envio |
| -------: | ---------- | -----------: | -------- | ----------: |
|        1 | 2026-08-01 |          301 | Bogotá   |       45000 |
|        2 | 2026-08-01 |          302 | Cali     |       60000 |
|        3 | 2026-08-02 |          301 | Bogotá   |       35000 |
|        4 | 2026-08-02 |          303 | Medellín |       90000 |
|        5 | 2026-08-03 |          302 | Cali     |       55000 |
|        6 | 2026-08-03 |          301 | Bogotá   |       80000 |
|        7 | 2026-08-04 |          303 | Medellín |       40000 |
|        8 | 2026-08-04 |          302 | Cali     |       70000 |


--tabla conductores 

| id_conductor | nombre        |
| -----------: | ------------- |
|          301 | Carlos Díaz   |
|          302 | Laura Torres  |
|          303 | Miguel Castro |


with ranking_envios as (
    select id_envio,
           id_conductor,
           valor_envio,
           
           rank() over (
            partition by ciudad
            order by valor_envio desc) as puesto
    from envios 
    
    
)

select re.puesto,
       c.nombre,
       re.valor_envio
from ranking_envios as re
inner join conductores as c 
on re.id_conductor = c.id_conductor
order by re.puesto asc;
