# Utiliza una imagen base con una versión específica y estable de Python.
FROM python:3.9-slim-bookworm
 
# Permitir que los mensajes de log aparezcan inmediatamente en los logs de Knative/Cloud Run
ENV PYTHONUNBUFFERED True
 
# Establece el directorio de trabajo en el contenedor
WORKDIR /app
 
# Copia los archivos de configuración (si están en la raíz del contexto de build)
COPY config.json ./
COPY pipeline/prod_config.json ./pipeline/
 
# Copia el archivo de requisitos.
COPY requirements.txt ./
 
# Instala las dependencias de Python.
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
 
# Copia el resto de tu código fuente al directorio de trabajo.
# Esto incluye tu app.py y el directorio pipeline/
COPY . .
 
# Expone el puerto que usará Gunicorn/Flask
EXPOSE 8080
 
# Define la variable de entorno PORT para Cloud Run
ENV PORT 8080
 
# Comando para ejecutar la aplicación Flask/Gunicorn al iniciar el contenedor.
# Cloud Run usará este CMD por defecto.
# Apunta a tu archivo 'app.py' y a la instancia de Flask 'app' dentro de él.
CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 app:app

#########################################################
####################### OPCION 2 ########################
#########################################################
#FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:455.0.0-slim

## Allow statements and log messages to immediately appear in the Knative logs
#ENV PYTHONUNBUFFERED True

## Copy local code to the container image.
#WORKDIR /app
#COPY . .

## Install production dependencies.
#RUN pip install --upgrade pip

## Install production dependencies.
#RUN pip install -r requirements.txt

## Service must listen to $PORT environment variable.
## This default value facilitates local development.
#ENV PORT 8080

## Run the web service on container startup. Here we use the gunicorn
#CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 app:app


#########################################################
####################### OPCION 1 ########################
#########################################################


#FROM python:3.10-slim

#WORKDIR /app

#COPY . .

## ← Instalar compiladores para pyfarmhash
#RUN apt-get update && apt-get install -y gcc g++ build-essential

#RUN pip install --no-cache-dir -r requirements.txt

#CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]


