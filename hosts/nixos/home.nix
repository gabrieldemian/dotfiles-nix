{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/hyprland/default.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/dunst.nix
    ../../modules/home-manager/nixvim/default.nix
  ];

  zsh.enable = true;
  hyprland.enable = true;
  waybar.enable = true;
  kitty.enable = true;
  dunst.enable = true;
  nixvim.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

    packages = with pkgs; [
      # fix screen sharing
      xdg-desktop-portal-hyprland
      swww
      anyrun
      gnome.nautilus
    ];
  };

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
  };
}
