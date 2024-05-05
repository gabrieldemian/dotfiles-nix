{config, ...}: {
  config.programs.nixvim.plugins.bufferline = {
    enable = true;
    mode = "tabs";
    extraOptions = {
      highlights = ''require("catppuccin.groups.integrations.bufferline").get()'';
    };
  };
}
