{ config, pkgs, lib, inputs, ... }:

with lib;

let
  cfg = config.plugins.lazygit;
  helpers = import inputs.nixvim/helpers.nix { inherit lib; };
in
{
  options = {
    plugins.lazygit = {
      enable = mkEnableOption "Enable lazygit";
    };
  };

  config =
    let
    in
    mkIf cfg.enable {
      # TODO: Add options from https://github.com/kdheepak/lazygit.nvim/

      extraPlugins = with pkgs.vimPlugins; [ lazygit-nvim ];

      extraPackages = with pkgs; [ git lazygit ];

      # extraConfigLua = ''
      # '';
    };
}