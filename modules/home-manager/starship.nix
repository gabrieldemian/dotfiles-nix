{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.starship;
in {
  options.starship = {
    enable = mkEnableOption "enable starship";
    shell = mkOption {
      type = types.str;
      default = "Zsh";
      description = ''
        The shell to enable starship for, default to zsh.
      '';
    };
  };

  config.programs.starship = mkIf cfg.enable {
    enable = true;
    "enable${cfg.shell}Integration" = true;
    settings = {
      palettes.catppuccin_macchiato = {
        rosewater = "#f4dbd6";
        flamingo = "#f0c6c6";
        pink = "#f5bde6";
        mauve = "#c6a0f6";
        red = "#ed8796";
        maroon = "#ee99a0";
        peach = "#f5a97f";
        yellow = "#eed49f";
        green = "#a6da95";
        teal = "#8bd5ca";
        sky = "#91d7e3";
        sapphire = "#7dc4e4";
        blue = "#8aadf4";
        lavender = "#b7bdf8";
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
        overlay1 = "#8087a2";
        overlay0 = "#6e738d";
        surface2 = "#5b6078";
        surface1 = "#494d64";
        surface0 = "#363a4f";
        base = "#24273a";
        mantle = "#1e2030";
        crust = "#181926";
      };
      palette = "catppuccin_macchiato";
      add_newline = false;
      format = ''
        $cmd_duration$directory $git_branch
        $character
      '';
      character = {
        success_symbol = "[->](bold fg:rosewater) ";
        error_symbol = "[->](bold fg:red) ";
      };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = " ";
      };
      git_state = {
        format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = " 🏳 ";
        ahead = " 🏎💨 ";
        behind = " 😰 ";
        diverged = " 😵 ";
        untracked = " 🤷 ";
        stashed = " 📦 ";
        modified = " 📝 ";
        staged = "[++\($count\)](green)";
        renamed = " ✍️ ";
        deleted = " 🗑 ";
      };
      hostname = {
        ssh_only = false;
        format = "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )";
        trim_at = ".companyname.com";
        disabled = false;
      };
      line_break.disabled = false;
      directory = {
        # home is where the heart is
        home_symbol = " ❤";
        read_only = "  ";
        style = "fg:mauve";
        truncation_length = 6;
        truncation_symbol = "~/";
        format = "(bold fg:mauve)[$path ]($style)(bold fg:mauve)";
      };
      directory.substitutions = {
        "Desktop" = "  ";
        "Documents" = "  ";
        "Downloads" = "  ";
        "Music" = " 󰎈 ";
        "Pictures" = "  ";
        "Videos" = "  ";
      };
      cmd_duration = {
        min_time = 0;
        format = "[](bold fg:pink)[ $duration](bold bg:pink fg:black)[](bold fg:pink) ";
      };
    };
  };
}
