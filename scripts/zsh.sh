#!/usr/bin/env bash

sudo pacman -S zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/.zprezto"

cat > ~/.inputrc << "EOF"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"
source "$ZDOTDIR/.zshenv"
EOF

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh
