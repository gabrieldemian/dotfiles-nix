#!/usr/bin/env bash

scripts=~/dotfiles/modules/home-manager/waybar/scripts
TEMP=/tmp/current_wall

dir=$HOME/dotfiles/wallpapers

cd "$dir"

wallpapers=($(fd -e png -e jpg -e jpeg -e webp --full-path $dir))
str=""

for item in "${wallpapers[@]}" 
do
  str+="img:$item\n"
done

raw_output=$(echo -e "$str" | wofi --show dmenu -c ./conf)

# remove the prefix "img:", first 4 characters.
selected_wallpaper="${raw_output:4}"

idx=0
i=0

# find the index of the selected wallpaper
for f in "${wallpapers[@]}"; do
  if [ $f = $selected_wallpaper ]; then
    idx=$i
  fi
  i=$(( i + 1 ))
done

echo $idx > $TEMP
$scripts/wall.sh "$selected_wallpaper"

exit 0
