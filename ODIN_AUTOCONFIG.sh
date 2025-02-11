#!/bin/bash

# Manejo de Ctrl+C
trap 'echo -e "\n\e[1;31mOperación cancelada. Saliendo...\e[0m"; exit 1' INT

# Colores y estilos
RESET="\e[0m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
PURPLE="\e[1;35m"
BOLD="\e[1m"

# Variables globales
SCRIPT_DIR=$(pwd) # Directorio actual al ejecutar el script
BSPWM_CONFIG_DIR="$HOME/.config/bspwm"
SXHKD_CONFIG_DIR="$HOME/.config/sxhkd"



# Logo ASCII de Parrot OS
logo_odin() {
  echo -e "${PURPLE}${BOLD}"
  echo ""
  echo " = = = = = = = = = = = = = = = = = = "
  echo ""
  echo ""
  echo "    ██████╗ ██████╗ ██╗███╗   ██╗"
  echo "   ██╔═══██╗██╔══██╗██║████╗  ██║"
  echo "   ██║   ██║██║  ██║██║██╔██╗ ██║"
  echo "   ██║   ██║██║  ██║██║██║╚██╗██║"
  echo "   ╚██████╔╝██████╔╝██║██║ ╚████║"
  echo "    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝"
  echo ""
  echo " = = = = = = = = = = = = = = = = = = "
  echo ""
  echo -e "${RESET}"
}

# Función principal de introducción
introduccion() {
  
  echo -e "Hola! Soy ${PURPLE}${BOLD}DantOdin${RESET}, y he creado este pequeño script para personalizar Parrot OS."
  echo -e "El objetivo es seguir la estética que usa el colega ${PURPLE}${BOLD}S4vitar${RESET}."
  echo ""
  echo -e "Este script instalará y configurará las siguientes herramientas:"
  echo -e "- ${YELLOW}${BOLD}bspwm y sxhkd${RESET}: Un gestor de ventanas dinámico y su herramienta de atajos de teclado."
  echo -e "- ${YELLOW}${BOLD}polybar, picom y rofi${RESET}: Barra de estado, compositor para efectos gráficos, y lanzador de aplicaciones."
  echo -e "- ${YELLOW}${BOLD}kitty y feh${RESET}: Terminal gráfico y visor de imágenes ligero."
  echo -e "- ${YELLOW}${BOLD}oh-my-zsh y powerlevel10k${RESET}: Shell interactivo con un tema estético y funcional."
  echo -e "- ${YELLOW}${BOLD}Batcat y lsd${RESET}: Reemplazos mejorados de 'cat' y 'ls' con más características."
  echo -e "- ${YELLOW}${BOLD}NvChad y Neovim${RESET}: Configuración mejorada para Neovim como IDE."
  echo ""
  echo "Los estados de las acciones serán mostrados como:"
  echo -e "- [${GREEN}✓${RESET}] Acción completada correctamente."
  echo -e "- [${RED}✕${RESET}] Error al realizar la acción."
  echo -e "- [${YELLOW}◐${RESET}] Herramienta previamente instalada (se consultará si deseas sobreescribir/actualizar)."
  echo ""
  echo -e "${YELLOW}${BOLD}Nota importante:${RESET} Recuerda otorgar permisos de ejecución al script antes de usarlo."
  echo -e "Ejemplo:"
  echo -e "${YELLOW}chmod +x ConfigParrotOdin.sh${RESET}"
  echo -e "Y luego ejecutarlo con:"
  echo -e "${YELLOW}./ConfigParrotOdin.sh${RESET}"
  echo ""
  echo -e "${YELLOW}${BOLD}¿Deseas continuar con la personalización? (Y/N)${RESET}"
  read -r continuar
  if [[ $continuar != "Y" && $continuar != "y" ]]; then
    echo -e "${RED}${BOLD}Operación cancelada por el usuario.${RESET}"
    exit 0
  fi
}

#Instalación y configuración de Bspwm y Sxhkd
clase1 () {
    mkdir dnwld
    cd dnwld/
    sudo apt -y install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev
    git clone https://github.com/baskerville/bspwm.git
    git clone https://github.com/baskerville/sxhkd.git
    cd bspwm/
    make
    sudo make install
    which bspwm
    cd ..
    cd bspwm/
    make sxhkd/
    make
    sudo make install
    which sxhkd
    cd ..

    sudo apt install -y kitty

    mkdir -p ~/.config/{bspwm,sxhkd}
    mkdir -p ~/.config/bspwm/scripts
    ##  ###  ## ##  ####  ## # # #### ## #### ## ## # ## # ### ### ### ##
    cd ..

    cp Files/bspwmrc ~/.config/bspwm # estos deben ser los mios, pero primero debo crearlos
    cp Files/sxhkdrc ~/.config/sxhkd ### ###########         ##########   #####
    cp Files/scripts/bspwm_resize ~/.config/bspwm/scripts
    chmod +x ~/.config/bspwm/scripts/bspwm_resize
    chmod +x ~/.config/bspwm/bspwmrc
    chmod +x ~/.config/sxhkd/sxhkdrc

    echo "Fin de la Clase 1"
}

clase2() {
  sudo apt install -y polybar
  sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev
  sudo apt update
  sudo apt install cmake
  cd dnwld/
  git clone https://github.com/yshui/picom
  cd picom/
  meson setup --buildtype=release build
  ninja -C build
  sudo apt update
  ninja -C build install
  cd ..
  cd ..

  sudo apt install rofi

}

#EJECUCIÓN
logo_odin
introduccion
clase1
clase2