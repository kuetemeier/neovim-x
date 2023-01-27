--  nvim/config/treesitter.lua
--
--  NeoVim configuration file for nvim-treesitter
--  Nvim Treesitter configurations and abstraction layer
--
--     .|
--     ||_,  Jörg Kütemeier <https://kuetemeier.de>
--     |' `  Copyright (c) 1998-2021 - Apache License 2.0
--   `-'
--
--
--   Apache License 2.0  {{{
--  ____________________
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
--   Config  {{{
--  ________
--
require'nvim-treesitter.configs'.setup {

  -- TODO: find an OS independent solution
  parser_install_dir = os.getenv("HOME") .. "/.local/share/nvim/parser-install-dir",

  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- NO LONGER WORKING: ensure_installed = "maintained",
  -- ensure_installed = {
  --   "lua",
  --   "bash",
  --   "markdown",
  -- },

  -- install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  --
  auto_install = true,

  -- ignore_install = { "nix" }, -- List of parsers to ignore installing

  highlight = {

    -- false will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false
  },

  indent = {enable = true},

  -- from https://github.com/p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    extended_mode = true,
    -- prevents lagging in large files
    max_file_lines = 1000
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

vim.opt.runtimepath:append(os.getenv("HOME") .. "/.local/share/nvim/parser-install-dir")

-- }}}
