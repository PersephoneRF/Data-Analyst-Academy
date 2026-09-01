--tabla facturacion_clientes

id_factura | id_cliente | fecha_factura | valor_facturado
1          | 501        | 2026-04-05    | 400000
2          | 501        | 2026-05-07    | 450000
3          | 501        | 2026-06-10    | 430000
4          | 501        | 2026-07-08    | 250000
5          | 502        | 2026-04-03    | 300000
6          | 502        | 2026-05-04    | 350000
7          | 502        | 2026-06-06    | 420000
8          | 502        | 2026-07-05    | 520000
9          | 503        | 2026-04-12    | 700000
10         | 503        | 2026-05-15    | 650000
11         | 503        | 2026-06-11    | 640000
12         | 503        | 2026-07-09    | 630000
13         | 504        | 2026-05-02    | 250000
14         | 504        | 2026-07-04    | 600000
15         | 505        | 2026-04-18    | 500000
16         | 505        | 2026-05-18    | 500000
17         | 505        | 2026-06-18    | 500000
18         | 505        | 2026-07-18    | 500000


--tabla clientes

id_cliente | empresa   | ciudad
501        | TechNova  | Bogotá
502        | DataSoft  | Bogotá
503        | CloudSys  | Cali
504        | MarketPro | Medellín
505        | FinCore   | Cali


--requerimiento 
/* 
Empresa
Ciudad
Mes
Facturación
Mes anterior
    Diferencia
% Variación
Estado */

/* Estado

🔴 EN RIESGO → cayó más del 25% respecto al mes anterior.

🟢 RECUPERACIÓN → aumentó más del 25%.

⚪ ESTABLE → cualquier otro caso.

🔵 SIN HISTORIAL → cuando no exista un mes anterior para comparar. */

with facturado_cliente as (
     select fc.id_cliente,
	        c.empresa,
			c.ciudad,
			sum(fc.valor_facturado) as facturado,
			DATE_TRUNC('month',fc.fecha_factura):: date as fecha_mes_estandar,
			lower(to_char(fc.fecha_factura,'month')) as meses

	from facturacion_clientes as fc
	inner join clientes as c
	      on fc.id_cliente = c.id_cliente

    where fc.fecha_factura >= '2026-04-01'
	and   fc.fecha_factura <  '2026-08-01'


	group by fc.id_cliente,
	         c.empresa,
			 c.ciudad,
			 DATE_TRUNC('month',fc.fecha_factura):: date,
			 LOWER(TO_CHAR(fc.fecha_factura, 'month'))
			 
			 

),


meses_calendario as (
     select '2026-04-01'::date as fecha_mes union all
     select '2026-05-01'::date union all
     select '2026-06-01'::date union all
     select '2026-07-01'::date 
	  
),

matriz_cliente as(
select 
      c.id_cliente,
	  c.empresa,
	  c.ciudad,
	  m.fecha_mes
from clientes as c
cross join meses_calendario as m
),

facturacion_completa as (
  select mc.id_cliente,
	     mc.empresa,
	     mc.ciudad,
	     mc.fecha_mes,
		 lower(to_char(mc.fecha_mes, 'month')) as meses,
		 coalesce(fc.facturado, 0 ) as facturado_t

  from matriz_cliente as mc
  left join facturado_cliente as fc
       on mc.id_cliente = fc.id_cliente
	   and mc.fecha_mes = fc.fecha_mes_estandar

),

mes_anterior as (
  select fc.id_cliente,
         fc.empresa,
		 fc.ciudad,
		 fc.facturado_t,
		 fc.meses,
		 fc.fecha_mes,
		 lag(fc.facturado_t) over (
         partition by fc.id_cliente
		 order by fc.fecha_mes
		 ) as mes_antes
		 

  from facturacion_completa as fc		 

) 


select ma.empresa,
       ma.ciudad,
	   ma.meses,
	   ma.facturado_t,
	   ma.mes_antes,
	   ma.fecha_mes,
	   (ma.facturado_t - ma.mes_antes) as diferencia,
	   ((ma.facturado_t - ma.mes_antes)/ nullif(ma.mes_antes,0)) * 100 as variacion,
	   case 
	       when ma.mes_antes is null then 'mes base'
		   when ma.facturado_t = 0 and ma.mes_antes > 0 then 'riezgo(cliente inactivo)'
	       when ((ma.facturado_t - ma.mes_antes)/ nullif(ma.mes_antes,0)) * 100 > 25 then 'RECUPERACION'
	       when ((ma.facturado_t - ma.mes_antes)/ nullif(ma.mes_antes,0)) * 100 < -25 then 'RIESGO'
		   ELSE 'ESTABLE'
		END AS estado

from mes_anterior as ma

order by ma.empresa asc,
         ma.fecha_mes asc
         
