#!/usr/bin/env bash

swww img "$1" --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 3
