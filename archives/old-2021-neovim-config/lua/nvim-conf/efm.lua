--  config/nvim/nvim-conf/efm.lua
--
--  efm configuration for NeoVim
--
--
--        //_/  Jörg Kütemeier <https://kuetemeier.de>
--     (_// )   (c) Copyright 2021 - License: MPL-2.0
--
--
-- MPL-2.0 {{{
--
--  This Source Code Form is subject to the terms of the Mozilla Public
--  License, v. 2.0. If a copy of the MPL was not distributed with this
--  file, You can obtain one at https://mozilla.org/MPL/2.0/.
--
-- }}}
--
-- -- efm Configuration {{{

local lspconfig = require 'lspconfig'

-- https://prettier.io/docs/en/index.html
-- Prettier has suport for:
-- - JavaScript (including experimental features)
-- - JSX
-- - Angular
-- - Vue
-- - Flow
-- - TypeScript
-- - CSS, Less, and SCSS
-- - HTML
-- - JSON
-- - GraphQL
-- - Markdown, including GFM and MDX
-- - YAML
local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local prettierCSS = {
  formatCommand = "prettier --parser css",
  formatStdin = true
}

local prettierYAML = {
  formatCommand = "prettier --parser yaml",
  formatStdin = true
}

local luafmt = {
  -- https://github.com/Koihik/LuaFormatter#default-configuration
  formatCommand = 'lua-format -i --tab-width=2 --indent-width=2 --chop-down-table --chop-down-kv-table --continuation-indent-width=2 --no-use-tab --align-args --align-parameter --no-break-after-operator --column-limit=80 --break-after-table-lb ',
  formatStdin = true
}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"}
}

-- "The following formatting flags closely resemble Google's shell style defined in
-- <https://google.github.io/styleguide/shell.xml>:
--     shfmt -i 2 -ci -bn
-- " -- von `man shfmt`

local shfmt = {formatCommand = 'shfmt -i 2 -ci -s -bn', formatStdin = true}
local shellcheck = {
  lintCommand = 'shellcheck -f gcc -x -',
  lintSource = 'shellcheck',
  lintFormats = {
    '%f:%l:%c: %trror: %m',
    '%f:%l:%c: %tarning: %m',
    '%f:%l:%c: %tote: %m'
  },
  lintStdin = true
}

local languages = {
  -- lua = {luafmt},
  yaml = {prettierYAML},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettierCSS},
  markdown = {prettier},
  -- sh = {shfmt, shellcheck}
  sh = {shfmt, shellcheck}
  -- nix = {{formatCommand = 'nixpkgs-fmt', formatStdin = true}}
}

-- lspconfig.efm.setup {
--   root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git"),
--   filetypes = vim.tbl_keys(languages),
--   init_options = {documentFormatting = true, codeAction = true},
--   -- settings = {languages = languages, log_level = 1, log_file = '~/.efm.log'}
--   settings = {languages = languages}
-- }

lspconfig.efm.setup {
  on_attach = function(client)
    -- client.resolved_capabilities.document_formatting = true
    client.server_capabilities.documentFormattingProvider = true
    -- client.resolved_capabilities.goto_definition = false
    -- set_lsp_config(client)
  end,
  -- cmd = {'efm-langserver', '-logfile', '/tmp/efm.log', '-loglevel', '10'},
  root_dir = lspconfig.util.root_pattern("yarn.lock", "lerna.json", ".git", "*.csproj", "*.sln", ".config"),
  filetypes = vim.tbl_keys(languages),
  init_options = {documentFormatting = true, provideFormatter = true, codeAction = true},
  -- settings = {rootMarkers = {'.git/'}, languages = languages}
  settings = {languages = languages}
}

-- vim.api.nvim_exec([[
--   autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.yaml lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync(nil, 1000)
--   autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync(nil, 1000)
-- ]], false)

-- }}}

-- SPDX Copyright Tags and Vim / NeoVim Modeline {{{
-- _____________________________________________
--
-- SPDX-FileCopyrightText: 2021 Jörg Kütemeier <https://kuetemeier.de/>
-- SPDX-License-Identifier: MPL-2.0
--
-- vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
-- }}}
