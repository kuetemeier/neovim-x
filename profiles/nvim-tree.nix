#  nvim-tree.nix - Neovim nvim-tree configuration
#
#  A file explorer tree for neovim written in lua
#  https://github.com/nvim-tree/nvim-tree.lua
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
    # INFO: More configuration can be found in the projects.nix profile

    # (includes nvim-web-devicons)
    plugins.nvim-tree = {
      enable = true;
      disableNetrw = true;
      hijackNetrw = true;
      autoClose = true;

      updateFocusedFile = {
        enable = true;
      };

      git = {
        enable = true;
        ignore = true;
        timeout = 500;
      };
    };

    maps = {
      normal."<leader>e" = {
        silent = true;
        action = "<cmd>NvimTreeToggle<CR>";
      };

      normal."<leader>r" = {
        silent = true;
        action = "<cmd>NvimTreeRefresh<CR>";
      };

      normal."<leader>n" = {
        silent = true;
        action = "<cmd>NvimTreeFindFile<CR>";
      };
    };

  };
}
