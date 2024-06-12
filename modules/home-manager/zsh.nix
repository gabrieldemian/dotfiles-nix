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

  options.zsh = {
    enable = mkEnableOption "enable zsh module";
  };

  config.starship.enable = mkDefault true;

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
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles";
      "docker-clean" = "docker system prune --all -f --volumes";
      gc = "git commit -m";
      gca = "git commit -a -m";
      gp = "git push origin HEAD";
      gpu = "git pull origin";
      glog = "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
      nix-clean = "sudo nix-collect-garbage --delete-older-than";
    };
  };
}
