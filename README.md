# docker-otel-example

Paso 1, clona el repositorio
````bash
git clone
````

Paso 2, asigna el token de Splunk o11y a la variable de entorno en memoria
````bash
export SPLUNK_ACCESS_TOKEN=<token>
````

Paso 2, levanta los contenedores
````bash
docker compose up -d
````

Si hicistes los pasos bien, ya deberías de estar recibiendo metricas y trazas en tu tenant de Splunk o11y.

![image](https://github.com/user-attachments/assets/6a066ad2-a693-4b52-a3c8-00c6424a2591)
