# Help is available in the configuration.nix(5) man page
#
# Configuration of my lenovo LNVNB161216, I9 and nvidia rtx 4070
#
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  # the only user of the machine, will be inherited by all modules that require it, as well as home-manager
  user = "gabriel";
  pixelcode = pkgs.callPackage ../../derivations/pixelcode.nix {};
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/battery-notifier.nix
    ../../modules/nixos/ledger.nix
    ../../modules/nixos/cli-tools.nix
    ../../modules/nixos/leisure.nix
    ../../modules/nixos/docker.nix
    inputs.home-manager.nixosModules.default
  ];

  battery-notifier.enable = true;
  cli-tools.enable = true;
  leisure.enable = true;
  ledger.enable = true;
  docker.enable = true;
  docker.user = user;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [];
    kernelParams = ["nvidia_drm.fbdev=1" "nvidia_drm.modeset=1"];
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
    users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "input"
        "audio"
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
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
      WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      GBM_BACKEND = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0";
      WLR_DRM_NO_ATOMIC = "1";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      GDK_SCALE = "2";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      NVD_BACKEND = "direct";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs user;};

    users.${user} = import ./home.nix;
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

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      ];
    };
    nvidia = {
      # prime = {
      #   offload = {
      #     enable = true;
      #     enableOffloadCmd = true;
      #   };
      #   intelBusId = "PCI:0:2:0";
      #   nvidiaBusId = "PCI:01:00:0";
      # };
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services = {
    dbus.enable = true;
    blueman.enable = true;
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
      videoDrivers = ["nvidia"];
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
      cherry
      monaspace
      pixelcode
      terminus_font
      fira-code
      fira-code-symbols
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FiraCode"];})
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
    timg
    postman
    lshw
    inxi

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
