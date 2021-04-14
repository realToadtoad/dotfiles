#!/usr/bin/env bash

if echo $DESKTOP_SESSION | grep i3
then
  picom --vsync --backend glx &
fi
