{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.zsh;
in {
  imports = [
    ./starship.nix
  ];

  config.starship.enable = mkDefault true;

  options.zsh = {
    enable = mkEnableOption "enable zsh module";
  };

  config.home.packages = with pkgs;
    mkIf cfg.enable [
      zoxide
    ];

  config.programs.zoxide = mkIf cfg.enable {
    enable = true;
    enableZshIntegration = true;
  };

  config.programs.zsh = mkIf cfg.enable {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    dotDir = ".config/zsh";

    history = {
      save = 1000;
      size = 1000;
      path = "$HOME/.cache/zsh_history";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          # this can be obtained with:
          # nix-prefetch-git <url>
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
    ];
    shellAliases = {
      "docker-clean" = "docker system prune --all -f --volumes";
      # nvim = "nix run ~/.config/nixvim";
    };
  };
}
