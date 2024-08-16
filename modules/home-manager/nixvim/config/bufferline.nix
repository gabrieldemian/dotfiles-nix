{config, ...}: {
  config.programs.nixvim.plugins.bufferline = {
    enable = true;
    settings.options.mode = "tabs";
    settings.options = {
      highlights = ''require("catppuccin.groups.integrations.bufferline").get()'';
    };
  };
}
