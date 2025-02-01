# Usar una imagen base con curl, jq y bash
FROM alpine:latest

# Instalar curl, jq y bash
RUN apk add --no-cache curl jq bash

# Copiar el script al contenedor
COPY ./API-Client/script.sh /script.sh

# Hacer el script ejecutable
RUN chmod +x /script.sh

# Usar bash como shell por defecto
SHELL ["/bin/bash", "-c"]

# Comando para ejecutar el script
CMD ["/bin/bash", "/script.sh"]
