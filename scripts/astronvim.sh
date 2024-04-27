#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../astronvim")
H=~

sudo pacman -S ttf-nerd-fonts-symbols neovim

rm -rf "$H/.config/nvim.bak" &>/dev/null
rm -rf "$H/.local/share/nvim.bak" &>/dev/null
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
mkdir -p "$H/.config/astronvim/lua"
ln -s "$CONFIG_DIR" "$H/.config/astronvim/lua/user"

nvim  --headless -c 'quitall'
