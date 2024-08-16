{config, ...}: {
  config.programs.nixvim.plugins.lspkind = {
    enable = true;
    # cmp = {
    #   enable = true;
    #   maxWidth = 50;
    #   ellipsisChar = ".";
    # };
    mode = "symbol";
    preset = "codicons";
    symbolMap = {
      Text = "󰊄";
      Method = "";
      Function = "󰡱";
      Constructor = "";
      Field = "";
      Variable = "󱀍";
      Class = "";
      Interface = "";
      Module = "󰕳";
      Property = "ﰠ";
      Unit = "";
      Value = "";
      Enum = "";
      Keyword = "";
      Snippet = "";
      Color = "";
      File = "";
      Reference = "";
      Folder = "";
      EnumMember = "";
      Constant = "";
      Struct = "פּ";
      Event = "";
      Operator = "";
      TypeParameter = "";
    };
  };
}
