{config, ...}: {
  config.programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = false;
    updateInInsert = false;
    # onAttach = ''
    #   function(client, bufnr)
    #       if client.supports_method "textDocument/formatting" then
    #         vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    #       end
    #     end
    # '';
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        checkstyle = {
          enable = true;
        };
        statix = {
          enable = true;
        };
      };
      formatting = {
        alejandra = {
          enable = true;
        };
        prettierd = {
          enable = true;
        };
        stylua = {
          enable = true;
        };
        # rustywind = {
        #   enable = true;
        # };
      };
    };
  };
}
