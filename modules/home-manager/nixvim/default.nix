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
    plugins = {
      treesitter.enable = true;
      autoclose.enable = true;
      comment.enable = true;
      nvim-colorizer.enable = true;
      leap.enable = true;
      luasnip.enable = true;
      ts-autotag.enable = true;
      zen-mode.enable = true;
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
      illuminate = {
        enable = false;
        underCursor = false;
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
