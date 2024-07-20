#  undotree.nix - Neovim configuration
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
    plugins.undotree.enable = true;

    keymaps = [
      {
        key = "<leader>ut";
        mode = "n";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "Toggle the undotree panel";
        options.silent = true;
      }
      {
        key = "<leader>uf";
        mode = "n";
        action = "<cmd>UndotreeFocus<CR>";
        options.desc = "Focus the undotree panel";
        options.silent = true;
      }
    ];
  };
}
