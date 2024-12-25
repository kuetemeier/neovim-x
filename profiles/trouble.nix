#  trouble.nix - Neovim configuration
#
#  > A pretty diagnostics, references, telescope results, quickfix
#  > and location list to help you solve all the trouble your code is causing.
#  https://github.com/folke/trouble.nvim
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
    plugins.trouble.enable = true;
    plugins.web-devicons.enable = true;

    keymaps = [
      {
        key = "<leader>xx";
        mode = "";
        action = "<cmd>TroubleToggle<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
      {
        key = "<leader>xw";
        mode = "";
        action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
      {
        key = "<leader>xd";
        mode = "";
        action = "<cmd>TroubleToggle document_diagnostics<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
      {
        key = "<leader>xq";
        mode = "";
        action = "<cmd>TroubleToggle quickfix<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
      {
        key = "<leader>xl";
        mode = "";
        action = "<cmd>TroubleToggle loclist<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
      {
        key = "gR";
        mode = "";
        action = "<cmd>TroubleToggle lsp_references<CR>";
        options.desc = "Open Trouble";
        options.silent = true;
      }
    ];
  };
}
