import pandas as pd

clientes = pd.DataFrame({
    "nombre": [" Carlos ", "ANA", " laura", "Pedro  ","ANA"],
    "ciudad": ["bogota", "BOGOTA", "Bogotá", "medellin","BOGOTA"]
})





# clientes[["nombre","ciudad"]] = clientes[["nombre","ciudad"]].apply(
#     lambda x : x.str.title().str.strip()
# )



# reto 1
#limpia los espacios de nombre.


clientes["nombre"] = clientes["nombre"].str.strip()



#reto 2 deja todos los nombres con formato Nombre (Carlos, Ana, etc.).

clientes["nombre"] = clientes["nombre"].str.title()




# Reto 3: limpia los espacios de ciudad y conviértelas todas a minúsculas.

clientes["ciudad"] = clientes["ciudad"].str.strip().str.lower()






meta_datos = clientes.duplicated(subset=["ciudad"])



borrar_datos = clientes.drop_duplicates(subset=["ciudad"],
                                        keep="first")



print(borrar_datos)
