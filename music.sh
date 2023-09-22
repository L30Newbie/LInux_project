#!/bin/bash

# Solicitar al usuario la ruta de la biblioteca musical
MUSIC_DIR=$(zenity --file-selection --directory --title="Selecciona la carpeta de tu biblioteca musical")

# Verificar si mpg123 está instalado
if ! command -v mpg123 &>/dev/null; then
  zenity --question --text="El reproductor mpg123 no está instalado. ¿Desea instalarlo?" --title="Reproductor MP3"

  if [ $? -eq 0 ]; then
    # Instalar mpg123 (debes proporcionar el comando de instalación adecuado según tu sistema)
    sudo apt-get install mpg123  # Ejemplo para sistemas basados en Debian
  else
    zenity --error --text="Reproductor MP3 no disponible. Saliendo." --title="Reproductor MP3"
    exit 1
  fi
fi

# Lista de canciones en el directorio
SONGS=("$MUSIC_DIR"/*.mp3)
TOTAL_SONGS=${#SONGS[@]}
current_song=0
paused=false
player_pid=

# Función para reproducir una canción
play_song() {
  local song="$1"
  mpg123 "$MUSIC_DIR/$song" &
  player_pid=$!
  current_song="$song"
  paused=false
}

# Función para pausar la reproducción
pause_song() {
  if [ -n "$player_pid" ]; then
    kill -STOP "$player_pid"
    paused=true
  fi
}

# Función para reanudar la reproducción
resume_song() {
  if [ -n "$player_pid" ] && [ "$paused" = true ]; then
    kill -CONT "$player_pid"
    paused=false
  fi
}

# Función para reproducir la siguiente canción
next_song() {
  if [ $current_song -lt $(($TOTAL_SONGS - 1)) ]; then
    current_song=$(($current_song + 1))
    stop_song
    play_song "$(basename "${SONGS[$current_song]}")"
  else
    zenity --info --text="No hay más canciones disponibles." --title="Reproductor MP3"
  fi
}

# Función para reproducir la canción anterior
prev_song() {
  if [ $current_song -gt 0 ]; then
    current_song=$(($current_song - 1))
    stop_song
    play_song "$(basename "${SONGS[$current_song]}")"
  else
    zenity --info --text="Esta es la primera canción." --title="Reproductor MP3"
  fi
}

# Función para detener la reproducción
stop_song() {
  if [ -n "$player_pid" ]; then
    kill "$player_pid" &>/dev/null
    player_pid=
    paused=false
  fi
}

# Bucle principal
while true; do
  if [ $TOTAL_SONGS -eq 0 ]; then
    zenity --info --text="No se encontraron canciones en la biblioteca musical." --title="Reproductor MP3"
    exit 0
  fi

  choice=$(zenity --list --title="Reproductor MP3" --column="Canciones" "${SONGS[@]}" "Pausar" "Reanudar" "Siguiente Canción" "Canción Anterior" "Cerrar" --width=400 --height=300)

  case "$choice" in
    "Pausar")
      pause_song
      ;;
    "Reanudar")
      resume_song
      ;;
    "Siguiente Canción")
      next_song
      ;;
    "Canción Anterior")
      prev_song
      ;;
    "Cerrar")
      stop_song
      exit 0
      ;;
    *)
      if [ -n "$choice" ]; then
        stop_song
        play_song "$(basename "$choice")"
      fi
      ;;
  esac
done