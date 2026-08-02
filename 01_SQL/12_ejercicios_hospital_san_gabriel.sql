    -- tabla consultas

    | id_consulta | fecha      | id_medico | id_paciente | costo_consulta |
| ----------: | ---------- | --------: | ----------: | -------------: |
|           1 | 2026-08-01 |       201 |         501 |            120 |
|           2 | 2026-08-01 |       202 |         502 |            180 |
|           3 | 2026-08-02 |       201 |         503 |            250 |
|           4 | 2026-08-02 |       203 |         504 |             90 |
|           5 | 2026-08-03 |       202 |         505 |            200 |
|           6 | 2026-08-03 |       201 |         506 |            150 |
|           7 | 2026-08-04 |       203 |         507 |            100 |
|           8 | 2026-08-04 |       202 |         508 |            300 |


--tabla medicos 

| id_medico | nombre      | especialidad |
| --------: | ----------- | ------------ |
|       201 | Laura Gómez | Cardiología  |
|       202 | Juan Pérez  | Neurología   |
|       203 | Andrés Ruiz | Pediatría    |


--tabla pacientes 

| id_paciente | nombre    | ciudad       |
| ----------: | --------- | ------------ |
|         501 | Camila    | Bogotá       |
|         502 | Mateo     | Cali         |
|         503 | Sofía     | Bogotá       |
|         504 | Samuel    | Medellín     |
|         505 | Valentina | Bogotá       |
|         506 | Juliana   | Cali         |
|         507 | Tomás     | Bogotá       |
|         508 | Isabella  | Barranquilla |

-- requirimiento

/* El Director Médico necesita un reporte.

Debe mostrar:

Nombre del médico.
Especialidad.
Total facturado.
Categoría.

Las categorías son:

Más de 500 → Médico Estrella
Entre 300 y 500 → Médico Destacado
Menos de 300 → Médico Regular

Debe ordenarse desde el médico con mayor facturación hasta el menor. */

with total_facturado_X_medico as (
    select id_medico,
           sum(costo_consulta) as total_facturado
    from consultas
    group by id_medico
)


select m.nombre,
       m.especialidad,
       tfxm.total_facturado as total_facturado_por_medico,
       case
           when tfxm.total_facturado > 500 then 'MEDICO ESTRELLA'
           when tfxm.total_facturado >= 300 then 'MEDICO DESTACADO'
           ELSE 'MEDICO REGULAR'
        END AS categoria
from medicos as m
inner join total_facturado_X_medico as tfxm
on m.id_medico = tfxm.id_medico

order by total_facturado_por_medico desc;