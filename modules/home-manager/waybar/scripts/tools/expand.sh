#!/usr/bin/env bash

TEMP=/tmp/current_wall

files=(~/dotfiles/wallpapers/*)

scripts=~/dotfiles/modules/home-manager/waybar/scripts

cooldown=0.1

while true
do
    case "$1" in
        "cycle")
            index=$(cat $TEMP)
            index=$((index+1))
            if [ $index -ge ${#files[@]} ]; then
                index=0
            fi
            echo $index > $TEMP
            $scripts/wall.sh "${files[$index]}"
            exit 0
            ;;
        "arrow-icon")
            if $scripts/toolbar_state.sh; then
                echo ""
            else
                echo ""
            fi
            ;;
        "ss-icon")
            if $scripts/toolbar_state.sh; then
                echo ""
            else
                echo ""
            fi
            ;;
        "wall-icon")
            if $scripts/toolbar_state.sh; then
                echo "󰟾󰸉"
            else
                echo ""
            fi
            ;;
        *)
            if $scripts/toolbar_state.sh; then
                echo "     "
            else
                echo ""
            fi
            ;;
    esac
    sleep $cooldown
done
