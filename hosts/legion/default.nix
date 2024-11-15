{
  inputs,
  lib,
  configLib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix

    (map configLib.relativeToRoot [
      "common/core"

      # "common/optional/services/openssh.nix" # allow remote SSH access
      "common/optional/audio.nix" # pipewire and cli controls
      # "common/optional/gaming.nix" # steam, gamescope, gamemode, and related hardware

      "common/optional/hyprland.nix" # window manager
      "common/optional/wayland.nix" # wayland components and pkgs not available in home-manager
    ])
  ];

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    initrd.kernelModules = [ "nvidia" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs = {
    light.enable = true;
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
      videoDrivers = [ "nvidiaBeta" ];
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
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "565.57.01";
        sha256_64bit = "";
        sha256_aarch64 = "";
        openSha256 = "";
        settingsSha256 = "";
        persistencedSha256 = "";
      };
    };
  };

  system.stateVersion = "23.11";
}
