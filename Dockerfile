# Etapa 1: Construcción del binario
FROM golang:1.22.3-alpine AS build

# Crear directorio de trabajo
WORKDIR /app

# Copiar el resto del código fuente
COPY . .

# Compilar PocketBase personalizado
RUN mkdir -p /pb && go build -o /pb/pocketbase
# Etapa 2: Imagen final optimizada
FROM alpine:latest

# Instalar certificados y utilidades necesarias
RUN apk add --no-cache ca-certificates

# Crear el directorio donde correrá la aplicación
WORKDIR /pb

# Copiar el binario compilado desde la etapa de build
COPY --from=build /pb/pocketbase /pb/pocketbase

# Copiar los datos por defecto a una ubicación temporal
COPY pb_data /pb/default_pb_data

# Copiar el script de inicio y darle permisos de ejecución
COPY entrypoint.sh /pb/entrypoint.sh

RUN chmod +x /pb/entrypoint.sh

# Usar el script de inicio en lugar del CMD original
ENTRYPOINT ["/pb/entrypoint.sh"]

# Exponer el puerto 8080 para la API
EXPOSE 8080

# Ejecutar PocketBase con la API personalizada
# CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]