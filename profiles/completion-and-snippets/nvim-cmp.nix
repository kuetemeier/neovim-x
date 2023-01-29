#  nvim-cmp.nix - Neovim auto completion configuration
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
  config.plugins.nvim-cmp = {
    enable = true;

    sources = [
      {name = "buffer";}
      {name = "path";}
      {name = "nvim_lsp";}
      {name = "latex_symbols";}
      {name = "emoji";}
      {name = "cmdline";}
      # {name = "luasnip";} # added by luasnip.nix
    ];

    mappingPresets = ["insert"];

    mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true })";
      "<Tab>" = ''
        cmp.mapping(function(fallback)
          local luasnip=require("luasnip")
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
           fallback()
          end
        end, {"i", "s"})'';
    };

    formatting.fields = ["kind" "abbr" "menu"];

    window.completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
      col_offset = -4;
      side_padding = 0;
      border = "single";
    };

    window.documentation = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
      border = "single";
    };
  };
}
