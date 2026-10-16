import pandas as pd 

ventas_tipos = pd.DataFrame({
    "producto": ["Laptop", "Mouse", "Teclado", "Monitor"],
    "precio": ["2500000", "80000", "sin dato", "900000"],
    "cantidad": [2, 3, 1, 2]
})


#reto 1 Muestra los tipos de datos con dtypes.
print(ventas_tipos.dtypes)

#2Convierte precio a número usando pd.to_numeric() y errors="coerce".

ventas_tipos["precio"] = pd.to_numeric(ventas_tipos["precio"], errors="coerce")

print(ventas_tipos.dtypes)

# reto 3 muestra las filas que quedaron en NAN 

filas_NaN = ventas_tipos[ventas_tipos["precio"].isna()]
print(filas_NaN)