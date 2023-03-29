#!/usr/bin/env bash

theme="wpg"
dir="$HOME/.config/wpg/templates"

rofi -no-lazy-grab -show drun -modi drun -icon-theme "Papirus" -show-icons -theme $dir/"$theme"
