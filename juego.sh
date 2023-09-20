#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Función para mostrar el ahorcado
function mostrar_ahorcado {
    caso_ahorcado=$1
    clear
    echo -e "${BLUE}Ahorcado:${NC}"
    case $caso_ahorcado in
        0)
            echo "  ___________"
            echo "  |         |"
            echo "            |"
            echo "            |"
            echo "            |"
            echo "            |"
            echo "            |"
            ;;
        1)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo "            |"
            echo "            |"
            echo "            |"
            echo "            |"
            ;;
        2)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo "  |         |"
            echo "            |"
            echo "            |"
            echo "            |"
            ;;
        3)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo " /|         |"
            echo "            |"
            echo "            |"
            echo "            |"
            ;;
        4)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo " /|\\        |"
            echo "            |"
            echo "            |"
            echo "            |"
            ;;
        5)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo " /|\\        |"
            echo " /          |"
            echo "            |"
            echo "            |"
            ;;
        6)
            echo "  ___________"
            echo "  |         |"
            echo "  O         |"
            echo " /|\\        |"
            echo " / \\        |"
            echo "            |"
            echo "            |"
            ;;
    esac
}

# Función para seleccionar una palabra aleatoriamente de una categoría
function seleccionar_palabra {
    categoria=$1
    case $categoria in
        "frutas_y_verduras")
            palabras=("manzana" "platano" "zanahoria" "sandía" "uva" "naranja" "melon" "fresa" "mango")
            ;;
        "paises_y_capitales")
            palabras=("españa:madrid" "francia:parís" "italia:roma" "méxico:ciudad de méxico" "alemania:berlín")
            ;;
        "canciones_de_jose_jose")
            palabras=("el triste" "40 y 20" "amar y querer" "al amanecer" "mi vida" "la nave del olvido" "una mañana" "almohada" "no me digas que te vas" "volcan" "preso")
            ;;
        "peliculas_famosas")
            palabras=("titanic" "star wars" "avatar" "matrix" "forrest gump" "parasitos" "toy story" "el viaje de chihiro" "el laberinto del fauno" "el padrino" "jurassic park" "john wick")
            ;;
    esac
    palabra=${palabras[RANDOM % ${#palabras[@]}]}
    IFS=':' read -ra partes <<< "$palabra"
    palabra=${partes[0]}
    espacios=$(echo "$palabra" | sed 's/./_/g')
}

# Función principal del juego
function juego {
    clear
    echo -e "${GREEN}¡Bienvenido al Juego del Ahorcado!${NC}"
    echo -e "${YELLOW}Selecciona una categoría:${NC}"
    echo "1) Frutas y Verduras"
    echo "2) Países y Capitales"
    echo "3) Canciones de José José"
    echo "4) Películas Famosas"

    read -p "Ingresa el número de la categoría: " categoria

    case $categoria in
        1)
            seleccionar_palabra "frutas_y_verduras"
            ;;
        2)
            seleccionar_palabra "paises_y_capitales"
            ;;
        3)
            seleccionar_palabra "canciones_de_jose_jose"
            ;;
        4)
            seleccionar_palabra "peliculas_famosas"
            ;;
        *)
            echo -e "${RED}Categoría no válida. Por favor, elige una opción válida.${NC}"
            juego
            ;;

    esac
    palabra=${palabras[RANDOM % ${#palabras[@]}]}
    IFS=':' read -ra partes <<< "$palabra"
    palabra=${partes[0]}
    espacios=${palabra//[^ ]/_}


    while [[ $intentos -lt 7 && "$espacios" != "$palabra" ]]; do
        mostrar_ahorcado $intentos
        echo -e "${YELLOW}Palabra: ${NC}$espacios"
        echo -e "${YELLOW}Letras Adivinadas: ${NC}$letras_adivinadas"
        echo -e "${YELLOW}Letras Fallidas: ${NC}$letras_fallidas"
        read -p "Adivina una letra: " letra

        if [[ "$palabra" == *"$letra"* ]]; then
            for ((i = 0; i < ${#palabra}; i++)); do
                if [ "${palabra:$i:1}" == "$letra" ]; then
                    espacios="${espacios:0:$i}$letra${espacios:$i+1}"
                fi
            done
            letras_adivinadas="$letras_adivinadas$letra "
        else
            letras_fallidas="$letras_fallidas$letra "
            intentos=$((intentos + 1))
        fi
    done

    mostrar_ahorcado $intentos
    if [ "$espacios" == "$palabra" ]; then
        echo -e "${GREEN}¡Iralo namás! Has adivinado la palabra brodi: $palabra${NC}"
    else
        echo -e "${RED}¡Chale mano, estaba rrequete fácil! La palabra era: $palabra${NC}"
    fi
}

# Iniciar el juego
juego