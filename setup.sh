#!/usr/bin/env bash

HOME=~
DIR=$(pwd)

if ! command -v pacman &>/dev/null
then
  echo "Hey, you must be on an Arch-based system to use the installer at this time."
  exit 1
fi

if ! command -v git &>/dev/null
then
  echo "Installing git..."
  sudo pacman -S git --noconfirm
fi

if ! command -v yay &>/dev/null
then
  echo "Installing yay..."
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

echo "Setting up chaotic-aur..."
yay -S chaotic-mirrorlist chaotic-keyring --noconfirm
if ! (cat /etc/pacman.conf | grep chaotic-aur &>/dev/null)
then
  sudo echo "" >> /etc/pacman.conf
  sudo echo "[chaotic-aur]" >> /etc/pacman.conf
  sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
fi

echo "Installing all software as part of config..."
yay -Sy firefox kitty neovim-git neovim-plug ttf-jetbrains-mono i3 picom rofi dmenu feh --noconfirm
# Note to self: change neovim-git to neovim once 0.5.0 is out

echo "Pulling git submodules..."
git submodule update --init

# Note to self: use functions to mv and ln -s for readability and reuse

echo "Symlinking Firefox config..."
mkdir -p "$HOME/.mozilla/firefox"
FF_PROFILES=$(ls "$HOME/.mozilla/firefox" | grep release)
for PROF in $FF_PROFILES
do
  if [ -d "$HOME/.mozilla/firefox/$PROF/chrome" ]
  then
    mv "$HOME/.mozilla/firefox/$PROF/chrome" "$HOME/.mozilla/firefox/$PROF/chrome.old"
  fi
  ln -s "$DIR/firefox/chrome/" "$HOME/.mozilla/firefox/$PROF/"
  if [ -f "$HOME/.mozilla/firefox/$PROF/user.js" ]
  then
    mv "$HOME/.mozilla/firefox/$PROF/user.js" "$HOME/.mozilla/firefox/$PROF/user.js.old"
  fi
  ln -s "$DIR/firefox/user.js" "$HOME/.mozilla/firefox/$PROF/"
done

echo "Symlinking i3 config/scripts..."
if [ -d "$HOME/.config/i3" ]
then
  mv "$HOME/.config/i3" "$HOME/.config/i3.old"
fi
ln -s "$DIR/i3" "$HOME/.config/"

echo "Symlinking kitty config..."
if [ -d "$HOME/.config/kitty" ]
then
  mv "$HOME/.config/kitty" "$HOME/.config/kitty.old"
fi
ln -s "$DIR/kitty" "$HOME/.config/"

echo "Symlinking and installing nvim config/plugins..."
if [ -d "$HOME/.config/nvim" ]
then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
fi
ln -s "$DIR/nvim" "$HOME/.config/"
nvim --headless +PlugInstall +qall

echo "Symlinking picom config..."
if [ -d "$HOME/.config/picom" ]
then
  mv "$HOME/.config/picom" "$HOME/.config/picom.old"
fi
ln -s "$DIR/picom" "$HOME/.config/"

echo "Symlinking rofi config..."
if [ -d "$HOME/.config/rofi" ]
then
  mv "$HOME/.config/rofi" "$HOME/.config/rofi.old"
fi
ln -s "$DIR/rofi" "$HOME/.config/"

echo "Done!"
exit 0
