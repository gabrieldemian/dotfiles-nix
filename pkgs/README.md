# pkgs

## What?
Custom packages / derivations.

These packages will be merged to the `pkgs` attribute set.

## Why?

In this way, all of the official packages and custom packages will be accessed from the same set, instead of having one set per custom package, and passed around as an argument throughout the configuration.

Without this merging, one would have to use `pkgs.callPackage` to reference custom pkgs / derivations.
