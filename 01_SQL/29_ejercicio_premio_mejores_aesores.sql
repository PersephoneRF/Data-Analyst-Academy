--dartos filtrados

| Asesor | Ciudad |      Julio | Crecimiento | Participación | Ranking |
| ------ | ------ | ---------: | ----------: | ------------: | ------: |
| Andrea | Bogotá | $1.250.000 |         +5% |           48% |       1 |
| Carlos | Bogotá |   $900.000 |        +60% |           35% |       2 |
| Felipe | Bogotá |   $450.000 |        -10% |           17% |       3 |
| Laura  | Cali   | $1.300.000 |         +2% |           55% |       1 |
| Andrés | Cali   |   $800.000 |        +35% |           34% |       2 |
| Diana  | Cali   |   $250.000 |         -5% |           11% |       3 |


select df.id_asesor,
       df.nombre,
	   df.ciudad,
	   df,facturacion_julio,
	   df.crecimiento,
	   df.partipacion,
	   df.ranking_julio,
	   case
	       when df.ranking_julio <= 2
		   and  df.crecimiento > 30
		   then 'top 2 + alto crecimiento'
		   when df.ranking_julio <= 2
		   then 'top 2'
		   when df.crecimiento > 30
		   then 'alto crecimiento'
		   else 'normal'
	   end as categoria_desempenio

from datos_filtrados as df
order by df.ciudad asc,
         df.ranking_julio asc