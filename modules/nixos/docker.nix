{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.docker;
in {
  options = {
    docker.enable = mkEnableOption "enable docker";
    docker.user = mkOption {
      type = types.str;
      description = "the user to add the docker group to";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      extraGroups = ["docker"];
    };

    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
