# You can build these directly using 'nix build .#example'
{
  pkgs ? import <nixpkgs> { },
}:
{
  pixelcode = pkgs.callPackage ./pixelcode { };
  mondwest = pkgs.callPackage ./mondwest { };
  neuebit = pkgs.callPackage ./neuebit { };
}
