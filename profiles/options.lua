--  options.lua - Neovim options - lua part
--
--  using lua-snip
--
--
--       //_/  Jörg Kütemeier <https://kuetemeier.de>
--    ._// )   (c) Copyright 2023 - License: MPL-2.0
--
--
-- {{{ MPL-2.0
--
--  This Source Code Form is subject to the terms of the Mozilla Public
--  License, v. 2.0. If a copy of the MPL was not distributed with this
--  file, You can obtain one at https://mozilla.org/MPL/2.0/.
--
-- }}}

-- local cmd = vim.cmd
--
-- -- Highlight on yank
-- cmd [[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--   augroup end
--
--   augroup Nix
--     autocmd
--   augroup end
-- ]]

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)
