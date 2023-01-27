--  nvim/config/completion.lua
--
--  NeoVim configuration file for nvim-lint
--  An asynchronous linter plugin for Neovim (>= 0.5)
--  complementary to the built-in Language Server Protocol support
--  <https://github.com/mfussenegger/nvim-lint>
--
--     .|
--     ||_,  Jörg Kütemeier <https://kuetemeier.de>
--     |' `  Copyright (c) 1998-2021 - Apache License 2.0
--   `-'
--
--  {{{ Apache License 2.0
--      __________________
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
--
--  }}}
local cmp = require('cmp')
local cmp_buffer = require('cmp_buffer')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- LuaFormatter off
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  -- LuaFormatter on
end

local luasnip = require("luasnip")
local lspkind = require('lspkind')

cmp.setup({

  sources = {
    -- Check status in nvim with ':CmpStatus'
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'latex_symbols'},
    {name = 'emoji'}

    -- *special* source, don't list here, see below
    -- {name = 'cmdline'},
  },

  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },

  mapping = {

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"}),

    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),

    ['<CR>'] = cmp.mapping.confirm({
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),

    -- Down-Key: select next item in completion list
    ['<Down>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select
    }),

    -- Up-Key: select previous item in completion list
    ['<Up>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select
    })

    -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    -- ['<CR>'] = cmp.mapping.confirm({select = true}),
  },

  sorting = {
    comparators = {
      function(...) return cmp_buffer:compare_locality(...) end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order
    }
  },

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]"
      }),
      maxwidth = 50
    })
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
