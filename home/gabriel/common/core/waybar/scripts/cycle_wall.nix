{
  pkgs ? import <nixpkgs> { },
  # directory with wallpapers
  wallpapers,
  ...
}:
let
  wall = pkgs.callPackage ./wall.nix { };
in
pkgs.writeScriptBin "cycle_wall" ''
  #!/usr/bin/env bash

  index=$(cat $TEMP)
  index=$((index+1))

  if [ $index -ge ''${#${wallpapers}[@]} ]; then
      index=0
  fi

  echo $index > $TEMP

  ${wall}"''${${wallpapers}[$index]}"

  exit 0
''
