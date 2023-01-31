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
  config = {
    plugins.nvim-cmp = {
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

      preselect = "None";

      mappingPresets = ["insert" "cmdline"];

      mapping = {
        # Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        "<CR>" = "cmp.mapping.confirm({ select = false })";

        "<C-e" = "cmp.mapping.abort()";

        "<Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              local luasnip=require("luasnip")
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              elseif cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
        };

        "<S-Tab>" = {
          modes = ["i" "s"];
          action = ''
            function(fallback)
              local luasnip=require("luasnip")
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end
          '';
        };

        "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';

        "<C-f>" = ''cmp.mapping.scroll_docs(4)'';

        "<C-Space>" = ''
          cmp.mapping.complete({
            config = {
              sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
              }
            }
          })'';
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
  };
}
