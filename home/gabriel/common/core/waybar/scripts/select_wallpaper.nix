{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.writeScriptBin "select_wallpaper" ''
  #!/usr/bin/env bash
''
