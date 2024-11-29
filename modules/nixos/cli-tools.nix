{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.cli-tools;
in
{
  options.cli-tools = {
    enable = mkEnableOption "enable cli-tools";
  };

  config.environment.systemPackages =
    with pkgs;
    mkIf cfg.enable [
      grim # grab images from wayland compositor
      slurp # select area screenshot

      # soydev
      bun
      yarn

      # nix stuff
      nix-prefetch-git

      # cli productivity
      ripgrep
      fd
      jq
      eza
      htop
      bottom
      unzip
      lazygit
      gum
      glow
      tealdeer
      termshark
      grpcurl
      postman
      zellij

      # essential
      vim
      wget
      curl
      git
      killall
    ];
}
