{...}: {
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
      "fz" = {
        action = "current_buffer_fuzzy_find";
      };
      "ft" = {
        action = "find_tags";
      };
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
