#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
CONFIG_DIR=$(realpath "$SCRIPT_DIR/../")
H=~

FILE="$1"
F=$(basename "$FILE")

if [[ ! -f "$FILE" ]]
then
  echo "File does not exist."
  exit 1
fi

get_prop () {
  grep "^$1=" "$FILE" | cut -d "=" -f2
}

ML="$H/.config/mimeapps.list"
rm -f "$ML.old" &>/dev/null
cp "$ML" "$ML.old" &>/dev/null

NAME=$(get_prop "Name")
echo "Getting file associations for $NAME..."
MIMETYPES=$(get_prop "MimeType")
MIMETYPES=$(echo "$MIMETYPES" | tr ";" "\n")
echo "Adding associations to ~/.config/mimeapps.list"
for M in $MIMETYPES
do 
  MIMELIST=$(sed -n '/\[Default Applications\]/,$p' "$ML" | tail -n +2)
  NEWLINE=$(printf "$M=$F;")
  LN=$(grep -n '\[Default Applications\]' "$ML" | cut -d ":" -f1)
  if (echo "$MIMELIST" | grep -q "$M")
  then
    GR=$(echo "$MIMELIST" | grep -n "$M")
    GR=$(echo $GR | cut -d ":" -f1)
    LN=$(($LN + $GR))
    sed -i $LN's<.*<'"$NEWLINE<" "$ML"
  else
    sed -i $LN'a\'$'\n'$NEWLINE "$ML"
  fi
done

