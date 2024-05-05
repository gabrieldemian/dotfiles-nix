{config, ...}: {
  config.programs.nixvim.plugins.transparent = {
    enable = true;
    settings.extraGroups = [
      "BufferLineTabClose"
      "BufferLineBufferSelected"
      "BufferLineFill"
      "BufferLineBackground"
      "BufferLineSeparator"
      "BufferLineIndicatorSelected"
      "Normal"
      "NormalNC"
      "Comment"
      "Constant"
      "Special"
      "Identifier"
      "Statement"
      "PreProc"
      "Type"
      "Underlined"
      "Todo"
      "String"
      "Function"
      "Conditional"
      "Repeat"
      "Operator"
      "Structure"
      "LineNr"
      "NonText"
      "SignColumn"
      "CursorLine"
      "CursorLineNr"
      "StatusLine"
      "StatusLineNC"
      "EndOfBuffer"
    ];
  };
}
