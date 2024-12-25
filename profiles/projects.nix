#  .nix - Neovim configuration
#
# > The superior project management solution for neovim
# https://github.com/ahmedkhalf/project.nvim
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
    plugins.project-nvim = {
      enable = true;

      settings.silent_chdir = false;

      enableTelescope = true;
    };

    # nvim-tree integreation in projects
    plugins.nvim-tree = {
      syncRootWithCwd = true;
      respectBufCwd = true;
      updateFocusedFile = {
        enable = true;
        updateRoot = true;
      };
    };

    keymaps = [
      {
        key = "<leader>fp";
        mode = "n";
        action = "<cmd>Telescope projects<CR>";
        options.desc = "Telescope: Search latest projects";
        options.silent = true;
      }
    ];
  };
}
