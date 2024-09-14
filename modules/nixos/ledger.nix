{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.ledger;
in {
  options.ledger = {
    enable = mkEnableOption "enable ledger";
  };

  config.services.udev.extraRules = mkIf cfg.enable ''
    # HW.1, Nano
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c|2b7c|3b7c|4b7c", TAG+="uaccess", TAG+="udev-acl"

    # Blue, NanoS, Aramis, HW.2, Nano X, NanoSP, Stax, Ledger Test,
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"

    # Same, but with hidraw-based library (instead of libusb)
    KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
  '';

  config.environment.systemPackages = with pkgs;
    mkIf cfg.enable [
      ledger-live-desktop
    ];
}
