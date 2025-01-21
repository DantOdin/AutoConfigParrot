# ConfigParrotOdin

## Introducción

**ConfigParrotOdin** es un script de Bash diseñado para personalizar el sistema operativo **Parrot OS** siguiendo una estética y funcionalidad inspirada en el estilo del colega **S4vitar**. Este autoconfigurador simplifica la instalación y configuración de herramientas esenciales para mejorar la experiencia de usuario.

---

## Herramientas incluidas

El script instala y configura las siguientes herramientas:

- **bspwm y sxhkd**: Gestor de ventanas dinámico y su herramienta de atajos de teclado.
- **polybar, picom y rofi**: Barra de estado, compositor para efectos gráficos, y lanzador de aplicaciones.
- **kitty y feh**: Terminal gráfico y visor de imágenes ligero.
- **oh-my-zsh y powerlevel10k**: Shell interactivo con un tema estético y funcional.
- **Batcat y lsd**: Reemplazos mejorados de 'cat' y 'ls' con más características.
- **NvChad y Neovim**: Configuración mejorada para Neovim como IDE.

---

## Características principales

- **Logo ASCII personalizado** para mostrar un diseño atractivo al inicio.
- **Interactividad**: Pregunta al usuario si desea continuar con la personalización.
- **Manejo de señales**: Captura la señal `Ctrl+C` para cancelar la operación de forma segura.
- **Colores y estilos**: Uso de colores para resaltar información importante y estados de las acciones.
- **Mensajes de estado**:
  - **[✓]** Acción completada correctamente.
  - **[✕]** Error al realizar la acción.
  - **[◐]** Herramienta previamente instalada (consulta sobre sobrescritura o actualización).

---

## Requisitos

1. **Sistema operativo**: Parrot OS.
2. **Permisos de ejecución**: Asegúrate de otorgar permisos de ejecución al script:
   ```bash
   chmod +x ConfigParrotOdin.sh
   ```
3. **Ejecución**: Ejecuta el script con:
   ```bash
   ./ConfigParrotOdin.sh
   ```

---

## Uso

1. Clona el repositorio desde GitHub:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```
2. Navega al directorio del script:
   ```bash
   cd <NOMBRE_DEL_DIRECTORIO>
   ```
3. Sigue las instrucciones que aparecen en pantalla.

---

## Contribuciones

¡Las contribuciones son bienvenidas! Si tienes sugerencias, errores que reportar o mejoras, no dudes en abrir un **issue** o enviar un **pull request**.

---

## Licencia

Este proyecto está licenciado bajo la [MIT License](LICENSE). Si utilizas este script, se agradece el reconocimiento.

---

## Contacto

Para preguntas o soporte, puedes contactar al creador del script mediante GitHub o correo electrónico (si aplica).

