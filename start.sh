#!/bin/bash

# Variables
MC_VERSION="1.21.5"
JAR_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/103/downloads/paper-${MC_VERSION}-103.jar"
JAR_FILE="paper.jar"

# Descargar servidor si no existe
if [ ! -f "$JAR_FILE" ]; then
    echo "Descargando servidor de Minecraft..."
    curl -o $JAR_FILE -L $JAR_URL
fi

# Aceptar EULA
echo "eula=true" > eula.txt

# Inicia ngrok en segundo plano
echo "Iniciando ngrok..."
ngrok config add-authtoken 2jyLerkSdBxERZiDDQto9fpAfUa_2kcvKmFM9Qa5PtKj84RGN
nohup ngrok tcp 25565 --log=stdout > ngrok.log &

# Esperar unos segundos para que ngrok levante
sleep 5

# Mostrar dirección de ngrok
echo "Dirección ngrok (puerto TCP):"
grep -oE "tcp://[0-9a-zA-Z\.]+:[0-9]+" ngrok.log

# Ejecutar servidor
java -Xmx2G -Xms1G -jar $JAR_FILE nogui
