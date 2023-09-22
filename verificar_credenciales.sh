#!/bin/bash

echo "Ingrese su nombre de usuario:"
read username

# Verificar si el usuario existe
if ! id "$username" &>/dev/null; then
  echo "Usuario inválido"
  exit
fi

if [[ $(passwd -S "$username" | awk '{print $2}') == "P" ]]; then
  echo "Ingrese su contraseña:"
  read -s password
  pass=1
  if ! echo "$password" | su - "$username" -c 'echo ""' >/dev/null 2>&1; then
    echo "Contraseña incorrecta"
    pass=0
  fi
else
  echo "La contraseña para el usuario $username está inactiva"
  pass=0
fi
if [ $pass -eq 1 ]
then
  tput setaf 1
  clear
  echo "
  
┏━━┓┏━━┳━━━┳━┓╋┏┳┓╋╋┏┳━━━┳━┓╋┏┳━━┳━━━┳━━━┓┏┓╋╋╋╋╋╋╋╋┏┓
┃┏┓┃┗┫┣┫┏━━┫┃┗┓┃┃┗┓┏┛┃┏━━┫┃┗┓┃┣┫┣┻┓┏┓┃┏━━┛┃┃╋╋╋╋╋╋╋╋┃┃
┃┗┛┗┓┃┃┃┗━━┫┏┓┗┛┣┓┃┃┏┫┗━━┫┏┓┗┛┃┃┃╋┃┃┃┃┗━━┓┃┗━┳━┳━━┳━┛┣┓
┃┏━┓┃┃┃┃┏━━┫┃┗┓┃┃┃┗┛┃┃┏━━┫┃┗┓┃┃┃┃╋┃┃┃┃┏━━┛┃┏┓┃┏┫┏┓┃┏┓┣┫
┃┗━┛┣┫┣┫┗━━┫┃╋┃┃┃┗┓┏┛┃┗━━┫┃╋┃┃┣┫┣┳┛┗┛┃┗━━┓┃┗┛┃┃┃┗┛┃┗┛┃┃
┗━━━┻━━┻━━━┻┛╋┗━┛╋┗┛╋┗━━━┻┛╋┗━┻━━┻━━━┻━━━┛┗━━┻┛┗━━┻━━┻┛ "

    echo ""
    echo ""
fi

# Ejecutar línea de comandos
bash comandos.sh 

