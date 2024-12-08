{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.writeScriptBin "wall" ''
  #!/usr/bin/env bash
  ${pkgs.swww}/bin/swww img "$1" --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 3

''
