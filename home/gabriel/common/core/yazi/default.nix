{ ... }:
let
  ctp = builtins.fetchGit {
    url = "https://github.com/yazi-rs/flavors";
    rev = "2d7dd2afe253c30943e9cd05158b1560a285eeab";
  };
in
{
  config.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    flavors = {
      "catppuccin-mocha" = "${ctp}/catppuccin-mocha.yazi";
    };
    plugins = {
      smart_paste = ./plugins/smart_paste;
      smart_enter = ./plugins/smart_enter;
    };
    # settings.manager = {
    #   keymap = [
    #     ''          { on = [ "<C-n>" ], run = '''
    #           shell '${pkgs.ripdrag}/bin/ripdrag "$@" -x 2>/dev/null &' --confirm
    #       ''' },''
    #   ];
    # };
    theme = {
      flavor = {
        use = "catppuccin-mocha";
      };
    };
  };
}
