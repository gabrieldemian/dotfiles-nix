{pkgs, ...}: {
  config.programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-ui-select-nvim
      lazygit-nvim
      catppuccin-nvim
    ];

    extraConfigLua = ''
      local Map = vim.keymap.set

      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
        },
      })

      local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
      end

      Map("n", "<leader>lg", ": LazyGit<cr>")

      local builtin = require("telescope.builtin")
      local telescope = require("telescope")

      telescope.load_extension("ui-select")
    '';
  };
}
