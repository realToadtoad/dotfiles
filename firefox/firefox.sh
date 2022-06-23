#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

echo "Symlinking firefox config..."

FF_PATH=~/.mozilla/firefox
mkdir -p "$FF_PATH"
FF_PROFILES=$(ls "$FF_PATH" | grep release)
for PROF in $FF_PROFILES
do
  PROF_PATH="$FF_PATH/$PROF"
  rm -rf "$PROF_PATH/chrome.old" &>/dev/null
  mv "$PROF_PATH/chrome" "$PROF_PATH/chrome.old" &>/dev/null
  ln -s "$SCRIPT_DIR/chrome" "$PROF_PATH/chrome"
  rm -rf "$PROF_PATH/user.js.old" &>/dev/null
  mv "$PROF_PATH/user.js" "$PROF_PATH/user.js.old" &>/dev/null
  ln -s "$SCRIPT_DIR/user.js" "$PROF_PATH/user.js"
done
