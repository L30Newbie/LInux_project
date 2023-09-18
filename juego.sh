#!/bin/bash

# Definición de las listas de palabras por categoría
declare -A categorias
categorias["colores"]="rojo verde azul amarillo naranja rosa morado blanco negro"
categorias["paises"]="estadosunidos canada mexico argentina alemania francia china japon"
categorias["comida"]="pizza hamburguesa sushi espagueti ensalada tacos burritos"
categorias["artistas"]="leonardodavinci picasso mozart shakespeare beyonce elvispresley madonna"
categorias["josejose"]="eltriste lamujerquesoñe lagotafría amnesia alméncemeperdona"

# Elegir una categoría al azar
categorias_keys=("${!categorias[@]}")
categoria_indice=$((RANDOM % ${#categorias_keys[@]}))
categoria=${categorias_keys[$categoria_indice]}

# Elegir una palabra al azar de la categoría seleccionada
palabras=(${categorias[$categoria]})
indice=$((RANDOM % ${#palabras[@]}))
palabra=${palabras[$indice]}

# Inicializar las variables
intentos=0
max_intentos=6
palabra_adivinada=""
letras_erroneas=""

# Función para mostrar el estado actual del juego
mostrar_estado() {
    clear
    echo "Ahorcado - Adivina la palabra (Categoría: $categoria)"
    echo "Palabra: $palabra_adivinada"
    echo "Letras incorrectas: $letras_erroneas"
    echo "Intentos restantes: $((max_intentos - intentos))"
    echo -e "\nMuñeco:"
    
    case $intentos in
        0)
            echo "  ________     "
            echo " |        |    "
            echo " |             "
            echo " |             "
            echo " |             "
            echo " |             "
            ;;
        1)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |             "
            echo " |             "
            echo " |             "
            ;;
        2)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |        |    "
            echo " |             "
            echo " |             "
            ;;
        3)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |       /|    "
            echo " |             "
            echo " |             "
            ;;
        4)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |       /|\\  "
            echo " |             "
            echo " |             "
            ;;
        5)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |       /|\\  "
            echo " |       /     "
            echo " |             "
            ;;
        6)
            echo "  ________     "
            echo " |        |    "
            echo " |        0    "
            echo " |       /|\\  "
            echo " |       / \\  "
            echo " |             "
            ;;
    esac
}

# Función para comprobar si se ha adivinado la palabra
adivinado() {
    if [[ $palabra == $palabra_adivinada ]]; then
        mostrar_estado
        echo "¡Felicidades! ¡Has adivinado la palabra: '$palabra'!"
        exit 0
    fi
}

# Bucle principal del juego
while [[ $intentos -lt $max_intentos ]]; do
    mostrar_estado

    echo -n "Ingresa una letra: "
    read letra

    if [[ ${#letra} -ne 1 ]]; then
        echo "Por favor, ingresa una sola letra."
        continue
    fi

    if [[ $palabra =~ $letra ]]; then
        palabra_adivinada=$(echo "$palabra" | sed "s/[^$letra ]/_/g")
        adivinado
    else
        intentos=$((intentos + 1))
        letras_erroneas="$letras_erroneas $letra"
    fi
done

mostrar_estado
echo "¡Oh no! Te has quedado sin intentos. La palabra era '$palabra'."