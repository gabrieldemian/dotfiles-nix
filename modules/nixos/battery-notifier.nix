{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.battery-notifier;
in {
  options.battery-notifier = {
    enable = mkEnableOption "enable battery-notifier";
  };

  # Regularly check battery status
  config.systemd.user.services.battery-notifier = mkIf cfg.enable {
    enable = true;
    description = "Battery notifier";
    wants = ["display-manager.service"];
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      type = "notify";
    };
    script = ''
      prev_val=100
      check () { [[ $1 -ge $val ]] && [[ $1 -lt $prev_val ]]; }
      notify () {
        ${pkgs.libnotify}/bin/notify-send -a Battery "$@" \
          -h "int:value:$val" "Discharging" "$val%"
      }
      while true; do
        val=$(cat /sys/class/power_supply/BAT0/capacity);
        if check 30 || check 25 || check 20; then notify
          elif check 15 || [[ $val -le 10 ]]; then notify -u critical
        fi
        prev_val=$val
        # Sleep longer when battery is high to save CPU
        if [[ $val -gt 30 ]]; then sleep 10m; elif [[ $val -ge 20 ]]; then sleep 5m; else sleep 1m; fi
      done
    '';
  };
}
