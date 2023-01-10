{ config, pkgs, ... }:
let
  myExtraPlugIns = (import ./myExtraPlugIns.nix { inherit config pkgs; });

  lightline = {
    enable = true;

    colorscheme = "gruvbox";

    active = {
      left = [
        [ "mode" "paste" ]
        [ "readonly" "filename" "modified" "helloworld" ]
      ];
    };
  };

  barbar = {
    enable = true;

    autoHide = true;
  };
in
{
  all = {
    plugins = {
      inherit lightline barbar;
    };

    extraPlugins = with pkgs.vimPlugins; [ vim-toml ] ++ myExtraPlugIns.all;
  };

}
