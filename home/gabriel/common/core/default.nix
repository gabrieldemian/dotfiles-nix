# Gabriel user config that will be inherited by all hosts
{
  config,
  lib,
  pkgs,
  outputs,
  configLib,
  ...
}: {
  # import everything from curr dir
  imports = (configLib.scanPaths ./.) ++ (builtins.attrValues outputs.homeManagerModules);

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault "gabriel";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      SHELL = "zsh";
      TERM = "rio";
      TERMINAL = "rio";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        pantheon = {
          default = [
            "pantheon"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
        x-cinnamon = {
          default = [
            "xapp"
            "gtk"
          ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/.desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/images";
      videos = "${config.home.homeDirectory}/videos";
      # publicshare = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below
      # templates = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below

      extraConfig = {
        # publicshare and templates defined as null here instead of as options because
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      # Packages that don't have custom configs go here
      
      btop # resource monitor
      copyq # clipboard manager
      coreutils # basic gnu utils
      # curl
      
      eza # ls replacement
      dust # disk usage
      fd # tree style ls
      findutils # find
      fzf # fuzzy search
      jq # JSON pretty printer and manipulator
      nix-tree # nix package tree viewer
      neofetch # fancier system info than pfetch
      ncdu # TUI disk usage
      pciutils
      pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      lazygit
      gum
      glow
      tealdeer
      termshark
      killall
      steam-run # for running non-NixOS-packaged binaries on Nix
      usbutils
      tree # cli dir tree viewer
      unzip # zip extraction
      unrar # rar extraction
      xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
      xdg-user-dirs
      wev # show wayland events. also handy for detecting keypress codes
      wget # downloader
      zip # zip compression
      ;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
