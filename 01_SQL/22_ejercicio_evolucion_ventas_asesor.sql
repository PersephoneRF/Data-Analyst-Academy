-- tabla ventas_asesores
| id_venta | id_asesor | fecha      | valor_venta |
| -------: | --------: | ---------- | ----------: |
|        1 |       101 | 2026-06-03 |      400000 |
|        2 |       101 | 2026-06-15 |      300000 |
|        3 |       101 | 2026-07-02 |      500000 |
|        4 |       101 | 2026-07-18 |      400000 |
|        5 |       102 | 2026-06-05 |      800000 |
|        6 |       102 | 2026-06-20 |      200000 |
|        7 |       102 | 2026-07-04 |      600000 |
|        8 |       102 | 2026-07-21 |      300000 |
|        9 |       103 | 2026-06-08 |      300000 |
|       10 |       103 | 2026-06-22 |      200000 |
|       11 |       103 | 2026-07-10 |      250000 |
|       12 |       103 | 2026-07-25 |      150000 |
|       13 |       104 | 2026-06-11 |      500000 |
|       14 |       104 | 2026-07-05 |      900000 |
|       15 |       104 | 2026-07-17 |      300000 |
|       16 |       105 | 2026-06-09 |      700000 |
|       17 |       105 | 2026-06-19 |      100000 |
|       18 |       105 | 2026-07-08 |      600000 |
|       19 |       105 | 2026-07-29 |      500000 |


--tabla asesores

| id_asesor | nombre | ciudad   |
| --------: | ------ | -------- |
|       101 | Carlos | Bogotá   |
|       102 | Laura  | Bogotá   |
|       103 | Miguel | Cali     |
|       104 | Andrea | Cali     |
|       105 | Sofía  | Medellín |


--Requerimiento del director

/* "Quiero comparar las ventas de junio contra julio para cada asesor.

Necesito saber cuánto vendió cada uno en ambos meses, cuánto aumentó o disminuyó su facturación y cuál fue el porcentaje de variación.

Además, quiero clasificar a cada asesor como MEJORÓ, EMPEORÓ o SIN CAMBIO." */

--| Asesor | Ciudad | Junio | Julio | Diferencia | % Variación | Desempeño |
| ------ | ------ | ----: | ----: | ---------: | ----------: | --------- |


with total_facturado_asesor as (
    select va.id_asesor,
           a.nombre,
           a.ciudad,
           sum(
            case 
                WHEN va.fecha >= '2026-06-01' 
                AND  va.fecha < '2026-07-01' 
                THEN va.valor_venta
                ELSE 0 
            END 
           ) as ventas_junio,
           sum(
            case 
                WHEN va.fecha >= '2026-07-01' 
                AND  va.fecha < '2026-08-01' 
                THEN va.valor_venta
                ELSE 0 
            END 
           ) as ventas_julio

    from ventas_asesores as va
    inner join asesores as a
          on va.id_asesor = a.id_asesor
    where va.fecha >= '2026-06-01' 
    and   va.fecha < '2026-08-01'
        
    group by va.id_asesor,
             a.nombre,
             a.ciudad
)


select tfa.nombre,
       tfa.ciudad,
       tfa.ventas_junio,
       tfa.ventas_julio,
       (tfa.ventas_julio - tfa.ventas_junio) as diferencia,
       ((tfa.ventas_julio - tfa.ventas_junio) / nullif(tfa.ventas_junio, 0)) * 100 as porc_crecimiento,
       case 
            when (tfa.ventas_julio - tfa.ventas_junio) > 0 then 'MEJORÓ'
            when (tfa.ventas_julio - tfa.ventas_junio) < 0 then 'EMPEORÓ'
            ELSE 'SIN CAMBIO'
        END AS desempeño
from total_facturado_asesor as tfa
order by porc_crecimiento desc
