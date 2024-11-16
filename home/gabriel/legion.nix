{
  # nixosModules,
  pkgs,
  ...
}:
let
  user = "gabriel";
in
{
  imports = [
    ./common/core

    ./common/core/bat.nix
    ./common/core/dunst.nix
    ./common/core/fonts.nix
    ./common/core/git.nix
    ./common/core/gtk.nix
    ./common/core/hyprland
    ./common/core/nixvim
    ./common/core/rio.nix
    ./common/core/starship.nix
    ./common/core/waybar
    ./common/core/wofi
    ./common/core/yazi
    ./common/core/zsh.nix
    ./common/optional/browsers
  ];

  # nixosModules.battery-notifier.enable = true;
  # nixosModules.docker.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "23.11";
    packages = with pkgs; [
      cozette
      swww
      nautilus
      zathura
      mpv
      ani-cli
      discord
      imv # image viewer
      neofetch

      # ascii art
      cowsay
      figlet
      lolcat
    ];
  };

  programs = {
    direnv.enable = true;
    direnv.enableZshIntegration = true;
  };
}
