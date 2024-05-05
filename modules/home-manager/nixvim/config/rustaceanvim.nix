{config, ...}: {
  config.programs.nixvim.plugins.rust-tools = {
    enable = true;
    # server = {
    #   onAttach = ''        function(client, bufnr)
    #             require("lsp-inlayhints").on_attach(client, bufnr)
    #             Map("n", "<leader>h", function()
    #               require("lsp-inlayhints").toggle()
    #             end)
    #           end'';
    # };
    inlayHints = {
      auto = true;
      # enable = true;
    };
    server = {
      diagnostics.enable = true;
    };
  };
}
