import pandas as pd

ventas = pd.DataFrame({
    "fecha": ["13/10/2026", "14/10/2026", "15/10/2026", "16/10/2026", "17/10/2026"],
    "ciudad": ["Bogotá", None, None, "Cali", None],
    "ingresos": [200000, 150000, 300000, 250000, 180000]
})


#print(ventas)

ventas["ciudad"] = ventas["ciudad"].bfill()

#print(ventas)


inventario = pd.DataFrame({
    "producto": ["Laptop", None, None, "Mouse", None, "Teclado"],
    "stock": [10, 10, 8, 20, 20, 15]
})


#print(inventario)

# reto 1 Crea inventario_ffill aplicando ffill() únicamente a la columna producto.

inventario_ffill = inventario["producto"].ffill()

#print(inventario_ffill)

#reto 2 Crea inventario_bfill aplicando bfill() únicamente a la columna producto

inventario_bfill = inventario["producto"].bfill()

print(inventario_bfill)