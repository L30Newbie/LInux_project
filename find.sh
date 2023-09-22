#!/bin/bash

# Pedir al usuario la ruta absoluta y el nombre del archivo
read -p "Ingrese la ruta absoluta del archivo: " ruta_archivo
read -p "Ingrese el nombre del archivo: " nombre_archivo

# Concatenar la ruta absoluta y el nombre del archivo
ruta_completa="$ruta_archivo/$nombre_archivo"

# Verificar si el archivo existe
if [ -e "$ruta_completa" ]; then
  echo "En efecto, este archivo existe mi panamá. ;)"
else
  echo "Pa mí que te lo estás inventando mi tibio -_-"
fi
