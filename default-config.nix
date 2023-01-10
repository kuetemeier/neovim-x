#  default-config.nix - Default configuration for Neovim
#
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2021 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}

{ config, pkgs, ... } :

let
  jkrPlugIns = ( import ./jkrPlugIns.nix { inherit config pkgs; } );
in {
  colorschemes.gruvbox.enable = true;

  maps.normal = {
    leader = " ";
  };

  options = {
    tabstop = 4;
    shiftwidth = 4;
    expandtab = false;

    mouse = "a";
  };

  plugins = {
    lightline = {
      enable = true;

      # colorscheme = "gruvbox";
      colorscheme = "wombat";

      active = {
        left = [
          [ "mode" "paste" ]
          [ "redaonly" "filename" "modified" "helloworld" ]
        ];
      };
    };
    barbar = {
      enable = true;

      autoHide = true;
    };
  };

  # What about plugins not available as a module?
  # Use extraPlugins:
  extraPlugins = with pkgs.vimPlugins; [ vim-toml ] ++ jkrPlugIns.all;

}
