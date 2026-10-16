import pandas as pd

ventas_fechas = pd.DataFrame({
    "pedido": [1, 2, 3, 4],
    "fecha": ["09/10/2026", "15/10/2026", "fecha inválida", "21/10/2026"],
    "valor": [100000, 250000, 150000, 300000]
})

#print(ventas_fechas.dtypes)
#print(ventas_fechas)
ventas_fechas["fecha"] = pd.to_datetime(
    ventas_fechas["fecha"],
    format="%d/%m/%Y",
    errors="coerce"
)

#print(ventas_fechas)

fechas_invalidas = ventas_fechas[ventas_fechas["fecha"].isna()]


ventas_fechas["fecha"] = ventas_fechas["fecha"].fillna("2026-6-18")

ventas_fechas["mes"] = ventas_fechas["fecha"].dt.month

organizados = ventas_fechas.sort_values(["fecha"], ascending=False)

#print(organizados)

pedidos = pd.DataFrame({
    "id_pedido": [101, 102, 103, 104, 105],
    "fecha": [
        "05/10/2026",
        "12/10/2026",
        "fecha pendiente",
        "21/10/2026",
        "31/10/2026"
    ],
    "valor": [120000, 250000, 80000, 320000, 150000]
})

#reto 1 Inspeccionar los tipos de datos

print(pedidos.dtypes)

#reto2 Convertir la columna fecha

pedidos["fecha"] = pd.to_datetime(pedidos["fecha"],
                                  format="%d/%m/%Y",
                                  errors="coerce")

# reto 3 Encontrar las fechas inválidas
fechas_erradas = pedidos[pedidos["fecha"].isna()]

print(fechas_erradas)

# reto 4  Extraer el mes

pedidos["mes"] = pedidos["fecha"].dt.month

print(pedidos)