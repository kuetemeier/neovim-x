#  gitsigns.nix - Neovim gitsigns configuration
#
#  > Git integration for buffers
#  https://github.com/lewis6991/gitsigns.nvim
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
{...}: {
  config = {
    plugins.gitsigns.enable = true;

    maps = {
      # Gitsigns
      normal."<leader>hs" = "<cmd>Gitsigns stage_hunk<CR>";
      visual."<leader>hs" = "<cmd>Gitsigns stage_hunk<CR>";
      normal."<leader>hr" = "<cmd>Gitsigns reset_hunk<CR>";
      visual."<leader>hr" = "<cmd>Gitsigns reset_hunk<CR>";
      normal."<leader>hb" = "<cmd>Gitsigns blame_line<CR>";
      normal."<leader>hd" = "<cmd>Gitsigns diffthis<CR>";
      normal."<leader>hp" = "<cmd>Gitsigns preview_hunk<CR>";
      normal."<leader>hn" = "<cmd>Gitsigns next_hunk<CR>";
      normal."<leader>hN" = "<cmd>Gitsigns prev_hunk<CR>";
    };
  };
}
