--  nvim/config/snip.lua
--
--  NeoVim configuration file for LuaSnip
--  Snippet Engine for Neovim written in Lua
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
--
-- NOTE: The configuration (Tab and S-Tab) is done in ./completion.lua
--
-- =====================================================
--  configure, keybind and prepare (like shown in docs)
-- local function prequire(...)
--   local status, lib = pcall(require, ...)
--   if (status) then return lib end
--   return nil
-- end
-- local luasnip = prequire('luasnip')
-- local cmp = prequire("cmp")
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- local check_back_space = function()
--   local col = vim.fn.col('.') - 1
--   if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--     return true
--   else
--     return false
--   end
-- end
-- _G.tab_complete = function()
--   if cmp and cmp.visible() then
--     cmp.select_next_item()
--   elseif luasnip and luasnip.expand_or_jumpable() then
--     return t("<Plug>luasnip-expand-or-jump")
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     cmp.complete()
--   end
--   return ""
-- end
-- _G.s_tab_complete = function()
--   if cmp and cmp.visible() then
--     cmp.select_prev_item()
--   elseif luasnip and luasnip.jumpable(-1) then
--     return t("<Plug>luasnip-jump-prev")
--   else
--     return t "<S-Tab>"
--   end
--   return ""
-- end
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- keymap("i", "<leader>j", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
-- keymap("s", "<leader>j", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
-- keymap("i", "<leader>k", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
-- keymap("s", "<leader>k", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

keymap("n", "<leader>j", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("n", "<leader>k", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

-- Lazy Load VisualStudio Code compatible snippets
-- e.g. from the installed PlugIn 'friendly-snippets'
-- @see https://github.com/rafamadriz/friendly-snippets
require('luasnip/loaders/from_vscode').lazy_load()

-- ==============================
--  actual snippet configuration
--
local types = require("luasnip.util.types")

require'luasnip'.config.setup({
  ext_opts = {
    [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}},
    [types.insertNode] = {active = {virt_text = {{"●", "GruvboxBlue"}}}}
  }
})

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- Every unspecified option will be set to the default.
ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  ext_opts = {
    -- [types.choiceNode] = {active = {virt_text = {{"choiceNode", "Comment"}}}}
    [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}},
    [types.insertNode] = {active = {virt_text = {{"●", "GruvboxBlue"}}}}
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true
})

local snipLatexRec
snipLatexRec = function()
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t({""}),
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, {t({"", "\t\\item "}), i(1), d(2, snipLatexRec, {})})
    })
  });
end

local snipDate = function() return {os.date('%Y-%m-%d')} end

-- LuaFormatter off
ls.snippets = {
  all = {
    s("ls", {
      t({"\\begin{itemize}",
      "\t\\item "}), i(1), d(2, snipLatexRec, {}),
      t({"", "\\end{itemize}"}), i(0)
    }),

    s("trig", c(1, {
      t("Ugh boring, a text node"),
      i(nil, "At least I can edit something now..."),
      f(function(args) return "Still only counts as text!!" end, {})
    })),

    s({
       trig = "date",
       namr = "Date",
       dscr = "Date in the form of YYYY-MM-DD"
    }, {f(snipDate, {})}),

    s({
        trig = "meta",
        namr = "Metadata",
        dscr = "Yaml metadata format for markdown"
    },
    {
      t({"---",
      "title: "}), i(1, "note_title"), t({"",
      "author: "}), i(2, "author"), t({"",
      "date: "}), f(snipDate, {}), t({"",
      "cathegories: ["}), i(3, ""), t({"]",
      "lastmod: "}), f(snipDate, {}), t({"",
      "tags: ["}), i(4), t({"]",
      "comments: true",
      "---", ""}),
      i(0)
    }),

    s({
        trig = "#mpl",
        namr = "JKR-MPL-2.0",
        dscr = "# Copyright JKR - License MPL-2.0"
    },
    {
      t({"#  "}), i(1, "filename"),
      t({"", "#  "}), i(2, "description"),
      t({"", "#",
        "#",
        "#        //_/  Jörg Kütemeier <https://kuetemeier.de>",
        "#     (_// )   (c) Copyright 2021 - License: MPL-2.0",
        "#",
        "#",
        "# {{{ MPL-2.0",
        "#",
        "#  This Source Code Form is subject to the terms of the Mozilla Public",
        "#  License, v. 2.0. If a copy of the MPL was not distributed with this",
        "#  file, You can obtain one at https://mozilla.org/MPL/2.0/.",
        "#",
        "# }}}",
        ""}),
      i(0)
    }),
  }
}
-- LuaFormatter on

-- {{{ LuaSnip - ChoiceNode-Popup
-- Source: https://github.com/L3MON4D3/LuaSnip/wiki/Misc

local current_nsid = vim.api
                       .nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local row_selection = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choiceNode.active_choice then
      -- current line is starter from buffer list which is length usually
      row_selection = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

  -- adding highlight so we can see which one is been selected.
  local extmark = vim.api.nvim_buf_set_extmark(buf, current_nsid, row_selection,
                                               0, {
    hl_group = 'incsearch',
    end_line = row_selection + row_offset
  })

  -- shows window at a beginning of choiceNode.
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width = w,
    height = h,
    bufpos = choiceNode.mark:pos_begin_end(),
    style = "minimal",
    border = 'rounded'
  })

  -- return with 3 main important so we can use them again
  return {win_id = win, extmark = extmark, buf = buf}
end

function choice_popup(choiceNode)
  -- build stack for nested choiceNodes.
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid,
                                 current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id = create_win.win_id,
    prev = current_win,
    node = choiceNode,
    extmark = create_win.extmark,
    buf = create_win.buf
  }
end

function update_choice_popup(choiceNode)
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid,
                               current_win.extmark)
  local create_win = window_for_choiceNode(choiceNode)
  current_win.win_id = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf = create_win.buf
end

function choice_popup_close()
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid,
                               current_win.extmark)
  -- now we are checking if we still have previous choice we were in after exit nested choice
  current_win = current_win.prev
  if current_win then
    -- reopen window further down in the stack.
    local create_win = window_for_choiceNode(current_win.node)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
  end
end

vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]])
-- }}}

