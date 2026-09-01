--requerimiento

/* "Quiero saber qué asesores concentran la mayor parte de las ventas de cada ciudad.
Muéstrame los asesores ordenados de mayor a menor y dime qué porcentaje acumulado de
 las ventas de su ciudad representan." */

 /* Ciudad
Asesor
Total vendido
Ranking
% participación
% acumulado
Categoría */

-- asesores

codigo_asesor | nombre  | ciudad
--------------+---------+---------
101           | Carlos  | Bogotá
102           | Andrea  | Bogotá
103           | Felipe  | Bogotá
104           | Laura   | Cali
105           | Andrés  | Cali
106           | Diana   | Cali
107           | Mateo   | Medellín
108           | Sofía   | Medellín

--ventas

id_venta | codigo_asesor | fecha       | valor_venta
---------+---------------+-------------+------------
1        | 101           | 2026-07-05  | 400000
2        | 101           | 2026-07-15  | 300000
3        | 101           | 2026-07-20  | 500000

4        | 102           | 2026-07-08  | 600000
5        | 102           | 2026-07-18  | 500000
6        | 102           | 2026-07-25  | 600000

7        | 103           | 2026-07-03  | 200000
8        | 103           | 2026-07-22  | 300000

9        | 104           | 2026-07-06  | 800000
10       | 104           | 2026-07-19  | 500000

11       | 105           | 2026-07-10  | 400000
12       | 105           | 2026-07-23  | 250000

13       | 106           | 2026-07-15  | 500000

14       | 107           | 2026-07-08  | 850000
15       | 107           | 2026-07-22  | 700000

16       | 108           | 2026-07-11  | 500000



with facturado_asesor as (
        select a.codigo_asesor,
		       a.nombre,
			   a.ciudad,
			   sum(v.valor_venta) as total_facturado
		from asesores as a
		inner join ventas as v
		      on a.codigo_Asesor = v.codigo_asesor
		group by a.codigo_asesor,
		         a.nombre,
			     a.ciudad
			   
),

metricas_operacion as (

       select fa.codigo_asesor,
	          rank() over (
              partition by fa.ciudad
			  order by  fa.total_facturado desc
			  ) as ranking_asesores,
			  sum(fa.total_facturado) over (
                  partition by fa.ciudad
				  order by fa.total_facturado desc
			  ) as acumulado,
			  round(
                   (
                     sum(fa.total_facturado) over (
                          partition by fa.ciudad
						  order by fa.total_facturado desc
					 ) / nullif(
                        sum(fa.total_facturado) over (
                           partition by fa.ciudad
						),0
					 )
				   ) *100 ,2
			  ) as porcent_acumulado
    from facturado_asesor as fa


)

 select fa.ciudad,
        fa.nombre as asesor,
		fa.total_facturado,
		mo.ranking_asesores,
		mo.acumulado,
		mo.porcent_acumulado,
		case
		    when mo.porcent_acumulado <= 50 then 'NUCLEO'
		    when mo.porcent_acumulado <= 80 then 'IMPORTANTE'
			ELSE 'RESTO'
		END as categoria
 from facturado_asesor as fa
 inner join metricas_operacion as mo
       on fa.codigo_asesor = mo.codigo_asesor

 order by fa.ciudad asc,
          mo.ranking_asesores asc