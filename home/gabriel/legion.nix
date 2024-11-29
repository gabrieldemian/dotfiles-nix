{
  ...
}:
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
}
