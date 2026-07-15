import sys

# version de python activa
print("==validacion de entorno de trabajao")
print(f"version de python en uso: {sys.version}\n")

#importar  librerias 

try:    
    print("Cargando librerias...")
    import pandas as pd
    import numpy as np
    import matplotlib as mpl
    import openpyxl

#exito de  las versiones detalladas
    print("\n ¡exito!")
    print(f"• pandas v{pd.__version__}")
    print(f"• numpy v{np.__version__}")
    print(f"• matplotlib v{mpl.__version__}")
    print(f"• openpyxl v{openpyxl.__version__}")
    
except ImportError as e:
    print(f"\n error: no se puede cargar alguna librería")
    print(f"Detalle del error {e}")
    print(f"Pista asegurate de tener activo tu entorno virtual (.venv) e instalado el paquete ")

