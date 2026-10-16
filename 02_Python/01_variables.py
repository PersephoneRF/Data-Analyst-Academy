ventas = [
    {"cliente": "Carlos", "producto": "Laptop", "cantidad": 2, "precio": 2500000},
    {"cliente": "Ana", "producto": "Mouse", "cantidad": 3, "precio": 80000},
    {"cliente": "Pedro", "producto": "Teclado", "cantidad": 1, "precio": 150000},
    {"cliente": "Laura", "producto": "Laptop", "cantidad": 1, "precio": 2500000},
]
venta_mayor = 0
cliente_mayor = ''
ventas_totales = 0


for venta in ventas:
    total = venta['cantidad'] * venta['precio']
    ventas_totales += total
    print(venta['cliente'], total)

    if total > venta_mayor:
        venta_mayor = total
        cliente_mayor = venta["cliente"]
print(f"la venta de mayor valor corresponde a {venta_mayor} y corresponde a {cliente_mayor}")
print(f"el valor total de las ventas fue {ventas_totales}")

    
