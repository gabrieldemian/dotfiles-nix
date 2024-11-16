{
  pkgs ? import <nixpkgs> { },
  cooldown ? "0.1",
  # directory with wallpapers
  wallpapers,
  ...
}:
let
  wall = pkgs.callPackage ./wall.nix { };
  scripts = ./.;
in
pkgs.writeScriptBin "expand" ''
  #!/usr/bin/env bash

  while true
  do
      case "$1" in
          "cycle")
              index=$(cat $TEMP)
              index=$((index+1))
              if [ $index -ge ''${#${wallpapers}[@]} ]; then
                  index=0
              fi
              echo $index > $TEMP
              ${wall}"''${${wallpapers}[$index]}"
              exit 0
              ;;
          "arrow-icon")
              if ${scripts}/toolbar_state.sh; then
                  echo ""
              else
                  echo ""
              fi
              ;;
          "ss-icon")
              if ${scripts}/toolbar_state.sh; then
                  echo ""
              else
                  echo ""
              fi
              ;;
          "wall-icon")
              if ${scripts}/toolbar_state.sh; then
                  echo "󰟾󰸉"
              else
                  echo ""
              fi
              ;;
          *)
              if ${scripts}/toolbar_state.sh; then
                  echo "     "
              else
                  echo ""
              fi
              ;;
      esac
      sleep ${cooldown}
  done
''
