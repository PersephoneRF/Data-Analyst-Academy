--tabla asesores

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

--tabla ventas 

id_venta | codigo_asesor | fecha       | valor_venta
---------+---------------+-------------+------------
1        | 101           | 2026-06-05  | 400000
2        | 101           | 2026-06-15  | 300000
3        | 101           | 2026-07-05  | 500000
4        | 101           | 2026-07-20  | 400000

5        | 102           | 2026-06-08  | 600000
6        | 102           | 2026-06-18  | 500000
7        | 102           | 2026-07-10  | 650000
8        | 102           | 2026-07-25  | 600000

9        | 103           | 2026-06-03  | 200000
10       | 103           | 2026-06-22  | 300000
11       | 103           | 2026-07-07  | 250000
12       | 103           | 2026-07-21  | 300000

13       | 104           | 2026-06-04  | 700000
14       | 104           | 2026-06-19  | 400000
15       | 104           | 2026-07-06  | 800000
16       | 104           | 2026-07-19  | 500000

17       | 105           | 2026-06-10  | 500000
18       | 105           | 2026-06-25  | 300000
19       | 105           | 2026-07-12  | 400000
20       | 105           | 2026-07-23  | 250000

21       | 106           | 2026-06-12  | 300000
22       | 106           | 2026-07-15  | 500000

23       | 107           | 2026-06-05  | 900000
24       | 107           | 2026-06-20  | 600000
25       | 107           | 2026-07-08  | 850000
26       | 107           | 2026-07-22  | 700000

27       | 108           | 2026-06-07  | 400000
28       | 108           | 2026-07-11  | 500000


/* 📋 El requerimiento

El gerente quiere un reporte con:

Ciudad
Asesor
Ventas junio
Ventas julio
Diferencia
% crecimiento
Participación dentro de la ciudad
Ranking dentro de la ciudad
Estado

Y define:

Estado
MEJORÓ → crecimiento superior al 20%.
EMPEORÓ → crecimiento inferior al -20%.
ESTABLE → entre -20% y 20%. */


with facturado_asesor as (
     select a.codigo_asesor,
	        a.nombre,
			a.ciudad,
			sum(
                case
				    when v.fecha >= '2026-06-01'
					and  v.fecha <  '2026-07-01'
					then v.valor_venta
					else 0
				end
			) as junio,
            sum(
                case
				    when v.fecha >= '2026-07-01'
					and  v.fecha <  '2026-08-01'
					then v.valor_venta
					else 0
				end
			) as julio

      from asesores as a

	  inner join ventas as v
	        on a.codigo_asesor = v.codigo_asesor

	 where v.fecha >= '2026-06-01'
	 and   v.fecha <  '2026-08-01'

	  group by a.codigo_asesor,
	           a.nombre,
			   a.ciudad

),

metricas_operacion as (
select fa.codigo_asesor,
       (fa.julio - fa.junio) as diferencia,
	   ((fa.julio - fa.junio)/nullif(fa.junio,0)) * 100 porcen_crecimiento,
	   (fa.junio / nullif(sum(fa.junio) over (
         partition by fa.ciudad),0
	   )) * 100 as porcen_parti_junio,
	   
	   (fa.julio / nullif(sum(fa.julio) over (
         partition by fa.ciudad),0
	   )) * 100 as porcen_parti_julio
from facturado_asesor as fa
)

select fa.ciudad,
       fa.nombre,
	   fa.junio,
	   fa.julio,
	   mo.diferencia,
	   porcen_crecimiento,
	   porcen_parti_junio,
	   porcen_parti_julio,
	   rank() over (
           partition by fa.ciudad
		   order by fa.julio desc
	   ) as ranking_julio,
	   case 
	       when mo.porcen_crecimiento is null then 'no cumple parametros'
	       when mo.porcen_crecimiento > 20 then 'Mejoró'
	       when mo.porcen_crecimiento < -20 then 'Empeoró'
		   else 'Estable'
       end as estado
from facturado_asesor as fa

inner join metricas_operacion as mo
      on fa.codigo_asesor = mo.codigo_asesor

order by fa.ciudad asc,
         ranking_julio asc