-- tabla consultas 

| id_consulta | id_paciente | id_medico | valor_consulta |
| ----------: | ----------: | --------: | -------------: |
|           1 |         301 |         1 |         180000 |
|           2 |         302 |         2 |         250000 |
|           3 |         301 |         1 |         220000 |
|           4 |         303 |         3 |         150000 |
|           5 |         304 |         2 |         300000 |
|           6 |         305 |         1 |         450000 |
|           7 |         304 |         2 |         200000 |
|           8 |         305 |         3 |         120000 |
|           9 |         302 |         2 |         180000 |
|          10 |         301 |         3 |         100000 |


-- tabla pacientes 
| id_paciente | nombre | ciudad   |
| ----------: | ------ | -------- |
|         301 | Carlos | Bogotá   |
|         302 | Laura  | Bogotá   |
|         303 | Miguel | Cali     |
|         304 | Andrea | Medellín |
|         305 | Sofía  | Cali     |


--tabla medicos


| id_medico | nombre     | especialidad |
| --------: | ---------- | ------------ |
|         1 | Dr. Gómez  | Cardiología  |
|         2 | Dra. Ruiz  | Pediatría    |
|         3 | Dr. Torres | Neurología   |


--REQUERIMIENTO
-- El director quiere un reporte con las siguientes columnas:

| Especialidad | Paciente | Ciudad | Total facturado | Ranking especialidad | Categoría |
| ------------ | -------- | ------ | --------------: | -------------------: | --------- |


with ranking_pacientes as (
    select c.id_paciente,
           m.especialidad,
           sum(c.valor_consulta) as total_facturado,
           rank() over (
                  partition by m.especialidad
                  order by sum(c.valor_consulta) desc
           ) as ranking_especialidad
           from consultas as c
           inner join medicos as m
           on       c.id_medico = m.id_medico
           group by c.id_paciente,
                    m.especialidad
                   

)

select rp.especialidad,
       pa.nombre as paciente,
       pa.ciudad,
       rp.total_facturado,
       rp.ranking_especialidad,
       case  
            when rp.total_facturado > 500000 then 'PACIENTE PREMIUM'
            when rp.total_facturado >= 300000 then 'PACIENTE FRECUENTE'
            else 'PACIENTE OCASIONAL'
        END AS categoria

from ranking_pacientes as rp
inner join pacientes as pa
on rp.id_paciente = pa.id_paciente
order by rp.especialidad asc, rp.ranking_especialidad asc;
