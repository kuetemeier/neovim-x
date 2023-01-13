{ config, pkgs, lib, inputs, ... }:

with lib;

let
  cfg = config.plugins.obsidian;
in
{
  options = {
    plugins.obsidian = {
      enable = mkEnableOption "Enable obsidian";
    };
  };

  config =
    let
      pluginGitHub = (import ../helpers.nix).pluginGitHub;
    in
    mkIf cfg.enable {
      # TODO: Add options from https://github.com/folke/which-key.nvim/

      extraPlugins = [
        pluginGitHub {
          inherit pkgs lib;
          owner = "epwalsh";
          repo = "obsidian.nvim";
          version = "jkr-2023-01-12";
          rev = "9359f7ab453976ac4f5ab3c9b8bc30fc0b3c5e1c";
          sha256 = "sha256-mgL0000ci9VjRiwBedZDPXi6CjNtJy3iOJDbmSXtisk=";
        }
      ];

      # extraConfigLua = ''
      # '';
    };
}
