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
      # disableNetrw = true;
      # hijackNetrw = true;
      disableNetrw = false;
      hijackNetrw = false;
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

    keymaps = [
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle NvimTree";
        options.silent = true;
      }
      {
        key = "<leader>r";
        mode = "n";
        action = "<cmd>NvimTreeRefresh<CR>";
        options.desc = "NvimTree Refresh";
        options.silent = true;
      }
      {
        key = "<leader>n";
        mode = "n";
        action = "<cmd>NvimTreeFindFile<CR>";
        options.desc = "NvimTree Find File";
        options.silent = true;
      }
    ];
  };
}
