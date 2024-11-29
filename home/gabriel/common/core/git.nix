{
  pkgs,
  config,
  # configVars,
  ...
}:
let
# handle = configVars.handle;
# publicGitEmail = configVars.gitHubEmail;
# publicKey = "${config.home.homeDirectory}/.ssh/id_yubikey.pub";
# username = configVars.username;
  publicKey = "${config.home.homeDirectory}/.gnupg/pubring.kbx";
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "gabrieldemian";
    userEmail = "gabrielgcr45@gmail.com";
    aliases = { };
    extraConfig = {
      log.showSignature = "true";
      init.defaultBranch = "master";
      pull.rebase = "true";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };

      commit.gpgsign = true;
      # gpg.format = "ssh";
      user.signing.key = "${publicKey}";
      # Taken from https://github.com/clemak27/homecfg/blob/16b86b04bac539a7c9eaf83e9fef4c813c7dce63/modules/git/ssh_signing.nix#L14
      # gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
    };
    # signing = {
    # signByDefault = true;
    # key = publicKey;
    # };
    ignores = [
      ".csvignore"
      ".direnv"
      "result"
    ];
  };
}
