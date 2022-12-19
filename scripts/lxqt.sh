#!/usr/bin/env bash

NAME="lxqt"

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../$NAME")
H=~

# for lxqt, must also install lxqt meta-package, papirus-icon-theme, and i3lock

echo "Symlinking $NAME config..."
DC="$H/.config/$NAME"
rm -rf "$DC.old" &>/dev/null
mv "$DC" "$DC.old" &>/dev/null
ln -s "$CONFIG_DIR" "$DC"
