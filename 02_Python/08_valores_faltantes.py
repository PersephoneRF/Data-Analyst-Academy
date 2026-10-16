import pandas as pd

pedidos = pd.DataFrame({
    "cliente": ["Ana", "Carlos", "Laura", "Pedro", "Sofía"],
    "ciudad": ["Bogotá", None, "Cali", "Medellín", None],
    "valor": [150000, 200000, None, 180000, 250000]
})

#print(pedidos)

#reto 1
pedidos_errados= pedidos.isna().sum()

#print(pedidos_errados)

# reto2 Reemplaza los valores faltantes de ciudad por 'Sin registrar'.

pedidos["ciudad"] = pedidos["ciudad"].fillna('Sin registrar')

#print(pedidos)

# reto 3 Crea pedidos_validos con las filas donde valor no sea faltante, usando dropna y subset.

pedidos_validos = pedidos.dropna(subset=["valor"])

print(pedidos_validos)