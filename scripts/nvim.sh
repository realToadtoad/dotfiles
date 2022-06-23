#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../nvim")
H=~

echo "Symlinking nvim config..."
rm -rf "~/.config/nvim.old" &>/dev/null
mv "$H/.config/nvim" "$H/.config/nvim.old" &>/dev/null
ln -s "$CONFIG_DIR" "$H/.config/"

echo "Installing packer.nvim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Installing plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
