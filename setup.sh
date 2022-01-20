#!/usr/bin/env bash

HOME=~
DIR=$(pwd)

echo "Home directory: $HOME"
echo "Current directory (this should be the root of the dotfiles folder): $DIR"
echo

if ! command -v pacman &>/dev/null
then
  echo "Hey, you must be on an Arch-based system to use the installer at this time."
  exit 1
fi

if ! command -v git &>/dev/null
then
  echo "Installing git..."
  sudo pacman -S git --noconfirm &>/dev/null
fi

if ! command -v yay &>/dev/null
then
  echo "Installing yay..."
  git clone https://aur.archlinux.org/yay.git &>/dev/null
  cd yay
  makepkg -si --noconfirm &>/dev/null
  cd ..
  rm -rf yay
fi

echo "Setting up chaotic-aur..."
# yay -S chaotic-mirrorlist chaotic-keyring --noconfirm &>/dev/null
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
if ! (cat /etc/pacman.conf | grep chaotic-aur &>/dev/null)
then
  echo "" | sudo tee -a /etc/pacman.conf
  echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
  echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
fi

echo "Installing all software as part of config..."
yay -Sy firefox kitty neovim font-victor-mono nerd-fonts-victor-mono i3 picom rofi dmenu feh --noconfirm &>/dev/null

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
  rm -rf "$HOME/.mozilla/firefox/$PROF/chrome.old" &>/dev/null
    mv "$HOME/.mozilla/firefox/$PROF/chrome" "$HOME/.mozilla/firefox/$PROF/chrome.old"
  fi
  ln -s "$DIR/firefox/chrome" "$HOME/.mozilla/firefox/$PROF"
  if [ -f "$HOME/.mozilla/firefox/$PROF/user.js" ]
  then
    mv "$HOME/.mozilla/firefox/$PROF/user.js" "$HOME/.mozilla/firefox/$PROF/user.js.old"
  fi
  ln -s "$DIR/firefox/user.js" "$HOME/.mozilla/firefox/$PROF/"
done
echo "Symlinking i3 config/scripts..."
if [ -d "$HOME/.config/i3" ]
then
  rm -rf "$HOME/.config/i3.old" &>/dev/null
  mv "$HOME/.config/i3" "$HOME/.config/i3.old"
fi
ln -s "$DIR/i3" "$HOME/.config/"

echo "Symlinking kitty config..."
if [ -d "$HOME/.config/kitty" ]
then
  rm -rf "$HOME/.config/kitty.old" &>/dev/null
  mv "$HOME/.config/kitty" "$HOME/.config/kitty.old"
fi
ln -s "$DIR/kitty" "$HOME/.config/"

echo "Symlinking and installing nvim config/plugins..."
git clone https://github.com/wbthomason/packer.nvim "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d "$HOME/.config/nvim" ]
then
  rm -rf "$HOME/.config/nvim.old" &>/dev/null
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
fi
yay -S typescript typescript-language-server-bin omnisharp-roslyn-bin texlive-most jdtls
ln -s "$DIR/nvim" "$HOME/.config/"
nvim --headless +PackerCompile +PackerInstall +qall

echo "Symlinking picom config..."
if [ -d "$HOME/.config/picom" ]
then
  rm -rf "$HOME/.config/picom.old" &>/dev/null
  mv "$HOME/.config/picom" "$HOME/.config/picom.old"
fi
ln -s "$DIR/picom" "$HOME/.config/"

echo "Symlinking rofi config..."
if [ -d "$HOME/.config/rofi" ]
then
  rm -rf "$HOME/.config/rofi.old" &>/dev/null
  mv "$HOME/.config/rofi" "$HOME/.config/rofi.old"
fi
ln -s "$DIR/rofi" "$HOME/.config/"

echo "Done!"
exit 0
