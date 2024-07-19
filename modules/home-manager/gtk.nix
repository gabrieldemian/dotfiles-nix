{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.gtkk;
in {
  options.gtkk = {
    enable = mkEnableOption "enable gtk module";
  };

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme.name = "Catppuccin";
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
    };
    home = {
      packages = with pkgs; [
        breeze-icons
      ];
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
      sessionVariables = {
        #   XCURSOR_SIZE = "24";
        GTK_USE_PORTAL = "1";
      };
    };
    xdg.configFile = {
      "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.kvconfig";
        sha256 = "0pl936nchif2zsgzy4asrlc3gvv4fv2ln2myrqx13r6xra1vkcqs";
      };
      "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Frappe-Pink/Catppuccin-Frappe-Pink.svg";
        sha256 = "1b92j0gb65l2pvrf90inskr507a1kwin1zy0grwcsdyjmrm5yjrv";
      };
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=catppuccin

        [Applications]
        catppuccin=qt5ct, org.qbittorrent.qBittorrent, hyprland-share-picker
      '';
    };
  };
}
