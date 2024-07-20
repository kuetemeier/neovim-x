{
  plugins = {
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = {ghost_text = true;};
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet = {expand = "luasnip";};
        formatting = {fields = ["kind" "abbr" "menu"];};
        # preselect = "None";
        sources = [
          {name = "nvim_lsp";}
          {name = "emoji";}
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          # {name = "copilot";}
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          {
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
          {
            name = "spell"; # snippets
            keywordLength = 3;
          }
          {
            name = "latex_symbols"; # snippets
            keywordLength = 3;
          }
        ];

        # window = {
        #   completion = {border = "solid";};
        #   documentation = {border = "solid";};
        # };
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
        # mappingPresets = ["insert"];

        mapping = {
          "<Tab>" = ''            cmp.mapping(
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
                            else
                              fallback()
                            end
                          end, { "i", "s" })
          '';

          "<S-Tab>" = ''            cmp.mapping(
                          function(fallback)
                            local luasnip=require("luasnip")
                            if cmp.visible() then
                              cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                              luasnip.jump(-1)
                            else
                              fallback()
                            end
                          end, { "i", "s" })
          '';
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";

          # Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    cmp-emoji = {enable = true;};
    cmp-nvim-lsp = {enable = true;}; # lsp
    cmp-buffer = {enable = true;};
    cmp-path = {enable = true;}; # file system paths
    cmp_luasnip = {enable = true;}; # snippets
    cmp-cmdline = {enable = true;}; # autocomplete for cmdline
    cmp-spell = {enable = true;}; # spell check
    cmp-latex-symbols = {enable = true;}; # LaTex symbols
  };
  extraConfigLua = ''
          luasnip = require("luasnip")
          kind_icons = {
            Text = "󰊄",
            Method = "",
            Function = "󰡱",
            Constructor = "",
            Field = "",
            Variable = "󱀍",
            Class = "",
            Interface = "",
            Module = "󰕳",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
          } 

           local cmp = require'cmp'

       -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
       cmp.setup.cmdline({'/', "?" }, {
         sources = {
           { name = 'buffer' }
         }
       })

      -- Set configuration for specific filetype.
       cmp.setup.filetype('gitcommit', {
         sources = cmp.config.sources({
           { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
         }, {
           { name = 'buffer' },
         })
       })

       -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
       cmp.setup.cmdline(':', {
         sources = cmp.config.sources({
           { name = 'path' }
         }, {
           { name = 'cmdline' }
         }),
    --      formatting = {
    --       format = function(_, vim_item)
    --         vim_item.kind = cmdIcons[vim_item.kind] or "FOO"
    --       return vim_item
    --      end
    -- }
       })  '';
}
