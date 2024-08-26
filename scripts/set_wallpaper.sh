#!/bin/bash

# Diretório onde os papéis de parede estão armazenados
WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
CURRENT_WALLPAPER_FILE="$HOME/.current_wallpaper"

# Lista de papéis de parede predefinidos (opcional)
WALLPAPERS=$(ls "$WALLPAPERS_DIR")

# Lista de transições disponíveis
TRANSITIONS=("fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")

# Função para usar o wofi para selecionar uma opção
select_option() {
  local prompt="$1"
  local options="$2"
  echo "$options" | wofi --dmenu --prompt "$prompt"
}

# Obtém o papel de parede atual
get_current_wallpaper() {
  if [ -f "$CURRENT_WALLPAPER_FILE" ]; then
    cat "$CURRENT_WALLPAPER_FILE"
  else
    echo ""
  fi
}

# Atualiza o papel de parede atual
update_current_wallpaper() {
  echo "$1" >"$CURRENT_WALLPAPER_FILE"
}

# Escolha um papel de parede
SELECTED_WALLPAPER=$(select_option "Escolha o papel de parede" "$WALLPAPERS")

# Se o usuário não selecionar nenhum, aborta
if [ -z "$SELECTED_WALLPAPER" ]; then
  echo "Nenhum papel de parede selecionado. Saindo."
  exit 1
fi

# Verifica se o papel de parede selecionado é o mesmo que o atual
CURRENT_WALLPAPER=$(get_current_wallpaper)
if [ "$SELECTED_WALLPAPER" == "$CURRENT_WALLPAPER" ]; then
  echo "O papel de parede selecionado é o mesmo que o atual. Por favor, escolha um diferente."
  exit 1
fi

# Escolha uma transição (ou aleatória)
TRANSITION_OPTIONS=$(printf "%s\nrandom\n" "${TRANSITIONS[@]}")
SELECTED_TRANSITION=$(select_option "Escolha a transição" "$TRANSITION_OPTIONS")

# Se o usuário escolheu "random", escolhe uma transição aleatória
if [ "$SELECTED_TRANSITION" == "random" ]; then
  TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
else
  TRANSITION="$SELECTED_TRANSITION"
fi

# Define o papel de parede com a transição escolhida
swww img "$WALLPAPERS_DIR/$SELECTED_WALLPAPER" --transition-type "$TRANSITION" --transition-fps 120 --transition-duration 1.0

# Atualiza o papel de parede atual
update_current_wallpaper "$SELECTED_WALLPAPER"

# Envia uma notificação
notify-send -i "$ICON_PATH" "Wallpaper Changed" "The wallpaper has been successfully changed." \
  --expire-time=1000 --hint=int:transient:1
