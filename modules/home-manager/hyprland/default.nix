{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hyprland;
in {
  options.hyprland = {
    enable = mkEnableOption "enable hyprland";
  };

  config.wayland.windowManager.hyprland = mkIf cfg.enable {
    enable = true;
    xwayland = {
      enable = true;
    };

    # Whether to enable hyprland-session.target on hyprland startup
    # systemd.enable = true;

    settings = {
      monitor = "eDP-1,2560x1600@240,auto,1";
      exec-once = "dunst & swww-daemon & waybar & swww img ../../../wallpapers/girl.png &";

      "$terminal" = "rio";
      "$fileManager" = "rio -e yazi";
      "$menu" = "wofi";
      "$mod" = "SUPER";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "WLR_DRM_NO_ATOMIC,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
        repeat_rate = 50;
        repeat_delay = 250;
      };

      general = {
        allow_tearing = false;
        gaps_in = 8;
        gaps_out = 12;
        border_size = 4;
        "col.active_border" = "rgba(c6a0f6ee) rgba(ed8796ee) 45deg";
        "col.inactive_border" = "transparent";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures.workspace_swipe = "off";

      misc.force_default_wallpaper = -1;

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      windowrulev2 = [
        "float,class:^(nautilus)$,title:^(nautilus)$"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          # essential
          "$mod, Return, exec, $terminal"
          "$mod, W, killactive"
          "$mod, M, exit"
          "$mod, Space, exec, $menu --show drun"
          "$mod, E, exec, [float;center;size 60% 60%] $fileManager"
          # floating terminal
          "$mod SHIFT, Return, exec, [float;center;size 45% 35%] rio"
          #volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          # toggles
          "$mod, P, pseudo," # dwindle
          "$mod, V, togglefloating,"
          "$mod, T, togglesplit," # dwindle
          "$mod, F, fullscreen,"
          # switch
          "$mod SHIFT, h, swapwindow, l"
          "$mod SHIFT, l, swapwindow, r"
          "$mod SHIFT, j, swapwindow, d"
          "$mod SHIFT, k, swapwindow, u"
          # move focus with mod + hjkl
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          # Light
          ",code:232,exec,light -U 2"
          ",code:233,exec,light -A 2"
          # Example special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          # Scroll through existing workspaces with mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          # Toggle game mode to disable animations
          "$mod CTRL SHIFT, 0, exec, ~/dotfiles/modules/home-manager/hyprland/scripts/gamemode.sh"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
