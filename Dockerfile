# Utiliza una imagen base con una versión específica y estable de Python.
# Python 3.11 es compatible con la mayoría de las versiones recientes.
FROM python:3.11-slim-bookworm
 
# Establece el directorio de trabajo en el contenedor
WORKDIR /app
 
# Copia los archivos de configuración antes de la instalación de dependencias, si se necesitan.
COPY config.json ./
COPY pipeline/prod_config.json ./pipeline/
 
# Copia el archivo de requisitos.
COPY requirements.txt ./
 
# Instala las dependencias de Python.
# Se actualiza pip primero para asegurar una versión reciente que maneje bien las dependencias.
# Se usa --no-cache-dir para reducir el tamaño de la imagen final.
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
 
# Copia el resto de tu código fuente al directorio de trabajo
COPY . .
 
# Opcional: Define una variable de entorno para el PATH si tus scripts la necesitan
# ENV PATH="/usr/local/bin:${PATH}"
 
# Opcional: Si tu aplicación Cloud Run va a ejecutar Flask/Gunicorn al iniciar,
# puedes definir un CMD o ENTRYPOINT aquí. Si solo es para ejecutar el pipeline vía Cloud Build, no es estrictamente necesario.
# CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"] # Ejemplo si tu app es una API Flask

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


