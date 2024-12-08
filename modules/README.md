# modules

## What

A module is used to share reusable code, it's function that return an expression, it looks something like this:

```nix
{ pkgs, ... }: {
    # return whatever
}
```

`modules/home-manager`: everything about home manager, everything that must live under `/home`.

`modules/nixos`: system-level modules for nixos.
