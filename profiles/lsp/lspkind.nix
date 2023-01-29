# profiles/lsp/lspkind.nix - Neovim lspkind configuration
#
# > vscode-like pictograms for neovim lsp completion items
# https://github.com/onsails/lspkind.nvim
#
#      //_/  Jörg Kütemeier <https://kuetemeier.de>
#   ._// )   (c) Copyright 2023 - License: MPL-2.0
#
# {{{ MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de>
# SPDX-License-Identifier: MPL-2.0
#
# }}}
#
{pkgs, ...}: {
  config = {
    plugins.lspkind = {
      enable = true;
      mode = "symbol_text";
      cmp.ellipsisChar = "…";
      cmp.menu = {
        buffer = "[Buffer]";
        nvim_lsp = "[LSP]";
        luasnip = "[LuaSnip]";
        nvim_lua = "[Lua]";
        latex_symbols = "[Latex]";
      };
      cmp.after = ''
        function(entry, vim_item, kind)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "   " .. strings[2]
          return kind
        end
      '';
    };
  };
}
