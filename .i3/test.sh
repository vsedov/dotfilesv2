#!/bin/bash
window=$(xdotool getactivewindow)
workspace=$(i3-msg -t get_tree | jq '.. | (.nodes? + .floating_nodes?) // empty | .[] | select(.nodes) | .nodes[] | select(.id=='"$window"') | .. | .workspace' | sort -u)
printf '%s ' "$workspace"
