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
    blacklistedKernelModules = ["nouveau"];
    initrd.kernelModules = ["nvidia"];
    kernelPackages = pkgs.linuxPackages_6_8;
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

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Enable networking
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
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
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # GBM_BACKEND = "nvidia-drm";
      # __GL_GSYNC_ALLOWED = "0";
      # __GL_VRR_ALLOWED = "0";
      # DISABLE_QT5_COMPAT = "0";
      # ANKI_WAYLAND = "1";
      # DIRENV_LOG_FORMAT = "";
      # WLR_DRM_NO_ATOMIC = "1";
      # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # GTK_USE_PORTAL = "1";
      # QT_QPA_PLATFORM = "wayland";
      # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      # MOZ_ENABLE_WAYLAND = "1";
      # WLR_BACKEND = "vulkan";
      # WLR_NO_HARDWARE_CURSORS = "1";
      # XDG_SESSION_TYPE = "wayland";
      # CLUTTER_BACKEND = "wayland";
      # # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.gabriel = import ./home.nix;
  };

  programs = {
    zsh.enable = true;
    light.enable = true;
    dconf.enable = true;
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  virtualisation.docker.enable = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    opengl = {
      # extraPackages = with pkgs; [
      #   vaapiVdpau
      #   libvdpau-va-gl
      # ];
      # setLdLibraryPath = true;
      # extraPackages32 = with pkgs.pkgsi686Linux; [libva];
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.42.02";
      #   sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      #   sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      #   openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      #   settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      #   persistencedSha256 = lib.fakeSha256;
      # };
      # package = config.boot.kernelPackages.nvidiaPackages.beta.overrideAttrs {
      #   version = "555.42.02";
      #   src =
      #     pkgs.fetchurl
      #     {
      #       url = "https://download.nvidia.com/XFree86/Linux-x86_64/555.42.02/NVIDIA-Linux-x86_64-555.42.02.run";
      #       sha256 = "";
      #     };
      # };
      # prime = {
      #   intelBusId = "PCI:00:02:0";
      #   nvidiaBusId = "PCI:01:00:0";
      # };
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
      enable = true;
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
      # displayManager.gdm = {
      #   enable = true;
      #   wayland = true;
      # };
      # autorun = false;
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

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
  ];

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

    # cli tools for dev
    bun
    htop
    bottom
    ripgrep
    bat
    cargo-tauri
    direnv
    yarn
    unzip
    lazygit
    gum
    glow
    tealdeer

    # rust
    cargo
    rustc

    ledger-live-desktop
    transmission-gtk

    # screenshare
    # xwaylandvideobridge
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
  ];

  system.stateVersion = "23.11";
}
