#!/usr/bin/env bash

if echo $DESKTOP_SESSION | grep i3
then
  picom --experimental-backends --vsync --backend glx &
fi
