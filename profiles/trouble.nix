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

{ ... }:

{
  config = {
    plugins.trouble.enable = true;

    maps.normalVisualOp = {
      "<leader>xx" = "<cmd>TroubleToggle<cr>";
      "<leader>xw" = "<cmd>TroubleToggle workspace_diagnostics<cr>";
      "<leader>xd" = "<cmd>TroubleToggle document_diagnostics<cr>";
      "<leader>xq" = "<cmd>TroubleToggle quickfix<cr>";
      "<leader>xl" = "<cmd>TroubleToggle loclist<cr>";
      "gR" = "<cmd>TroubleToggle lsp_references<cr>";
    };
  };
}
