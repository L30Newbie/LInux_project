#!/bin/bash

# Guardar el valor actual de TZ
OLD_TZ=$TZ

# Configurar la zona horaria a UTC (o la que prefieras)
TZ=UTC

# Obtener la fecha actual en la zona horaria configurada
fecha_actual=$(date +"%Y-%m-%d")

# Preguntar si se quiere saber la fecha
read -p "¿Quieres saber la fecha? (si/no): " respuesta

# Verificar si la respuesta es "no"
if [[ "$respuesta" == "no" ]]; then
    echo "eres bien rarite... :/"
    exit 0
fi

# Obtener la hora actual en la zona horaria configurada
hora_actual=$(date +"%H:%M:%S")

# Preguntar si se quiere saber más
read -p "¿Neta? (si/no): " respuesta2

# Verificar si la respuesta es "no"
if [[ "$respuesta2" == "no" ]]; then
    echo "eres bien rarite... :/"
    exit 0
fi

# Obtener los minutos actuales
minutos_actuales=$(date +"%M")

# Restaurar la zona horaria original
TZ=$OLD_TZ

# Mostrar la fecha
echo "Fecha: $fecha_actual"

# Mostrar la hora
echo "Hora: $hora_actual"

echo "Ya comprate un reloj, manit@..."