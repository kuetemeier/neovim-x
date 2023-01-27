--  config/nvim/kuetemeier/lspconfig.lua
--
--  LSP Client configuration for NeoVim
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
-- NOTE aboute supported languages / Where to find Langage Severs {{{
-- ______________________________________________________________
--
-- You can find documentation for supported language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- }}}
--
local lspconfig = require 'lspconfig'
-- local configs = require("lspconfig/configs") -- Make sure this is a slash (as theres some metamagic happening behind the scenes)

-- nvim-cmp Completion Configuartion for LSPs {{{
-- The nvim-cmp almost supports LSP's capabilities
-- so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- }}}

-- Bash / Shell - Language Server Configuration {{{
-- ____________________________________________
-- using: bashls
lspconfig.bashls.setup {capabilities = capabilities}
-- }}}

-- Elixir - Language Server Configuration {{{
-- ______________________________________
-- using: elixir-ls
lspconfig.elixirls.setup {cmd = {"elixir-ls"}, capabilities = capabilities}
-- }}}

-- Go / Golang - Language Server Configuration {{{
-- ______________________________________
-- using: gopls
lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  filetypes = {"go", "gomod"},
  capabilities = capabilities
}
-- }}}
-- JSON / HTML / CSS - Language Server Configuration {{{
-- ______________________________________
-- using: vscode-langservers-extracted
local handle_lsp = function(opts) return opts end
lspconfig.jsonls.setup {
  handle_lsp({
    -- Inspired by: https://github.com/tomaskallup/dotfiles/blob/master/nvim/lua/plugins/nvim-lspconfig.lua
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = {"package.json"},
            url = "https://json.schemastore.org/package.json"
          },
          {
            fileMatch = {"tsconfig*.json"},
            url = "https://json.schemastore.org/tsconfig.json"
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json"
            },
            url = "https://json.schemastore.org/prettierrc.json"
          },
          {
            fileMatch = {".eslintrc", ".eslintrc.json"},
            url = "https://json.schemastore.org/eslintrc.json"
          },
          {
            fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
            url = "https://json.schemastore.org/babelrc.json"
          },
          {
            fileMatch = {"lerna.json"},
            url = "https://json.schemastore.org/lerna.json"
          },
          {
            fileMatch = {"now.json", "vercel.json"},
            url = "https://json.schemastore.org/now.json"
          },
          {
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json"
            },
            url = "http://json.schemastore.org/stylelintrc.json"
          }
        }
      }
    },
    capabilities = capabilities
  })
}
lspconfig.html.setup {capabilities = capabilities}
lspconfig.cssls.setup {capabilities = capabilities}
-- }}}

-- Docker - Language Server Configuration {{{
-- ___________________________________________
-- using: dockerfile-language-server-nodejs
lspconfig.dockerls.setup {capabilities = capabilities}
-- }}}

-- Nix / NixOS - Language Server Configuration {{{
-- ___________________________________________
-- using: rnix
lspconfig.rnix.setup {capabilities = capabilities}
-- }}}

-- vim / NeoVim - Language Server Configuration {{{
-- ____________________________________________
-- using: vim-language-server
lspconfig.vimls.setup {capabilities = capabilities}
-- }}}

-- Lua Language Server Configuration {{{
-- _________________________________

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

-- NOTE: This will be set by our nix configuration
-- USER = vim.fn.expand('$USER')
-- local sumneko_root_path = ""
-- local sumneko_binary = "lua-language-server"

-- if vim.fn.has("mac") == 1 then
--   sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
--   -- sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
-- elseif vim.fn.has("unix") == 1 then
--   sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
--   -- sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
-- else
--   print("Unsupported system for sumneko")
-- end

lspconfig.sumneko_lua.setup {
  cmd = {Sumneko_binary, '-E', Sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  },
  capabilities = capabilities
}
-- }}}

-- SPDX Copyright Tags and Vim / NeoVim Modeline {{{
-- _____________________________________________
--
-- SPDX-FileCopyrightText: 2021 Jörg Kütemeier <https://kuetemeier.de/>
-- SPDX-License-Identifier: MPL-2.0
--
-- vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
-- }}}
