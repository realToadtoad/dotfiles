#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../kitty")
H=~

echo "Symlinking kitty config..."
DEST_DIR="$H/.config/kitty"
rm -rf "$DEST_DIR.old" &>/dev/null
mv "$DEST_DIR" "$DEST_DIR.old" &>/dev/null
ln -s "$CONFIG_DIR" "$H/.config/kitty"

echo "Cloning tokyo night theme..."
git clone https://github.com/davidmathers/tokyo-night-kitty-theme.git "$CONFIG_DIR/tokyo-night-kitty-theme"

echo "Installing kitty, nerd fonts, fish..."
sudo pacman -S kitty fish ttf-nerd-fonts-symbols ttf-jetbrains-mono

fish -c "set -Ux EDITOR nvim"
fish -c "fish_config prompt choose scales"
