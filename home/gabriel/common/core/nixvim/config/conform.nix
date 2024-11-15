{ config, ... }:
{
  config.programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formattersByFt = {
        html = [
          [
            "biome"
            "prettier"
          ]
        ];
        css = [
          [
            "biome"
            "prettier"
          ]
        ];
        javascript = [
          [
            "biome"
            "prettier"
          ]
        ];
        javascriptreact = [
          [
            "biome"
            "prettier"
          ]
        ];
        typescript = [
          [
            "biome"
            "prettier"
          ]
        ];
        typescriptreact = [
          [
            "biome"
            "prettier"
          ]
        ];
        java = [ "google-java-format" ];
        python = [ "black" ];
        lua = [ "stylua" ];
        toml = [ "taplo" ];
        nix = [ "alejandra" ];
        rust = [ "rustfmt" ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Buffer";
        };
      }
      {
        mode = "v";
        key = "<leader>cF";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Lines";
        };
      }
    ];
  };
}
