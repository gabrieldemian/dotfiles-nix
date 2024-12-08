{ config, ... }:
{
  config.programs.nixvim.plugins.rustaceanvim = {
    enable = true;
    settings.server = {
      standalone = false;
      cmd = [
        "rustup"
        "run"
        "nightly"
        "rust-analyzer"
      ];
      enable = true;
      default_settings = {
        rust_analyzer = {
          check = {
            command = "clippy";
          };
          inlayHints = {
            lifetimeElisionHints = {
              enable = "always";
            };
          };
        };
      };
    };
  };
}
