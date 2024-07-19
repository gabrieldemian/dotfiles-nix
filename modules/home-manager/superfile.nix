{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.superfile;
in {
  options.superfile = {
    enable = mkEnableOption "enable superfile module";
  };

  config.xdg.configFile = mkIf cfg.enable {
    "superfile/config.toml" = {
      text = ''
        # change your theme
        theme = 'catppuccin-macchiato'
        #
        # Auto check for update
        auto_check_update = true
        #
        # Cd on quit (For more details, please check out https://superfile.netlify.app/configure/superfile-config/#cd_on_quit)
        cd_on_quit = false
        #
        # Whether to open file preview automatically every time superfile is opened.
        default_open_file_preview = true
        #
        # ================   Style =================
        #
        # Set transparent background or not (this only work when your terminal background is transparent)
        transparent_background = false
        #
        # File preview width allow '0' (this mean same as file panel),'x' x must be less than 10 and greater than 1 (This means that the width of the file preview will be one xth of the total width.)
        file_preview_width = 0
        #
        # The length of the sidebar. If you don't want to display the sidebar, you can input 0 directly. If you want to display the value, please place it in the range of 3-20.
        sidebar_width = 20
        #
        # Border style
        border_top = '─'
        border_bottom = '─'
        border_left = '│'
        border_right = '│'
        border_top_left = '╭'
        border_top_right = '╮'
        border_bottom_left = '╰'
        border_bottom_right = '╯'
        border_middle_left = '├'
        border_middle_right = '┤'
        #
        # ==========PLUGINS========== #
        #
        # Show more detailed metadata, please install exiftool before enabling this plugin!
        metadata = false
      '';
    };
    "superfile/themes/catppuccin-macchiato.toml" = {
      text = ''
              # Catppuccin Macchiato Flavor
        # Theme create by: https://github.com/GV14982
        # Update by(sort by time):
        #
        # Thanks for all contributor!!

        # If you want to make sidebar border display just set it same as sidebar background color

        # Code syntax highlight theme (you can go to https://github.com/alecthomas/chroma/blob/master/styles to find one you like)
        code_syntax_highlight = "catppuccin-macchiato"

        # ========= Border =========
        file_panel_border = "#6e738d" # Overlay0
        sidebar_border = "#24273a"    # Base
        footer_border = "#6e738d"     # Overlay0

        # ========= Border Active =========
        file_panel_border_active = "#b7bdf8" # Lavendar
        sidebar_border_active = "#ed8796"    # Red
        footer_border_active = "#a6da95"     # Green
        modal_border_active = "#939ab7"      # Overlay2

        # ========= Background (bg) =========
        full_screen_bg = "#24273a" # Base
        file_panel_bg = "#24273a"  # Base
        sidebar_bg = "#24273a"     # Base
        footer_bg = "#24273a"      # Base
        modal_bg = "#24273a"       # Base

        # ========= Foreground (fg) =========
        full_screen_fg = "#a5adcb" # Subtext0
        file_panel_fg = "#a5adcb"  # Subtext0
        sidebar_fg = "#a5adcb"     # Subtext0
        footer_fg = "#a5adcb"      # Subtext0
        modal_fg = "#a5adcb"       # Subtext0

        # ========= Special Color =========
        cursor = "#f4dbd6"  # Rosewater
        correct = "#a6da95" # Green
        error = "#ed8796"   # Red
        hint = "#7dc4e4"    # Sapphire
        cancel = "#ee99a0"  # Maroon
        # Gradient color can only have two color!
        gradient_color = ["#8aadf4", "#c6a0f6"] # [Blue, Mauve]

        # ========= File Panel Special Items =========
        file_panel_top_directory_icon = "#a6da95" # Green
        file_panel_top_path = "#8aadf4"           # Blue
        file_panel_item_selected_fg = "#91d7e3"   # Sky
        file_panel_item_selected_bg = "#24273a"   # Base

        # ========= Sidebar Special Items =========
        sidebar_title = "#7dc4e4"            # Sapphire
        sidebar_item_selected_fg = "#91d7e3" # Sky
        sidebar_item_selected_bg = "#24273a" # Base
        sidebar_divider = "#939ab7"          # Overlay2

        # ========= Modal Special Items =========
        modal_cancel_fg = "#363a4f" # Surface0
        modal_cancel_bg = "#ee99a0" # Maroon

        modal_confirm_fg = "#363a4f" # Surface0
        modal_confirm_bg = "#91d7e3" # Sky

        # ========= Help Menu =========
        help_menu_hotkey = "#91d7e3" # Sky
        help_menu_title = "#ee99a0"  # Maroon
      '';
    };
    "superfile/hotkeys.toml" = {
      text = ''
        # Global hotkeys (cannot conflict with other hotkeys)
        confirm = ['enter', ' ']
        quit = ['ctrl+c', ' ']
        # movement
        list_up = ['k', ' ']
        list_down = ['j', ' ']
        # file panel control
        create_new_file_panel = ['n', ' ']
        close_file_panel = ['q', ' ']
        next_file_panel = ['tab', ' ']
        previous_file_panel = ['shift+tab', ' ']
        toggle_file_preview_panel = ['f', ' ']
        # change focus
        focus_on_process_bar = ['ctrl+p', ' ']
        focus_on_sidebar = ['ctrl+s', ' ']
        focus_on_metadata = ['ctrl+m', ' ']
        # create file/directory and rename
        file_panel_item_create = ['a', ' ']
        file_panel_item_rename = ['r', ' ']
        # file operations
        copy_items = ['y', ' ']
        cut_items = ['x', ' ']
        paste_items = ['p', ' ']
        delete_items = ['d', ' ']
        # compress and extract
        extract_file = ['ctrl+e', ' ']
        compress_file = ['ctrl+a', ' ']
        # editor
        open_file_with_editor = ['e', ' ']
        open_current_directory_with_editor = ['E', ' ']
        # other
        pinned_directory = ['P', ' ']
        toggle_dot_file = ['.', ' ']
        change_panel_mode = ['m', ' ']
        open_help_menu = ['?', ' ']
        # =================================================================================================
        # Typing hotkeys (can conflict with all hotkeys)
        confirm_typing = ['enter', ' ']
        cancel_typing = ['esc', ' ']
        # =================================================================================================
        # Normal mode hotkeys (can conflict with other modes, cannot conflict with global hotkeys)
        parent_directory = ['-', ' ']
        search_bar = ['/', ' ']
        # =================================================================================================
        # Select mode hotkeys (can conflict with other modes, cananot conflict with global hotkeys)
        file_panel_select_mode_items_select_down = ['J', ' ']
        file_panel_select_mode_items_select_up = ['K', ' ']
        file_panel_select_all_items = ['A', ' ']
      '';
    };
  };
}
