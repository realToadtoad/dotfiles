#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../mpv")
H=~

echo "Symlinking mpv config..."
DC="$H/.config/mpv"
rm -rf "$DC.old" &>/dev/null
mv "$DC" "$DC.old" &>/dev/null
ln -s "$CONFIG_DIR" "$DC"
