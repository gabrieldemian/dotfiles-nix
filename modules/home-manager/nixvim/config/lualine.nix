{...}: {
  config.programs.nixvim.plugins.lualine = {
    enable = true;
    extensions = ["fzf" "oil" "mason" "toggleterm" "nvim-dap-ui" "trouble"];
    # options = {
    theme = "auto";
    alwaysDivideMiddle = true;
    globalstatus = true;
    componentSeparators = {
      left = "❘";
      right = "❘";
    };
    sectionSeparators = {
      left = "";
      right = "";
    };
    # };
    sections = {
      lualine_a = [
        {
          name = "mode";
          # color.bg = "#1e1e2e";
        }
      ];
      lualine_b = [
        {
          name = "branch";
          icon = "";
          color.bg = "#1e1e2e";
        }
        # "diff"
        {
          name = "diagnostics";
          color.bg = "#1e1e2e";
        }
      ];
      lualine_c = [
        {
          name = "filename";
          color.bg = "#1e1e2e";
        }
      ];
      lualine_x = [""];
      lualine_y = [
        {
          name = "progress";
          color.bg = "#1e1e2e";
        }
      ];
      lualine_z = [
        {
          name = ''"" .. os.date("%R")'';
        }
      ];
    };
  };
}
