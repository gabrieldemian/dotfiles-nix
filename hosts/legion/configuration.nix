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
}:
let
  user = "gabriel";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

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
        "bluetooth"
      ];
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs user;
    };
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

  services = {
    blueman.enable = true;
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
      videoDrivers = [ "nvidiaBeta" ];
      enable = true;
      xkb.layout = "us";
      # √(2560² + 1600²) px / 16 in ≃ 189 dpi
      dpi = 189;
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
