#  obisdian.nix - Neovim configuration for obsidian-nvim
#  https://github.com/epwalsh/obsidian.nvim
#
#  This profile includes the common configuration for the
#  `nvim-jkr` and `nvim-jkr-pde` suites
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
{lib, ...}: {
  config = {
    plugins.obsidian.enable = true;

    # maps.normal. "<leader>w" = {
    #   silent = true;
    #   action = "<cmd>WhichKey<CR>";
    # };
  };
}
