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
{
  config,
  pkgs,
  ...
}: let
  jkr-luasnip-snippets-01 =
    pkgs.writeScript "jkr-luasnip-snippets-01.lua"
    (builtins.readFile ./jkr-luasnip-snippets-01.lua);
in {
  config = {
    plugins.luasnip = {
      enable = true;
    };

    plugins.nvim-cmp = {
      sources = [{name = "luasnip";}];
      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';
    };

    extraConfigLua = ''
      if (io.open("${jkr-luasnip-snippets-01}")) then
        dofile("${jkr-luasnip-snippets-01}")
      end
    '';
  };
}
