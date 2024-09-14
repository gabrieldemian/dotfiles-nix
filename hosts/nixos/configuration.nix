# Help is available in the configuration.nix(5) man page
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/battery-notifier.nix
    ../../modules/nixos/ledger.nix
    ../../modules/nixos/cli-tools.nix
    ../../modules/nixos/leisure.nix
    inputs.home-manager.nixosModules.default
  ];

  battery-notifier.enable = true;
  cli-tools.enable = true;
  leisure.enable = true;
  ledger.enable = true;

  boot = {
    blacklistedKernelModules = ["nouveau" "bluetooth" "btusb"];
    initrd.kernelModules = ["nvidia"];
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users = {
    users.gabriel = {
      isNormalUser = true;
      description = "gabriel";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "input"
        "audio"
        "docker"
        "adm"
        "plugdev"
      ];
      shell = pkgs.zsh;
    };

    users.root = {
      shell = pkgs.zsh;
    };
  };

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
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

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};

    users.gabriel = import ./home.nix;
  };

  programs = {
    zsh.enable = true;
    # enable running unpatched dynamic binaries
    nix-ld.enable = true;
    light.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.support32Bit = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    xserver = {
      # for some reason this is enabled by default
      displayManager.lightdm.enable = lib.mkForce false;
      videoDrivers = ["nvidiaBeta"];
      enable = true;
      xkb.layout = "us";
      # √(2560² + 1600²) px / 16 in ≃ 189 dpi
      dpi = 189;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      fira-code
      fira-code-symbols
      liberation_ttf
      nerd-font-patcher
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif"];
        # sansSerif = ["Ubuntu"];
        monospace = ["monospace"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    brave
    firefox
    light
    wl-clipboard
    wireplumber
    pwvucontrol
    texliveFull

    # rust
    rustup
    cargo
    rustc

    transmission_4-gtk

    # screenshare
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
  ];

  system.stateVersion = "23.11";
}
