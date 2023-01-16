{ pkgs, lib } :

{

  # Example:
  # (pluginGitHub {
  #   owner = "folke";
  #   repo = "which-key.nvim";
  #   version = "jkr-2021-12-02";
  #   rev = "d3032b6d3e0adb667975170f626cb693bfc66baa";
  #   sha256 = "sha256-mgLmwP8ci9VjRiwBedZDPXi6CjNtJy3iOJDbmSXtisk=";
  # })
  pluginGitHub =
    { repo
    , owner ? repo
    , rev
    , sha256
    , version ? rev
    }: pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = version;
      src = pkgs.fetchFromGitHub {
        inherit owner repo rev sha256;
      };
    };

}
