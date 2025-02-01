# Usa la imagen base de Python 3.9
FROM python:3.9

# Establece el directorio de trabajo en el contenedor
WORKDIR /app/automatic

# Copia los archivos del proyecto (opcional, ya que montas un volumen)
COPY ./python/automatic /app/automatic

# Actualiza pip e instala dependencias
RUN pip install --upgrade pip && \
    pip install -r /app/automatic/requirements.txt

# Expone el puerto 5000
EXPOSE 5000

# Comando por defecto al ejecutar el contenedor
#CMD splunk-py-trace-bootstrap && splunk-py-trace flask run --host=0.0.0.0
