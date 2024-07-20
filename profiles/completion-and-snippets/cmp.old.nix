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
    plugins.cmp = {
      enable = true;
      autoEnableSources = false;

      settings = {
        mapping = {
          __raw = ''
            cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
          '';
        };
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        sources = {
          __raw = ''
            cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' },
              -- { name = 'luasnip' },
              -- { name = 'ultisnips' },
              -- { name = 'snippy' },
            }, {
              { name = 'buffer' },
            })
          '';
        };

        #
        # sources = {
        #   __raw = ''
        #     cmp.config.sources({
        #       { name = 'nvim_lsp' },
        #       { name = 'path' },
        #       { name = 'latex_symbols' },
        #       { name = 'emoji' },
        #       -- { name = 'vsnip' },
        #       { name = 'luasnip' },
        #       -- { name = 'ultisnips' },
        #       -- { name = 'snippy' },
        #     }, {
        #       { name = 'buffer' },
        #     })
        #   '';
        # };

        # sources = [
        #   {name = "buffer";}
        #   {name = "path";}
        #   {name = "nvim_lsp";}
        #   {name = "latex_symbols";}
        #   {name = "emoji";}
        #   # { name = "cmdline"; } # comment out https://stackoverflow.com/questions/76005014/error-while-typing-in-insert-mode-neovim
        #   # {name = "luasnip";} # added by luasnip.nix
        # ];

        preselect = "None";

        # TODO: More testing... with 'cmdline', Tab stopped working on Neovim command line
        # mappingPresets = ["insert" "cmdline"];
        mappingPresets = ["insert"];

        # mapping = {
        #   # ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        #   # ['<C-f>'] = cmp.mapping.scroll_docs(4),
        #   # ['<C-Space>'] = cmp.mapping.complete(),
        #   # ['<C-e>'] = cmp.mapping.abort(),
        #   # ['<CR>'] = cmp.mapping.confirm({ select = true }),
        #   __raw = ''
        #     cmp.mapping.preset.insert({
        #       ['<CR>'] = cmp.mapping.confirm({ select = false }),
        #       ['<C-e'] = cmp.mapping.abort(),
        #
        #       ['<Tab>'] = cmp.mapping(
        #           function(fallback)
        #             local luasnip=require("luasnip")
        #             if luasnip.jumpable(1) then
        #               luasnip.jump(1)
        #             elseif cmp.visible() then
        #               cmp.select_next_item()
        #             elseif luasnip.expandable() then
        #               luasnip.expand()
        #             elseif luasnip.expand_or_jumpable() then
        #               luasnip.expand_or_jump()
        #             else
        #               fallback()
        #             end
        #           end, { "i", "s" }),
        #
        #       ['<S-Tab>'] = cmp.mapping(
        #           function(fallback)
        #             local luasnip=require("luasnip")
        #             if cmp.visible() then
        #               cmp.select_prev_item()
        #             elseif luasnip.jumpable(-1) then
        #               luasnip.jump(-1)
        #             else
        #               fallback()
        #             end
        #           end, { "i", "s" }),
        #
        #       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        #
        #       ['<C-f>'] = cmp.mapping.scroll_docs(4),
        #
        #       ['<C-Space>'] = cmp.mapping.complete({
        #           config = {
        #             sources = {
        #               { name = "nvim_lsp" },
        #               { name = "luasnip" },
        #               { name = "path" },
        #               { name = "buffer" },
        #             }
        #           }
        #         })
        #     })
        #   '';
        # };
        #

        # mapping = {
        #   # Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        #   "<CR>" = "cmp.mapping.confirm({ select = false })";
        #
        #   "<C-e" = "cmp.mapping.abort()";
        #
        #   "<Tab>" = {
        #     modes = ["i" "s"];
        #     action = ''
        #       function(fallback)
        #         local luasnip=require("luasnip")
        #         if luasnip.jumpable(1) then
        #           luasnip.jump(1)
        #         elseif cmp.visible() then
        #           cmp.select_next_item()
        #         elseif luasnip.expandable() then
        #           luasnip.expand()
        #         elseif luasnip.expand_or_jumpable() then
        #           luasnip.expand_or_jump()
        #         else
        #           fallback()
        #         end
        #       end
        #     '';
        #   };
        #   # " TODO: check why check_backspace() is gone
        #   # " elseif check_backspace() then
        #   # "  fallback()
        #
        #   "<S-Tab>" = {
        #     modes = ["i" "s"];
        #     action = ''
        #       function(fallback)
        #         local luasnip=require("luasnip")
        #         if cmp.visible() then
        #           cmp.select_prev_item()
        #         elseif luasnip.jumpable(-1) then
        #           luasnip.jump(-1)
        #         else
        #           fallback()
        #         end
        #       end
        #     '';
        #   };
        #
        #   "<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
        #
        #   "<C-f>" = ''cmp.mapping.scroll_docs(4)'';
        #
        #   "<C-Space>" = ''
        #     cmp.mapping.complete({
        #       config = {
        #         sources = {
        #           { name = "nvim_lsp" },
        #           { name = "luasnip" },
        #           { name = "path" },
        #           { name = "buffer" },
        #         }
        #       }
        #     })'';
        # };

        formatting.fields = ["kind" "abbr" "menu"];

        window.completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
          colOffset = -4;
          sidePadding = 0;
          border = "single";
        };

        window.documentation = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
          border = "single";
        };
      };
    };
  };
}
