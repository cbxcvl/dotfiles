#!/bin/bash

# Diretório onde os papéis de parede estão armazenados
WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
CURRENT_WALLPAPER_FILE="$HOME/.current_wallpaper"

# Lista de papéis de parede disponíveis
WALLPAPERS=($(ls "$WALLPAPERS_DIR"))

# Lista de transições disponíveis
TRANSITIONS=("fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")

# Função para obter o papel de parede atual
get_current_wallpaper() {
  if [ -f "$CURRENT_WALLPAPER_FILE" ]; then
    cat "$CURRENT_WALLPAPER_FILE"
  else
    echo ""
  fi
}

# Função para atualizar o papel de parede atual
update_current_wallpaper() {
  echo "$1" >"$CURRENT_WALLPAPER_FILE"
}

# Verifica se há papéis de parede disponíveis
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
  echo "Nenhum papel de parede encontrado no diretório $WALLPAPERS_DIR."
  exit 1
fi

# Obtém o papel de parede atual
CURRENT_WALLPAPER=$(get_current_wallpaper)

# Escolhe um novo papel de parede aleatório diferente do atual
while true; do
  SELECTED_WALLPAPER="${WALLPAPERS[$RANDOM % ${#WALLPAPERS[@]}]}"
  if [ "$SELECTED_WALLPAPER" != "$CURRENT_WALLPAPER" ]; then
    break
  fi
done

# Escolhe uma transição aleatória
TRANSITION="${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}"

# Define o papel de parede com a transição escolhida
swww img "$WALLPAPERS_DIR/$SELECTED_WALLPAPER" --transition-type "$TRANSITION" --transition-fps 120 --transition-duration 1.0

# Atualiza o papel de parede atual
update_current_wallpaper "$SELECTED_WALLPAPER"

# Envia uma notificação
notify-send -i "$ICON_PATH" "Wallpaper Changed" "The wallpaper has been successfully changed." \
  --expire-time=1000 --hint=int:transient:1
