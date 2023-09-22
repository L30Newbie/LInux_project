#!/bin/bash

# Solicitar al usuario la ruta de la biblioteca musical
MUSIC_DIR=$(zenity --file-selection --directory --title="Selecciona la carpeta de tu biblioteca musical")
