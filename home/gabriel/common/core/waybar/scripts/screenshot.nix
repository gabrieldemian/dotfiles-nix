{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.writeScriptBin "screenshot" ''
  #!/usr/bin/env bash

  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
''
# grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
