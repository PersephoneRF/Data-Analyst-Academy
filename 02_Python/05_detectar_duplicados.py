import pandas as pd

clientes = pd.DataFrame({
    "id_cliente": [101, 102, 103, 101, 104, 102],
    "nombre": ["Carlos", "Ana", "Laura", "Carlos", "Pedro", "Ana"],
    "ciudad": ["Bogotá", "Medellín", "Cali", "Bogotá", "Cali", "Medellín"]
})

#reto 1 Detecta qué filas son duplicadas utilizando:
#reto 2 Muestra solamente las filas duplicadas.
clientes_duplicados = clientes[clientes.duplicated()]

#print(clientes_duplicados)

#reto3 Crea un nuevo DataFrame llamado:
clientes_limpios = clientes.drop_duplicates(keep=False)

#print(clientes_limpios)

#reto 4

clientes_limpios2 = clientes.drop_duplicates(subset=["id_cliente"],
                                            keep="first")

#print(clientes_limpios2)