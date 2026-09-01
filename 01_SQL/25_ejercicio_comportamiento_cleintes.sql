-- tabla movimientos_comerciales


| id_movimiento | codigo_cliente | fecha_movimiento | valor_operacion |
| ------------: | -------------: | ---------------- | --------------: |
|             1 |            301 | 2026-06-03       |          200000 |
|             2 |            301 | 2026-06-15       |          300000 |
|             3 |            301 | 2026-07-05       |          500000 |
|             4 |            301 | 2026-07-18       |          400000 |
|             5 |            302 | 2026-06-04       |          700000 |
|             6 |            302 | 2026-06-20       |          300000 |
|             7 |            302 | 2026-07-07       |          400000 |
|             8 |            302 | 2026-07-21       |          300000 |
|             9 |            303 | 2026-06-08       |          500000 |
|            10 |            303 | 2026-06-22       |          500000 |
|            11 |            303 | 2026-07-10       |          200000 |
|            12 |            304 | 2026-06-05       |          300000 |
|            13 |            304 | 2026-07-03       |          600000 |
|            14 |            304 | 2026-07-20       |          700000 |
|            15 |            305 | 2026-06-10       |          800000 |
|            16 |            305 | 2026-07-09       |          800000 |
|            17 |            305 | 2026-07-23       |          100000 |


--tabla directorio_clientes


| codigo_cliente | nombre_cliente | ciudad   |
| -------------: | -------------- | -------- |
|            301 | Carlos         | Bogotá   |
|            302 | Laura          | Bogotá   |
|            303 | Miguel         | Cali     |
|            304 | Andrea         | Cali     |
|            305 | Sofía          | Medellín |


--Requerimiento

--"Quiero identificar qué clientes están aumentando o reduciendo significativamente su nivel de compras."


--| Ciudad | Cliente | Junio | Julio | Diferencia | % Variación | Comportamiento |
| ------ | ------- | ----: | ----: | ---------: | ----------: | -------------- |


with facturado_cliente as (
    select mc.codigo_cliente,
           dc.nombre_cliente,
           dc.ciudad,
           sum(
            case
                when mc.fecha_movimiento >= '2026-06-01'
                and  mc.fecha_movimiento < '2026-07-01'
                then mc.valor_operacion
                else 0
            end 
           ) ventas_junio,
           sum(
            case
                when mc.fecha_movimiento >= '2026-07-01'
                and  mc.fecha_movimiento < '2026-08-01'
                then mc.valor_operacion
                else 0
            end 
           ) ventas_julio
    from movimientos_comerciales as mc
    inner join directorio_clientes as dc
    on mc.codigo_cliente = dc.codigo_cliente

    where mc.fecha_movimiento >= '2026-06-01'
    and   mc.fecha_movimiento <  '2026-08-01'

    group by mc.codigo_cliente,
             dc.nombre_cliente,
             dc.ciudad
           
),

metricas_variacion as (
    select fc.codigo_cliente,
           ((fc.ventas_julio - fc.ventas_junio) / nullif(fc.ventas_junio,0)) * 100 as porc_variacion,
           (fc.ventas_julio - fc.ventas_junio) as diferencia
    from facturado_cliente as fc

)

select fc.ciudad,
       fc.nombre_cliente as cliente,
       fc.ventas_junio,
       fc.ventas_julio,
       mv.diferencia,
       mv.porc_variacion,
       case 
           when mv.porc_variacion IS NULL then 'SIN CRITERIO'
           when mv.porc_variacion >=  30 then 'AUMENTO'
           when mv.porc_variacion <= -30 then 'DISMINUYÓ'
           ELSE 'ESTABLE'
        end as Comportamiento
           
from facturado_cliente as fc
inner join metricas_variacion as mv
      on fc.codigo_cliente = mv.codigo_cliente

order by fc.ciudad desc,
         mv.porc_variacion desc