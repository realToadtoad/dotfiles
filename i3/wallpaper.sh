#!/usr/bin/env bash

shopt -s extglob
WALLPAPER_PATH=~/.config/i3/wallpaper.!(*sh)

if echo $DESKTOP_SESSION | grep sway
then
  swaybg -m fill -i $WALLPAPER_PATH
elif echo $DESKTOP_SESSION | grep i3
then
  feh --bg-scale $WALLPAPER_PATH
fi
