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

    inputs.home-manager.nixosModules.home-manager
    (builtins.attrValues outputs.nixosModules)

    # -- load users here --
    (configLib.relativeToRoot "common/users/gabriel")
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
