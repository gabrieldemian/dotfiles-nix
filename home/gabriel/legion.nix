{
  outputs,
  pkgs,
  ...
}: let
  user = "gabriel";
in {
  imports = [
    ./common/core

    ./common/core/bat
    ./common/core/dunst
    ./common/core/fonts
    ./common/core/git
    ./common/core/gtk
    ./common/core/hyprland
    ./common/core/nixvim
    ./common/core/rio
    ./common/core/starship.nix
    ./common/core/waybar
    ./common/core/wofi
    ./common/core/yazi
    ./common/core/zsh
    ./common/optional/browsers
  ];

  outputs.nixosModules.battery-notifier.enable = true;
  outputs.nixosModules.docker.enable = true;

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
