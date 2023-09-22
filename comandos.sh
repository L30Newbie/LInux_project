#!/bin/bash

# Función para manejar la señal SIGINT (Ctrl+C)
interrumpir() {
    echo "Presione 'salir' para salir del programa."
}

# Función para manejar la señal SIGTSTP (Ctrl+Z)
suspender() {
    echo "El programa no puede ser suspendido. Presione 'salir' para salir del programa."
}

# Configurar manejo de señales
trap 'interrumpir' SIGINT
trap 'suspender' SIGTSTP

# Bucle do-while
while true; do
    usuario=$(whoami)
    ruta_actual=$(pwd)

    # Definir colores ANSI
    color_usuario="\e[1;33m"  # Amarillo brillante
    color_ruta="\e[1;34m"      # Azul brillante
    color_reset="\e[0m"        # Restablecer el color
    flechita='\e[1;31m'

    # Mostrar el prompt simulado con colores y flecha
    echo -ne "${color_usuario}$usuario@$(hostname):${color_ruta}$ruta_actual${flechita} > ${color_reset}"

    read -p "" opcion

    # Utilizar un caso (case) para manejar las opciones
    case "$opcion" in
        "art")
            # Ejecutar art.sh
            ./art.sh
            ;;
        "infosis")
            # Ejecutar infosis.sh
            ./infosis.sh
            ;;
        "who")
            # Ejecutar who.sh
            ./who.sh
            ;;
        "juego")
            # Ejecutar juego.sh
            ./juego.sh
            ;;
        "music")
            # Ejecutar music.sh
            ./music.sh
            ;;
        "time")
            # Ejecutar time.sh
            ./time.sh
            ;;
        "ayuda")
            # Ejecutar ayuda.txt
            cat ayuda.txt
            ;;
        "find")
            # Ejecutar find.sh
            ./find.sh
            ;;
        "salir")
            # Salir del bucle si el usuario ingresa "salir"
            break
            ;;
        *)
            # Si la opción no está en el menú, intentar ejecutarla como comando del sistema
            $opcion
            ;;
    esac
done

# Mensaje de salida al final del script
echo "El programa ha finalizado."
