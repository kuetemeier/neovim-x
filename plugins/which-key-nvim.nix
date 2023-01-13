{ config, pkgs, lib, inputs, ... }:

with lib;

let
  cfg = config.plugins.which-key;
in
{
  options = {
    plugins.which-key= {
      enable = mkEnableOption "Enable which-key";
    };
  };

  config =
    let
    in
    mkIf cfg.enable {
      # TODO: Add options from https://github.com/folke/which-key.nvim/

      extraPlugins = with pkgs.vimPlugins; [ which-key-nvim ];

      # extraConfigLua = ''
      # '';
    };
}
