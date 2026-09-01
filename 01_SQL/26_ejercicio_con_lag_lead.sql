-- tabla ventas_mensuales

| mes        | codigo_asesor | ciudad | total_ventas |
| ---------- | ------------: | ------ | -----------: |
| 2026-04-01 |           101 | Bogotá |       800000 |
| 2026-05-01 |           101 | Bogotá |       950000 |
| 2026-06-01 |           101 | Bogotá |      1100000 |
| 2026-07-01 |           101 | Bogotá |      1250000 |
| 2026-04-01 |           102 | Bogotá |       700000 |
| 2026-05-01 |           102 | Bogotá |       750000 |
| 2026-06-01 |           102 | Bogotá |       720000 |
| 2026-07-01 |           102 | Bogotá |       900000 |
| 2026-04-01 |           103 | Cali   |       600000 |
| 2026-05-01 |           103 | Cali   |       650000 |
| 2026-06-01 |           103 | Cali   |       800000 |
| 2026-07-01 |           103 | Cali   |       700000 |


--tabla asesores

| codigo_asesor | nombre | ciudad |
| ------------: | ------ | ------ |
|           101 | Carlos | Bogotá |
|           102 | Laura  | Bogotá |
|           103 | Andrés | Cali   |


--requerimiento
/* 
ciudad
asesor
mes
ventas
ventas_mes_anterior
diferencia
porcentaje_crecimiento
comportamient */

/* Donde comportamiento será:

CRECIÓ → crecimiento positivo.
DISMINUYÓ → crecimiento negativo.
SIN CAMBIO → 0%. */


with facturado_asesor as (
    select vm.codigo_asesor,
           a.nombre,
           a.ciudad,
           vm.mes,
           case  
               when vm.mes >= '2026-04-01' and vm.mes < '2026-05-01'
               then 'abril'
               when vm.mes >= '2026-05-01' and vm.mes < '2026-06-01'
               then 'mayo'
               when vm.mes >= '2026-06-01' and vm.mes < '2026-07-01'
               then 'junio'
               when vm.mes >= '2026-07-01' and vm.mes < '2026-08-01'
               then 'julio'
               else 'otro mes'
            end as meses ,
            sum(vm.total_ventas) as total_facturado
    from ventas_mensuales as vm
    inner join asesores as a
          on vm.codigo_asesor = a.codigo_asesor

    where vm.mes >= '2026-04-01' and 
          vm.mes < '2026-08-01'

               

    group by 
           vm.codigo_asesor,
           a.nombre,
           a.ciudad,
           vm.mes,
           case 
               when vm.mes >= '2026-04-01' and vm.mes < '2026-05-01'
               then 'abril'
               when vm.mes >= '2026-05-01' and vm.mes < '2026-06-01'
               then 'mayo'
               when vm.mes >= '2026-06-01' and vm.mes < '2026-07-01'
               then 'junio'
               when vm.mes >= '2026-07-01' and vm.mes < '2026-08-01'
               then 'julio'
               else 'otro mes'
        END
),

ventas_mes_anterior as (
      select fa.codigo_asesor,
             fa.nombre,
             fa.total_facturado,
             fa.ciudad,
             fa.meses,
             fa.mes,
             lag(fa.total_facturado) over (
                  partition by fa.codigo_asesor
                  order by fa.mes) as mes_anterior
      from facturado_asesor as fa
      


),

crecimiento as (
      select vma.codigo_asesor,
             vma.meses,
             vma.total_facturado,
             vma.mes_anterior,
             ((vma.total_facturado - vma.mes_anterior)
                   / nullif(vma.mes_anterior, 0))
                   * 100 as porcentaje_crecimiento
      from ventas_mes_anterior as vma
      
)

select vma.ciudad ,
       vma.nombre as asesor,
       vma.meses,
       vma.total_facturado,
       vma.mes_anterior,
       (vma.total_facturado - vma.mes_anterior) as diferencia,
       c.porcentaje_crecimiento,
      case 
          when c.porcentaje_crecimiento > 0 then 'crecimiento positivo'
          when c.porcentaje_crecimiento < 0 then 'crecimiento negativo'
          else 'sin cambio'
      end as comportamiento 

from ventas_mes_anterior as vma
inner join crecimiento as c
      on vma.codigo_asesor = c.codigo_asesor
      and vma.meses = c.meses

order by vma.ciudad desc,
         c.porcentaje_crecimiento desc
           

 


       