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
BSPWMRC_PATH="$HOME/.config/bspwm/bspwmrc"
SXHKDRC_PATH="$HOME/.config/sxhkd/sxhkdrc"
ERD_FONT_PATH="$FONT_DIR/HackNerdFontPropo-Regular.ttf"
BSPWM_SCRIPTS = "$HOME/.config/bspwm/scripts/"


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
  
  echo -e "Hola! Soy ${PURPLE}${BOLD}Odin${RESET}, y he creado este pequeño script para personalizar Parrot OS."
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

# Función para instalar bspwm y sxhkd
instalar_bspwm_sxhkd() {
  # Mostrar mensaje inicial de la instalación
  echo -e "${YELLOW}Iniciando instalación de bspwm y sxhkd...${RESET}"
  
  # Verificar si bspwm y sxhkd ya están instalados
  if command -v bspwm &>/dev/null && command -v sxhkd &>/dev/null; then
    echo -e "- [${YELLOW}◐${RESET}] bspwm y sxhkd ya están instalados."
    
    # Preguntar al usuario si desea actualizar la instalación existente
    echo -e "¿Deseas actualizar la instalación? (Y/N)"
    read -r actualizar
    if [[ $actualizar != "Y" && $actualizar != "y" ]]; then
      # Omitir actualización si el usuario no quiere actualizar
      echo -e "- [${YELLOW}◐${RESET}] Omitiendo actualización de bspwm y sxhkd."
      return
    fi
  fi

  # Actualizar los repositorios e instalar dependencias necesarias para bspwm y sxhkd
  echo -e "Instalando dependencias necesarias..."
  if sudo apt update && sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev \
    libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev \
    libxcb-xtest0-dev libxcb-shape0-dev kitty; then
       echo -e "- [${GREEN}✓${RESET}] Dependencias instaladas correctamente."
  else
    # Salir de la función si ocurre un error al instalar dependencias
    echo -e "- [${RED}✕${RESET}] Error al instalar dependencias."
    return
  fi

  # Descargar, compilar e instalar bspwm
  echo -e "Instalando bspwm..."
  cd "$SCRIPT_DIR" || { echo -e "- [${RED}✕${RESET}] Error al cambiar al directorio ${SCRIPT_DIR}."; return; }
  if git clone https://github.com/baskerville/bspwm.git && cd bspwm && make && sudo make install; then
    echo -e "- [${GREEN}✓${RESET}] bspwm instalado correctamente."
    cd "$SCRIPT_DIR" || return
  else
    echo -e "- [${RED}✕${RESET}] Error al instalar bspwm."
    return
  fi

  # Descargar, compilar e instalar sxhkd
  echo -e "Instalando sxhkd..."
  if git clone https://github.com/baskerville/sxhkd.git && cd sxhkd && make && sudo make install; then
    echo -e "- [${GREEN}✓${RESET}] sxhkd instalado correctamente."
    cd "$SCRIPT_DIR" || return
  else
    echo -e "- [${RED}✕${RESET}] Error al instalar sxhkd."
    return
  fi

  # Configurar los archivos de ejemplo para bspwm y sxhkd
  echo -e "Configurando archivos bspwmrc y sxhkdrc..."
  mkdir -p "$BSPWM_CONFIG_DIR" "$SXHKD_CONFIG_DIR" # Crear directorios de configuración si no existen
  cd bspwm/examples/ || { echo -e "- [${RED}✕${RESET}] Error al acceder a los ejemplos de configuración."; return; }
  cp bspwmrc "$BSPWMRC_PATH" # Copiar archivo de configuración bspwmrc
  chmod +x "$BSPWMRC_PATH"   # Dar permisos de ejecución al archivo
  cp sxhkdrc "$SXHKDRC_PATH" # Copiar archivo de configuración sxhkdrc
  chmod +x "$SXHKDRC_PATH"   # Dar permisos de ejecución al archivo
  echo -e "- [${GREEN}✓${RESET}] Archivos de configuración copiados correctamente."

  # Confirmar la finalización de la instalación y configuración
  echo -e "- [${GREEN}✓${RESET}] Instalación y configuración de bspwm y sxhkd completada."

  echo -e "${YELLOW}${BOLD}¿Deseas continuar con la personalización? (Y/N)${RESET}"
  read -r continuar
  if [[ $continuar != "Y" && $continuar != "y" ]]; then
    echo -e "${RED}${BOLD}Operación cancelada por el usuario.${RESET}"
    exit 0
  fi
}


