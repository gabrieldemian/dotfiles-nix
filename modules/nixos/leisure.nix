{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.leisure;
in {
  options.leisure = {
    enable = mkEnableOption "enable leisure";
  };

  config.environment.systemPackages = with pkgs;
    mkIf cfg.enable [
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
}
