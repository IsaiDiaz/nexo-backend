#!/bin/sh

# Crear el directorio si no existe
mkdir -p /pb/pb_data

# Verificar si el directorio /pb/pb_data tiene archivos válidos
# Excluimos "lost+found" y archivos con extensión .db
VALID_FILES=$(find /pb/pb_data -mindepth 1 -not -name 'lost+found' -not -name '*.db' | wc -l)

if [ "$VALID_FILES" -eq 0 ]; then
    echo "📂 Volumen vacío o solo con archivos no válidos. Copiando datos por defecto..."
    cp -R /pb/default_pb_data/* /pb/pb_data/
else
    echo "✅ Datos existentes encontrados, saltando inicialización."
fi

# Ejecutar PocketBase
exec /pb/pocketbase serve --http=0.0.0.0:8080