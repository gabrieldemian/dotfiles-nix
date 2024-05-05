{
  pkgs,
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

  # config.services.xserver = mkIf cfg.enable {
  #   displayManager.gdm.enable = true;
  #   displayManager.gdm.wayland = true;
  # };

  # config.programs.wofi.enable = mkIf cfg.enable true;

  config.wayland.windowManager.hyprland = mkIf cfg.enable {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = "eDP-1,2560x1600,auto,1";
      exec-once = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & dunst & swww-daemon & waybar & swww img ../../../wallpapers/girl.png &";

      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "anyrun";
      "$mainMod" = "SUPER";

      env = ["XCURSOR_SIZE,24" "WLR_DRM_NO_ATOMIC,1"];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
        repeat_rate = 50;
        repeat_delay = 250;
      };

      general = {
        allow_tearing = true;
        gaps_in = 8;
        gaps_out = 12;
        border_size = 4;
        # col = {
        #   active_border = "rgba(c6a0f6ee) rgba(ed8796ee) 45deg";
        #   inactive_border = "transparent";
        # };
        layout = "dwindle";
        apply_sens_to_raw = 0; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      };

      decoration = {
        # col = {
        #   shadow = "rgba (1 a1a1aee)";
        #   shadow_inactive = "rgba(22000000)";
        # };
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
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

      master.new_is_master = true;

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
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        # essential
        "$mainMod, Return, exec, $terminal"
        "$mainMod, W, killactive"
        "$mainMod, M, exit"
        "$mainMod, Space, exec, $menu"
        "$mainMod, E, exec, [float;center;size 45% 45%] $fileManager"
        # floating terminal
        "$mainMod SHIFT, Return, exec, [float;center;size 45% 35%] kitty"
        #volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # toggles
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, V, togglefloating,"
        "$mainMod, T, togglesplit," # dwindle
        "$mainMod, F, fullscreen,"
        # switch
        "$mainMod SHIFT, h, swapwindow, l"
        "$mainMod SHIFT, l, swapwindow, r"
        "$mainMod SHIFT, j, swapwindow, d"
        "$mainMod SHIFT, k, swapwindow, u"
        # move focus with mainMod + hjkl
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Light
        ",code:232,exec,light -U 5"
        ",code:233,exec,light -A 5"
        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # Toggle game mode to disable animations
        "$mainMod CTRL SHIFT, 0, exec, ~/dotfiles/modules/home-manager/hyprland/scripts/gamemode.sh"
      ];
    };
  };
}
