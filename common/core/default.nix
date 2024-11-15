# common to all hosts: import home-manager, declare overlays, etc.
{
  lib,
  inputs,
  outputs,
  configLib,
  ...
}:
{
  imports = lib.flatten [
    # import everything on curr dir ./
    (configLib.scanPaths ./.)

    # -- load users here --
    (configLib.relativeToRoot "common/users/gabriel")

    inputs.home-manager.nixosModules.home-manager
    (builtins.attrValues outputs.nixosModules)
  ];

  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    # merge the custom `pkgs` into the official nixpkgs.pkgs
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
}
