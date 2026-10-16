import pandas as pd




ventas = [
    {"cliente": "Carlos", "producto": "Laptop", "cantidad": 2, "precio": 2500000},
    {"cliente": "Ana", "producto": "Mouse", "cantidad": 3, "precio": 80000},
    {"cliente": "Pedro", "producto": "Teclado", "cantidad": 1, "precio": 150000},
    {"cliente": "Laura", "producto": "Laptop", "cantidad": 1, "precio": 2500000}
]


df = pd.DataFrame(ventas)
# print(df.describe())
#print(df.unique())
#print(df)
#print(df.info())
#print(df['producto'].unique())
#print(df.iloc[0])
#print(df.groupby("producto")["precio"].mean())

#imaginemos que queremos calcular la cantidad de articulos vendidos y ademas las ganancias de las ventas de eos articulos

# df["total_ventas"] = df["cantidad"] * df["precio"]


# resumen = df.groupby("producto").agg(
#     numero_ventas = ("cliente","count"),
#     unidades_vendidas = ("cantidad","sum"),
#     ingresos_totales = ("total_ventas","sum")

# )

# resumen.loc["total"] = resumen.sum()
# print(resumen)


# print(df.loc[0:2,["cliente","producto"]])

#print(df.iloc[0:2,0:2])

#Reto 1 Utiliza loc para obtener únicamente el nombre y el producto de Pedro

# print(df.loc[2,["cliente","producto"]])

# #reto 2 Utiliza iloc para mostrar las primeras tres filas, pero solamente las columnas cliente y cantidad.

# print(df.iloc[0:3,[0,2]])

# # reto 3 Utiliza loc para mostrar todas las columnas correspondientes a Laura.
# print(df.loc[3, :])


# filtro = (
#     (df["producto"] == "Laptop") &
#     (df["cantidad"] > 1)
# )
# print(df[filtro])

# mascara =(
#     df.loc[
#         df["cantidad"] > 1 ,
#         ["cliente", "cantidad"]
#     ]
# )

# print(mascara)

# maria = df[df["producto"].isin(["Mouse","Teclado"])]

# mascara = (
#     df.loc[
#         (df["cantidad"] > 1) &(
#         df["precio"] > 2000000),
#         ["cliente","producto"]
#     ]
# )

# print(mascara)
#punto 1
resumen = (
    df.loc[
        df["precio"] >= 150000
])

#print(resumen)

#punto 2

ventas_lap = (
    df.loc[
        (df["producto"] == "Laptop") & (df["cantidad"] == 1),
        ["cliente","producto","cantidad"]
    ]
)

#print(ventas_lap)

#punto 3

ventas = df[df["producto"].isin(["Laptop","Mouse"])]

#print(ventas)

## ordenar datos

# ordenanza = df.sort_values(["cantidad","precio"], ascending=[True, False])

# print(ordenanza)

#reto 1

# ejercicio_1 = df.sort_values("precio", ascending=False)
# #print(ejercicio_1)

# ejercicio_2 = df.sort_values("cantidad", ascending=True)
# #print(ejercicio_2)

# ejercicio_3 = df.sort_values(["producto","precio"], ascending=[True,False])
# print(ejercicio_3)

