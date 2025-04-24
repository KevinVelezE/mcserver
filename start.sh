#!/bin/bash

# Variables
MC_VERSION="1.20.1"
JAR_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/103/downloads/paper-${MC_VERSION}-103.jar"
JAR_FILE="paper.jar"

# Descargar el servidor si no existe
if [ ! -f "$JAR_FILE" ]; then
    echo "Descargando servidor de Minecraft..."
    curl -o $JAR_FILE -L $JAR_URL
fi

# Aceptar EULA automáticamente
echo "eula=true" > eula.txt

# Ejecutar el servidor
java -Xmx2G -Xms1G -jar $JAR_FILE nogui
