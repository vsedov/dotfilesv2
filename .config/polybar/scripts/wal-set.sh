#!/bin/bash

# Author : Ruturajn <nanotiruturaj@gmail.com>

# This script changes the colorscheme using pywal and wpgtk
# globally.

# Catch errors if any while running the script.
set -eou pipefail

# Define the PATH where the Wallpapers are located.
WALLPAPER_PATH="/home/$(whoami)/Pictures/Wallpaper/groups/cities/"

# Get a list of wallpapers, from the WALLPAPER_PATH, and add a picutre glyph at the
# beginning of the line. Finally, pass the list to rofi.
selected_wal=$(find "$WALLPAPER_PATH" -name "*" | rev | cut -d / -f 1 | rev | sed 1d |
    sed 's|^| |' | rofi -dmenu -i -p "Wal" -l 5 \
    -theme-str 'configuration {show-icons: false;}' \
    -theme-str 'configuration {font: "Jet Brains Mono Nerd Font Mono Regular 14";}
  ')

# If no wallpaper is selected, exit.
if [[ -z "$selected_wal" ]]; then
    exit
fi

# Remove the glyph, from the beginning of the line.
selected_wal=$(echo "$selected_wal" | sed 's|^. ||')

# if previous colorschemes exit, remove them.
if [[ "$(ls -a ~/.config/wpg/schemes)" ]]; then
    rm ~/.config/wpg/schemes/* || exit
fi
#
# print selected wallpaper to a file.
# echo "${selected_wal}" > ~/.config/wpg/schemes/selected_wal.txt
# Add the selected wallpaper to wpg.
wpg -a "${WALLPAPER_PATH}${selected_wal}"

# wpg -S "${WALLPAPER_PATH}${selected_wal}"

# Set the wallpaper, and generate the colorscheme.
wpg -s "$selected_wal"
# wpg -sat  "${selected_wal}" 0.1

wal_colors_list=$(cat ~/.config/wpg/schemes/* | grep "color" | sed 1d | sed 's|^        ||' | awk '{print $2}' | sed 's|,||')
wal_colors_list=("$wal_colors_list")
for i in {1..8}; do
    search_exp="gradient_color_${i}"
    replace_exp="gradient_color_${i} = ${wal_colors_list[i]}"
    sed -i "s|^$search_exp.*|$replace_exp|" ~/.config/cava/config
done
