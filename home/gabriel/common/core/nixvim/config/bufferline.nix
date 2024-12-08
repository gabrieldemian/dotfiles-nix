{ ... }:
{
  config.programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        diagnostics = "nvim_lsp";
        mode = "tabs";
        close_icon = "";
        buffer_close_icon = "";
        indicator.icon = "";
        separator.style = [
          ""
          ""
        ];
        show_tab_indicators = false;
      };
      highlights = {
        fill.bg = "#1e1e2e";
        fill.fg = "#a6adc8";
        tab.bg = "#1e1e2e";
        tab_selected.bg = "#1e1e2e";
        tab_separator.bg = "#1e1e2e";
        tab_separator_selected.bg = "#1e1e2e";
        tab_close.bg = "#1e1e2e";
        close_button.bg = "#1e1e2e";
        close_button_visible.bg = "#1e1e2e";
        close_button_selected.bg = "#1e1e2e";
        buffer_selected.bg = "#1e1e2e";
        buffer_visible.bg = "#1e1e2e";
        numbers.bg = "#1e1e2e";
        numbers_visible.bg = "#1e1e2e";
        numbers_selected.fg = "#cdd6f4";
        buffer_selected.fg = "#cdd6f4";
        background.bg = "#1e1e2e";
        numbers_selected.bg = "#1e1e2e";
        separator_selected.bg = "#1e1e2e";
        separator.bg = "#1e1e2e";
        separator_visible.bg = "#1e1e2e";
        offset_separator.bg = "#1e1e2e";
        trunc_marker.bg = "#1e1e2e";
        warning.bg = "#1e1e2e";
        error.bg = "#1e1e2e";
        info.bg = "#1e1e2e";
      };
    };
  };
}
