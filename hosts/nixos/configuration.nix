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
      packages = with pkgs; [];
      shell = pkgs.zsh;
    };

    users.root = {
      shell = pkgs.zsh;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "nvim";
    };
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
    light.enable = true;
    neovim.defaultEditor = true;
    zsh.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    waybar.enable = true;
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
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver = {
    videoDrivers = ["nvidia"];
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    xkb.layout = "us";
    xkb.variant = "";
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
    kitty
    waybar
    swww
    wofi
    dunst
    vim
    wget
    neovim
    git
    neofetch
    lolcat
    starship
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

    # fix screen sharing
    xdg-desktop-portal-hyprland

    # cli tools for dev
    htop
    bottom
    ripgrep
    bat
    zoxide
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
