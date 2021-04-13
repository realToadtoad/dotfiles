#!/usr/bin/env bash

ARGS="-c 000000"

if echo $DESKTOP_SESSION | grep sway
then
  swaylock $ARGS
elif echo $DESKTOP_SESSION | grep i3
then
  i3lock $ARGS
fi
