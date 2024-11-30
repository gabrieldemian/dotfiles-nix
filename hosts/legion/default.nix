{
  lib,
  configLib,
  config,
  outputs,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix

    outputs.nixosModules.ledger
    outputs.nixosModules.docker

    (map configLib.relativeToRoot [
      # load users and other things common to all hosts
      "common/core"

      # programs that this host will have
      # without any user configuration

      # "common/optional/services/openssh.nix" # allow remote SSH access
      "common/optional/audio.nix" # pipewire and cli controls
      # "common/optional/gaming.nix" # steam, gamescope, gamemode, and related hardware

      "common/optional/hyprland.nix" # window manager
      "common/optional/wayland.nix" # wayland components and pkgs not available in home-manager
    ])
  ];

  environment = {
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

  boot = {
    blacklistedKernelModules = [ ];
    initrd.kernelModules = [ "nvidia" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs = {
    light.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking = {
    hostName = "legion";
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
  };

  services = {
    blueman.enable = true;
    dbus.enable = true;
    xserver = {
      # for some reason this is enabled by default
      displayManager.lightdm.enable = lib.mkForce false;
      videoDrivers = [ "nvidia" ];
      enable = true;
      xkb.layout = "us";
      # √(2560² + 1600²) px / 16 in ≃ 189 dpi
      dpi = 189;
    };
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  system.stateVersion = "23.11";
}
