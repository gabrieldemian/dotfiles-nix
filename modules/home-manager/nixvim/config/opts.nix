{config, ...}: {
  config.programs.nixvim = {
    globals = {
      mapleader = " ";
    };
    colorschemes.catppuccin.enable = true;
    opts = {
      relativenumber = true;
      termguicolors = true;
      cursorline = true;
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      swapfile = false;
      showmode = false;
    };
  };
}
