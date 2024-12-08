{
  pkgs ? import <nixpkgs> { },
  configLib,
  config,
  ...
}:
let
  name = config.home.username;
  waybar = builtins.toString (configLib.relativeToRoot "home/${name}/common/core/waybar");
  wall = pkgs.callPackage (waybar + "/scripts/wall.nix") { inherit pkgs; };
  wallpapers_dir = builtins.toString (configLib.relativeToRoot "wallpapers");
  wallpaper_select_config = pkgs.writeText "wallpaper_select_config" ''
    prompt=Select wallpaper...
    allow_images=true
    hide_scroll=false
    image_size=700
    width=800
    height=1200
    hide_search=false
    orientation=vertical
    halign=center
    valign=start
  '';
  wallpaper_select_style = pkgs.writeText "wallpaper_select_style" ''
    @import "${config.home.homeDirectory}/.config/wofi/style.css";

    #input {
      display: none;
    }

    #entry:selected {
      border: 0.11em solid @lavender;
      border-radius: 0.5em;
    }

    #img, #entry {
      display: inline;
    }
  '';
in
pkgs.writeScriptBin "select_wallpaper" ''
  #!/usr/bin/env bash

  set -e

  TEMP=/tmp/current_wall

  dir=${wallpapers_dir}
  dmenu_conf=${wallpaper_select_config}
  dmenu_style=${wallpaper_select_style}

  cd "$dir"

  wallpapers=($(${pkgs.fd}/bin/fd -e png -e jpg -e jpeg -e webp --full-path $dir))
  str=""

  for item in "''${wallpapers[@]}" 
  do
    str+="img:$item\n"
  done

  raw_output=$(echo -e "$str" | wofi --show dmenu -c $dmenu_conf -s $dmenu_style)

  # remove the prefix "img:", first 4 characters.
  selected_wallpaper="''${raw_output: 4}"

  idx=0
  i=0

  # find the index of the selected wallpaper
  for f in "''${wallpapers[@]}"; do
    if [ $f = $selected_wallpaper ]; then
      idx=$i
    fi
    i=$(( i + 1 ))
  done

  echo $idx > $TEMP
  ${wall}/bin/wall "$selected_wallpaper"

  exit 0
''
