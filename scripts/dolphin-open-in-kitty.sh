#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../")
H=~

echo "Creating ServiceMenus folder (if it doesn't exist)..."
DESTPATH="$H/.local/share/kservices5/ServiceMenus"
mkdir -p "$DESTPATH"

echo "Symlinking desktop file..."
DFILE=$(realpath "$SCRIPT_DIR/../kde/dolphin/OpenInKitty.desktop")
ln -s "$DFILE" "$DESTPATH"
