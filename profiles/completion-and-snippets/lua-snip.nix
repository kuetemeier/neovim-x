#  lua-snip.nix - Neovim snippets configuration
#
#  using lua-snip
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
{pkgs, ...}: let
  jkr-luasnip-snippets-01 =
    pkgs.writeScript "jkr-luasnip-snippets-01.lua"
    (builtins.readFile ./jkr-luasnip-snippets-01.lua);
in {
  config = {
    plugins.luasnip = {
      enable = true;

      fromVscode = [
        # same as: require('luasnip/loaders/from_vscode').lazy_load()
        # to load friendly-snippets
        {}
      ];
    };

    # @see https://github.com/rafamadriz/friendly-snippets
    # extraPlugins = [pkgs.vimPlugins.friendly-snippets];

    extraConfigLua = ''
      -- Some more Luasnip configuration

      -- Some Theme settings
      local types = require("luasnip.util.types")
      require'luasnip'.config.setup({
        ext_opts = {
          [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}},
          [types.insertNode] = {active = {virt_text = {{"●", "GruvboxBlue"}}}}
        }
      })

      -- Load custom snippet configurations
      if (io.open("${jkr-luasnip-snippets-01}")) then
        dofile("${jkr-luasnip-snippets-01}")
      end
    '';

    keymaps = [
      {
        key = "<leader>j";
        mode = "n";
        action = "<cmd>lua require'luasnip'.jump(1)<CR>";
        options.desc = "Lua Snippet: Jump to next mark";
        options.silent = true;
      }
      {
        key = "<leader>k";
        mode = "n";
        action = "<cmd>lua require'luasnip'.jump(-1)<CR>";
        options.desc = "Lua Snippet: Jump to previous mark";
        options.silent = true;
      }
    ];
  };
}
# {{{ SPDX Copyright Tags and Vim / NeoVim Modeline
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de/>
# SPDX-License-Identifier: MPL-2.0
#
# vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
# }}}

