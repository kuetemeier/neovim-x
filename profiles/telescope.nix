#  telescope.nix - Neovim telescope configuration 
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

{ config, pkgs, lib, ... }:

{
  config = {
    plugins.telescope.enable = true;

    maps.normal = {
      "<leader>ff" = "<cmd>Telescope find_files<cr>";
      "<c-o>" = "<cmd>Telescope find_files<cr>";

      "<leader>fg" = "<cmd>Telescope live_grep<cr>";
      "<leader>fb" = "<cmd>Telescope buffers<cr>";
      "<leader>fh" = "<cmd>Telescope help_tags<cr>";
      "<leader>fk" = "<cmd>Telescope keymaps<cr>";
      "<leader>fc" = "<cmd>Telescope commands<cr>";
      "<leader>f/" = "<cmd>Telescope search_history<cr>";

      "<leader>?" = "<cmd>Telescope keymaps<cr>";
    };
  };
}
