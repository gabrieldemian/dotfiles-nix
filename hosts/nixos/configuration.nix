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
    inputs.home-manager.nixosModules.default
  ];

  battery-notifier.enable = true;

  boot = {
    blacklistedKernelModules = ["nouveau" "bluetooth" "btusb"];
    initrd.kernelModules = ["nvidia"];
    # kernelPackages = pkgs.linuxPackages_6_8;
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    loader = {
      systemd-boot.enable = true;
      # grub = {
      # configurationLimit = 5;
      #   enable = true;
      #   efiSupport = true;
      #   device = "nodev";
      # };
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

  # Set your time zone.
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
    # mtr.enable = true;
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

    greetd = {
      enable = false;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "gabriel";
        };
        default_session = initial_session;
      };
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

    udev.extraRules = ''
      # HW.1, Nano
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c|2b7c|3b7c|4b7c", TAG+="uaccess", TAG+="udev-acl"

      # Blue, NanoS, Aramis, HW.2, Nano X, NanoSP, Stax, Ledger Test,
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"

      # Same, but with hidraw-based library (instead of libusb)
      KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
    '';
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
      # fira-code-symbols
      # mplus-outline-fonts.githubRelease
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

  environment.etc."greetd/environments".text = ''
    hyprland
    bash
    zsh
  '';

  environment.systemPackages = with pkgs; [
    # essential
    brave
    firefox
    vim
    wget
    git
    neofetch
    lolcat
    zathura
    mpv
    wl-clipboard
    grim
    slurp
    light
    curl
    ani-cli # uwu
    wireplumber
    pwvucontrol
    nix-prefetch-git
    killall
    texliveFull
    imv # image viewer
    cowsay
    figlet
    discord
    eza # cool ls

    # cli tools for dev
    bun
    htop
    bottom
    yarn
    unzip
    lazygit
    gum
    glow
    tealdeer
    termshark

    # rust
    rustup
    cargo
    rustc

    ledger-live-desktop
    transmission_4-gtk

    # screenshare
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
  ];

  system.stateVersion = "23.11";
}
