-- requirimiento 

/* Empresa: StreamFlix

StreamFlix es una plataforma de streaming.

El director de contenido quiere identificar a los usuarios más valiosos de cada plan de suscripción.

Tiene estas tablas. */

--tabla visualizaciones 

| id_visualizacion | id_usuario | id_pelicula | minutos_vistos |
| ---------------: | ---------: | ----------: | -------------: |
|                1 |        201 |          11 |            120 |
|                2 |        201 |          15 |             90 |
|                3 |        202 |          13 |            180 |
|                4 |        203 |          11 |             60 |
|                5 |        202 |          17 |            120 |
|                6 |        204 |          14 |            250 |
|                7 |        205 |          18 |            300 |
|                8 |        204 |          15 |            100 |
|                9 |        205 |          13 |            120 |
|               10 |        201 |          18 |            150 |


--tabla usuarios
| id_usuario | nombre    | plan    |
| ---------: | --------- | ------- |
|        201 | Andrea    | Premium |
|        202 | Luis      | Premium |
|        203 | Camila    | Básico  |
|        204 | Juan      | Premium |
|        205 | Valentina | Básico  |

--El director quiere un reporte con estas columnas:
--| Plan | Usuario | Total minutos | Ranking plan | Nivel |
| ---- | ------- | ------------: | -----------: | ----- |


with visualizaciones_totales_cliente as (
    select v.id_usuario,
           sum(v.minutos_vistos) as total_minutos,
           u.nombre,
           u.plan,
           rank() over(
            partition by u.plan
            order by sum(v.minutos_vistos) desc
           ) as ranking_plan
    from visualizaciones as v
    inner join usuarios as u
    on v.id_usuario = u.id_usuario
    group by v.id_usuario,
             u.nombre,
             u.plan
             
)

select vtc.plan,
       vtc.id_usuario,
       vtc.nombre,
       vtc.total_minutos,
       vtc.ranking_plan,
       case 
           when vtc.total_minutos > 500 then 'USUARIO PLATINO'
           when vtc.total_minutos >= 300 then 'USUARIO ORO'
           ELSE 'USUARIO PLATA'
        END AS nivel
from visualizaciones_totales_cliente as vtc

order by vtc.plan ASC,
         vtc.ranking_plan ASC;



