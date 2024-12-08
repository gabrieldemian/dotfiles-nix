{ ... }:
{
  config.programs.nixvim.keymaps = [
    # move in insert mode with hjkl
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-h>";
      action = "<Left>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-j>";
      action = "<Down>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-k>";
      action = "<Up>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-l>";
      action = "<Right>";
    }
    # keep cursor in place
    {
      mode = "x";
      key = "<leader>p";
      action = "_dP";
    }
    # copy to clipboard
    {
      mode = "n";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "v";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = "\"+Y";
    }
    {
      mode = "n";
      key = "x";
      action = "\"_x";
    }
    {
      mode = "n";
      key = "x";
      action = "\"_x";
    }
    # files
    {
      mode = "n";
      key = "WW";
      action = ":w!<enter>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "QQ";
      action = ":q!<enter>";
    }
    {
      mode = "n";
      key = "TT";
      action = ":TransparentToggle<CR>";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
    }
    # lspsaga keys
    {
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<cr>";
    }
    {
      key = "<leader>bf";
      action = "<cmd>Lspsaga show_buf_diagnostics<cr>";
    }
    {
      key = "<C-j>";
      action = "<cmd>Lspsaga diagnostic_jump_next<cr>";
    }
    {
      key = "<leader>d";
      action = "<cmd>Lspsaga show_line_diagnostics<cr>";
    }
    {
      key = "gT";
      action = "<cmd>Lspsaga goto_type_definition<cr>";
    }
    {
      key = "gt";
      action = "<cmd>Lspsaga peek_type_definition<cr>";
    }
    {
      key = "gD";
      action = "<cmd>Lspsaga goto_definition<cr>";
    }
    {
      key = "gd";
      action = "<cmd>Lspsaga peek_definition<cr>";
    }
    {
      key = "K";
      action = "<cmd>Lspsaga hover_doc<cr>";
    }
    {
      mode = [ "x" ];
      key = "<C-k>";
      action = "<cmd>lua vim.lsp.buf.signature_help<cr>";
    }
    {
      key = "<leader>rn";
      action = "<cmd>Lspsaga rename<cr>";
    }
    {
      key = "gh";
      action = "<cmd>Lspsaga finder<cr>";
    }
    # bufferline keys
    {
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
    }
    {
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
    }
    {
      key = "<C-p>";
      action = "<cmd>BufferLinePick<cr>";
    }
    {
      key = "<leader>1";
      action = "<cmd>BufferLineGoToBuffer 1<cr>";
    }
    {
      key = "<leader>2";
      action = "<cmd>BufferLineGoToBuffer 2<cr>";
    }
    {
      key = "<leader>3";
      action = "<cmd>BufferLineGoToBuffer 3<cr>";
    }
    {
      key = "<leader>4";
      action = "<cmd>BufferLineGoToBuffer 4<cr>";
    }
    {
      key = "<leader>5";
      action = "<cmd>BufferLineGoToBuffer 5<cr>";
    }
    {
      key = "<leader>6";
      action = "<cmd>BufferLineGoToBuffer 6<cr>";
    }
    {
      key = "<leader>7";
      action = "<cmd>BufferLineGoToBuffer 7<cr>";
    }
    {
      key = "<leader>8";
      action = "<cmd>BufferLineGoToBuffer 8<cr>";
    }
    {
      key = "<leader>9";
      action = "<cmd>BufferLineGoToBuffer 9<cr>";
    }
    # transparent keys
    {
      key = "TT";
      action = ":TransparentToggle<cr>";
      options.silent = true;
    }
    # zenmode keys
    {
      key = "<C-w>o";
      action = ":Zen<cr>";
      options.silent = true;
    }
    # gitsigns keys
    {
      key = "<leader>gs";
      action = ":Gitsigns stage_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gu";
      action = ":Gitsigns undo_stage_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gS";
      action = ":Gitsigns stage_buffer<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gr";
      action = ":Gitsigns reset_buffer<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gp";
      action = ":Gitsigns preview_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gd";
      action = ":Gitsigns diffthis<cr>";
      options.silent = true;
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "<leader>gh";
      action = ":<C-U>Gitsigns select_hunk<cr>";
    }
    # oil
    {
      key = "<leader>-";
      action = ":Oil<cr>";
      options.silent = true;
    }
    # floaterm
    {
      key = "<leader>t";
      action = ":FloatermNew --width=0.6 --height=0.4<cr>";
      options.silent = true;
    }
    # expand macro
    {
      key = "<leader>em";
      action = ":RustLsp expandMacro <cr>";
      options.silent = true;
    }
  ];
}
