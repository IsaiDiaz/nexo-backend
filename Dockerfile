FROM alpine:latest

# Instalar certificados necesarios para conexiones HTTPS
RUN apk add --no-cache ca-certificates

# Crear directorio de trabajo
WORKDIR /pb

# Copiar binario precompilado
COPY pocketbase /pb/pocketbase

# Copiar datos por defecto y script de entrada
COPY pb_data /pb/default_pb_data
COPY pb_migrations /pb/pb_migrations
COPY entrypoint.sh /pb/entrypoint.sh

# Dar permisos de ejecución
RUN chmod +x /pb/pocketbase /pb/entrypoint.sh

# Exponer el puerto por defecto de PocketBase
EXPOSE 8080

# Script de entrada
ENTRYPOINT ["/pb/entrypoint.sh"]