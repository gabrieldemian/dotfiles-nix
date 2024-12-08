# You can build these directly using 'nix build .#example'
{
  pkgs ? import <nixpkgs> { },
}:
{
  pixelcode = pkgs.callPackage ./pixelcode.nix { };
  mondwest = pkgs.callPackage ./mondwest.nix { };
  neuebit = pkgs.callPackage ./neuebit.nix { };
}
