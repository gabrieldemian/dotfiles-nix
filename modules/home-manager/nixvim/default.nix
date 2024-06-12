{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config/opts.nix
    ./config/extra.nix
    ./config/trouble.nix
    ./config/lualine.nix
    ./config/conform.nix
    ./config/transparent.nix
    ./config/lsp/lsp.nix
    ./config/lsp/lspkind.nix
    ./config/lsp/lspsaga.nix
    ./config/telescope.nix
    ./config/none-ls.nix
    ./config/bufferline.nix
    ./config/rustaceanvim.nix
    ./config/cmp.nix
    ./config/keymaps.nix
  ];

  options.nixvim = {
    enable = mkEnableOption "enable nixvim";
  };

  config.programs.nixvim = mkIf cfg.enable {
    enable = true;

    # plugins that don't deserve their own module
    plugins = {
      texpresso.enable = true;
      indent-blankline.enable = true;
      gitsigns.enable = true;
      surround.enable = true;
      nvim-autopairs.enable = true;
      treesitter.enable = true;
      autoclose.enable = true;
      comment.enable = true;
      nvim-colorizer.enable = true;
      leap.enable = true;
      luasnip.enable = true;
      ts-autotag.enable = true;
      zen-mode.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          columns = ["icon"];
          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-s>" = "actions.select_vsplit";
            "<C-h>" = "actions.select_split";
            "<C-t>" = "actions.select_tab";
            "<C-p>" = "actions.preview";
            "<C-c>" = "actions.close";
            "<C-l>" = "actions.refresh";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "gs" = "actions.change_sort";
            "gx" = "actions.open_external";
            "g." = "actions.toggle_hidden";
            "g\\" = "actions.toggle_trash";
          };
        };
      };
      fidget = {
        enable = true;
        extraOptions = {
          notification = {
            window = {
              winblend = 0;
            };
          };
        };
      };
      gitsigns.settings = {
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
        current_line_blame = false;
      };
      illuminate = {
        enable = true;
        underCursor = true;
        filetypesDenylist = [
          "DressingSelect"
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "toggleterm"
          "neo-tree"
          "Spectre"
          "reason"
        ];
      };
    };
  };

  config.programs.neovim.defaultEditor = mkIf cfg.enable true;
}
