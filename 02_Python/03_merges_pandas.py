import pandas as pd

pedidos = pd.DataFrame({
    "id_pedido": [1, 2, 3, 4, 5],
    "id_cliente": [101, 102, 101, 104, 103],
    "producto": ["Laptop", "Mouse", "Teclado", "Monitor", "Laptop"],
    "valor": [2500000, 80000, 150000, 900000, 2500000]
})

clientes_nuevos = pd.DataFrame({
    "id_cliente": [101, 102, 103],
    "nombre": ["Carlos", "Ana", "Laura"]
})

#reto 1

datos_combinados = pedidos.merge(clientes_nuevos,on="id_cliente",how="inner") 

#reto 2

conser_ped = pedidos.merge(clientes_nuevos,on="id_cliente", how="left")

#print(conser_ped)

######################################################################

#reto 1
print(conser_ped[conser_ped["nombre"].isna()])

# reto 2

print(conser_ped["nombre"].isna().sum())
# reto 3 
fix_conser_ped = conser_ped["nombre"] = conser_ped["nombre"].fillna("Cliente desconocido")

print(conser_ped)




