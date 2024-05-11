# Help is available in the configuration.nix(5) man page
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    #kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    #kernelParams = [ "acpi_backlight=video" ];
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
      extraGroups = ["networkmanager" "wheel" "video" "input" "audio" "docker"];
      shell = pkgs.zsh;
    };

    users.root = {
      shell = pkgs.zsh;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.gabriel = import ./home.nix;
  };

  programs = {
    zsh.enable = true;
    light.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  virtualisation.docker.enable = true;

  security.rtkit.enable = true;

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      videoDrivers = ["nvidia"];
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
    };
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

    # cli tools for dev
    htop
    bottom
    ripgrep
    bat
    cargo-tauri
    direnv
    yarn
    unzip
    # nodejs_21
    lazygit

    # rust
    cargo
    rustc
  ];

  system.stateVersion = "23.11";
}
