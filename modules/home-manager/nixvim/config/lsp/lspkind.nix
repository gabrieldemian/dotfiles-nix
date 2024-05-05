{config, ...}: {
  config.programs.nixvim.plugins.lspkind = {
    enable = true;
    mode = "symbol";
    preset = "codicons";
    symbolMap = {
      Text = "";
      Method = "";
      Function = "";
      Constructor = "";
      Field = "ﰠ";
      Variable = "";
      Class = "ﴯ";
      Interface = "";
      Module = "";
      Property = "ﰠ";
      Unit = "塞";
      Value = "";
      Enum = "";
      Keyword = "";
      Snippet = "";
      Color = "";
      File = "";
      Reference = "";
      Folder = "";
      EnumMember = "";
      Constant = "";
      Struct = "פּ";
      Event = "";
      Operator = "";
      TypeParameter = "";
    };
  };
}
