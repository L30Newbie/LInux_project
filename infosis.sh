#!/bin/bash

# Función para imprimir una línea divisoria en verde
print_divider() {
  echo -e "\e[32m========================================\e[0m"
}

# Función para imprimir texto en amarillo
print_yellow() {
  echo -e "\e[33m$1\e[0m"
}

# Encabezado con el perro en amarillo y el mensaje
echo -e "\e[33m        / \\__\e[0m      ¿Policía o qué?"
echo -e "\e[33m       (    @\\___\e[0m"
echo -e "\e[33m       /         O\e[0m"
echo -e "\e[33m      /   (_____/\e[0m"
echo -e "\e[33m    /_____/   U\e[0m"
echo -e "\e[33m   /     /\e[0m"
echo -e "\e[33m  /_____/\e[0m"
print_divider

# Información del sistema en cian
echo -e "\e[36mInformación del Sistema:\e[0m"
print_divider

# Obtener información de la memoria RAM
echo -e "\e[36mMemoria RAM:\e[0m"
mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
mem_total_mb=$(echo "scale=2; $mem_total / 1024" | bc)
echo -e "Total de memoria RAM: \e[35m$mem_total_mb MB\e[0m"

# Obtener la arquitectura del sistema
echo -e "\n\e[36mArquitectura del sistema:\e[0m"
arch=$(uname -m)
echo -e "Arquitectura: \e[35m$arch\e[0m"

# Obtener la versión del sistema operativo
echo -e "\n\e[36mVersión del sistema operativo:\e[0m"
os_version=$(cat /etc/os-release | grep "VERSION=" | cut -d '"' -f 2)
echo -e "Versión del sistema operativo: \e[35m$os_version\e[0m"

# Fin del programa
print_divider