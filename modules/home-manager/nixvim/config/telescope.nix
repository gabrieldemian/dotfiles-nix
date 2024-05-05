{config, ...}: {
  config.programs.nixvim.plugins.telescope = {
    enable = true;

    keymaps = {
      "ff" = {
        action = "find_files";
      };
      "fg" = {
        action = "live_grep";
      };
      "fd" = {
        action = "diagnostics";
      };
      "sk" = {
        action = "keymaps";
      };
      # file browser actions are
      # handled in ./extra.nix
    };

    extensions = {
      fzf-native = {
        enable = true;
      };
      ui-select = {
        settings = {
          specific_opts = {
            codeactions = true;
          };
        };
      };
      undo = {
        enable = true;
      };
    };
  };
}
