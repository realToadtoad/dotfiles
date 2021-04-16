#!/usr/bin/env bash

if echo $DESKTOP_SESSION | grep sway
then
  if command -v wofi &> /dev/null
  then
    wofi -d -S drun # window switching not possible with wayland
  else
    dmenu_run
  fi
elif echo $DESKTOP_SESSION | grep i3
then
  if command -v rofi &> /dev/null
  then
    rofi -combi-modi window,drun -modi combi -show combi -theme dracula # admittibly, the wofi theme is cooler
  else
    dmenu_run
  fi
fi
