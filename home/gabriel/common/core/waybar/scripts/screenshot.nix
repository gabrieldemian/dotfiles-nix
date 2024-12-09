{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.writeScriptBin "screenshot" ''
  #!/usr/bin/env bash

  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
''
