{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      #   serif = ["Liberation Serif"];
      #   # sansSerif = ["Ubuntu"];
      #   monospace = ["monospace"];
      #   emoji = ["Noto Color Emoji"];
    };
  };
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    meslo-lgs-nf
    pixelcode
  ];
}
