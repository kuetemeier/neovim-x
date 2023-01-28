#  goyo.nix - Neovim goyo plugin configuration 
#
#  > Distraction-free writing in Vim
#  https://github.com/junegunn/goyo.vim
#
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}

{ config, pkgs, ... }:

{
  config = {
    plugins.goyo.enable = true;

    maps.normal."<leader>y" = {
      silent = true;
      action = "<cmd>Goyo<CR>";
      description = "Toggle Goyo - distraction-free writing in Vim";
    };
  };
}
