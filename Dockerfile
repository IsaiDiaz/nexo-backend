FROM alpine:latest

# Instalar certificados necesarios para conexiones HTTPS
RUN apk add --no-cache ca-certificates

# Crear directorio de trabajo
WORKDIR /pb

# Copiar el binario precompilado de PocketBase
COPY pocketbase /pb/pocketbase

# Copiar datos por defecto y script de arranque
COPY pb_data /pb/default_pb_data
COPY entrypoint.sh /pb/entrypoint.sh

# Dar permisos de ejecución al binario y al script
RUN chmod +x /pb/pocketbase /pb/entrypoint.sh

# Puerto expuesto por PocketBase
EXPOSE 8080

# Comando de inicio
ENTRYPOINT ["/pb/entrypoint.sh"]