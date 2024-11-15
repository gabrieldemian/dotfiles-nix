{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.lemurs;
in
{
  options.lemurs = {
    enable = mkEnableOption "enable lemurs";
  };

  config.environment.etc."lemurs/config.toml".text = ''
    [password_field]
    content_replacement_character = "$replacement_char"

    [password_field.style]
    show_title = "$show_pw_title"
    title = "$password_title"
    title_color = "$title_color"
  '';

  config.environment.etc."lemurs/variables.toml".text = ''
    replacement_char = "+"
    show_pw_title = true
    password_title = "Password"
    title_color = "white"
  '';

  config.environment.etc."lemurs/wayland/hyprland" = {
    text = ''
      #!/usr/bin/env bash
      exec Hyprland
    '';
    mode = "0555";
  };

  config.environment.systemPackages = mkIf cfg.enable [ pkgs.lemurs ];

  config.services.xserver.displayManager = mkIf cfg.enable {
    sessionCommands = ''
      ${pkgs.lemurs}/bin/lemurs &
    '';
  };
}
