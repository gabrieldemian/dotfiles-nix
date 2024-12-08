# Lombardo's Dotfiles

A multi-host multi-user config.

Mostly stolen from [this config](https://github.com/EmergentMind/nix-config/tree/dev)

Still a work in progress.

```
 ╭─ wallpapers           -> frieren supremacy
 ├─ flake.nix            -> entry point
 ├─ hosts                -> machines (only one so far "legion")
 ├─ common               -> everything that is shared between hosts, users, programs, etc.
 ├─ pkgs                 -> custom pkgs/derivations
 ├─ fonts                -> source of obscure fonts that I couldn't find on nixpkgs
 ├─ overlays             -> overlays and overrides, not really used
 ├─ lib                  -> utility functions, etc
 ├─ modules/home-manager -> reusable home-manager modules
 ╰─ modules/nixos        -> reusable nixos modules
```

## Main host (legion)
```
 ╭─ distro     -> nixos
 ├─ model      -> LENOVO LNVNB161216
 ├─ CPU        -> 13th Gen Intel i9-13900HX (8) @ 5.400GHz
 ├─ GPU        -> NVIDIA GeForce RTX 4070
 ╰─ resolution -> 2560x1600@244hz
```

## Preview
| ![image](https://github.com/user-attachments/assets/8df80d79-3c69-44fb-a108-92348a142e4d) |
|:--:| 
| *Changing the wallpaper* |
