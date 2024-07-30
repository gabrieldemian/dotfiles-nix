{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.yazii;
  ctp = builtins.fetchGit {
    url = "https://github.com/yazi-rs/flavors";
    rev = "2d7dd2afe253c30943e9cd05158b1560a285eeab";
  };
in {
  options.yazii = {
    enable = mkEnableOption "enable yazi module";
  };

  config.programs.yazi = mkIf cfg.enable {
    enable = true;
    enableZshIntegration = true;
    flavors = {
      "catppuccin-mocha" = "${ctp}/catppuccin-mocha.yazi";
    };
    theme = {
      flavor = {
        use = "catppuccin-mocha";
      };
    };
  };
}
