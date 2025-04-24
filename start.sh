#!/bin/bash

# Variables
MC_VERSION="1.20.1"
JAR_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/103/downloads/paper-${MC_VERSION}-103.jar"
JAR_FILE="paper.jar"

# Descargar servidor si no existe
if [ ! -f "$JAR_FILE" ]; then
    echo "Descargando servidor de Minecraft..."
    curl -o $JAR_FILE -L $JAR_URL
fi

# Aceptar EULA
echo "eula=true" > eula.txt

# Iniciar ngrok con authtoken
echo "Iniciando ngrok..."
ngrok config add-authtoken 2jyLerkSdBxERZiDDQto9fpAfUa_2kcvKmFM9Qa5PtKj84RGN

# Ejecutar ngrok en background y guardar PID
nohup ngrok tcp 25565 > ngrok.out &

# Esperar a que ngrok genere la URL
sleep 5

# Mostrar dirección ngrok
echo "🔌 Dirección pública de tu servidor (copia y pega en Minecraft):"
grep -oE "tcp://[0-9a-zA-Z\.]+:[0-9]+" ngrok.out

# Iniciar servidor Minecraft
java -Xmx2G -Xms1G -jar $JAR_FILE nogui
