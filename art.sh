#!/bin/bash

# Pide al usuario que escriba "ya" para continuar
read -p "Para poder ver el arte debe solatr un benito a la de ya! Nocheto, es tan fácil como desplegar la pantalla completa, escribir 'ya' y presionar Enter: " respuesta

# Convierte la respuesta a minúsculas por si el usuario tiene el bloq. mayus activado
respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

# Comprueba si la respuesta es "ya" y ejecuta el segundo script si es así
if [[ "$respuesta" == "ya" ]]; then
    # Ejecuta el segundo script que muestra un hasbulla jejeje
    chmod +x hasbulla.sh
    ./hasbulla.sh
else
    echo "Debes escribir 'ya' para continuar. ¡Inténtalo nuevamente! :)"
fi