configurar_polybar_picom_rofi() {
  echo -e "\n${YELLOW}Configurando Polybar, Picom y Rofi...${RESET}"

  # Instalación de Polybar
  echo -e "Instalando Polybar..."
  if ! command -v polybar &> /dev/null; then
    if sudo apt install -y polybar; then
      echo -e "- [${GREEN}✓${RESET}] Polybar instalado correctamente."
    else
      echo -e "- [${RED}✕${RESET}] Error al instalar Polybar."
      return
    fi
  else
    echo -e "- [${YELLOW}◐${RESET}] Polybar ya está instalado."
  fi

  # Instalación de dependencias para Picom
  echo -e "Instalando dependencias para Picom..."
  
  if sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev \
    libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev \
    libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev \
    libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev \
    meson ninja-build uthash-dev; then

    echo -e "- [${GREEN}✓${RESET}] Dependencias de Picom instaladas correctamente."
  else
    echo -e "- [${RED}✕${RESET}] Error al instalar dependencias de Picom."
    return
  fi
  sudo apt-get update
  # Instalación de Picom
  echo -e "Instalando Picom desde el repositorio..."
  if [ ! -d "picom" ]; then
    git clone https://github.com/yshui/picom || { echo -e "- [${RED}✕${RESET}] Error al clonar el repositorio de Picom."; return; }
  fi
  cd picom || { echo -e "- [${RED}✕${RESET}] Error al acceder al directorio de Picom."; return; }
  if meson setup --buildtype=release build && ninja -C build && sudo ninja -C build install; then
    echo -e "- [${GREEN}✓${RESET}] Picom instalado correctamente."
  else
    echo -e "- [${RED}✕${RESET}] Error durante la instalación de Picom."
    return
  fi
  cd ..

  # Instalación de Rofi
  echo -e "Instalando Rofi..."
  if ! command -v rofi &> /dev/null; then
    if sudo apt install -y rofi; then
      echo -e "- [${GREEN}✓${RESET}] Rofi instalado correctamente."
    else
      echo -e "- [${RED}✕${RESET}] Error al instalar Rofi."
      return
    fi
  else
    echo -e "- [${YELLOW}◐${RESET}] Rofi ya está instalado."
  fi

  # Configuración de sxhkd para Rofi
  echo -e "Configurando Rofi como lanzador de aplicaciones..."
  if grep -q "rofi -show run" "$SXHKDRC_PATH"; then
    echo -e "- [${YELLOW}◐${RESET}] Rofi ya está configurado como lanzador de aplicaciones en sxhkdrc."
  else
    echo -e "super + d\n    rofi -show run" >> "$SXHKDRC_PATH"
    echo -e "- [${GREEN}✓${RESET}] Rofi configurado correctamente en sxhkdrc."
  fi

  # Instalación de Hack Nerd Font
  echo -e "Instalando Hack Nerd Font..."
  mkdir -p "$FONT_DIR"
  if [ ! -f "$NERD_FONT_PATH" ]; then
    wget -O "$NERD_FONT_PATH" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip" && \
    unzip -o "$NERD_FONT_PATH" -d "$FONT_DIR" && fc-cache -fv
    echo -e "- [${GREEN}✓${RESET}] Hack Nerd Font instalada correctamente."
  else
    echo -e "- [${YELLOW}◐${RESET}] Hack Nerd Font ya está instalada."
  fi

  echo -e "- [${GREEN}✓${RESET}] Configuración de Polybar, Picom y Rofi completada."

  echo -e "${YELLOW}${BOLD}¿Deseas continuar con la personalización? (Y/N)${RESET}"
  read -r continuar
  if [[ $continuar != "Y" && $continuar != "y" ]]; then
    echo -e "${RED}${BOLD}Operación cancelada por el usuario.${RESET}"
    exit 0
  fi
}

copiar_configuracion() {
  BSPWM_SCRIPTS="$HOME/.config/bspwm/scripts/"
  mkdir -p "$BSPWM_SCRIPTS"
  cp -f "$SCRIPT_DIR/Scripts/bspwm_resize" "$BSPWM_SCRIPTS"
}



# Ejecucion
logo_odin
introduccion
instalar_bspwm_sxhkd
configurar_polybar_picom_rofi
copiar_configuracion
