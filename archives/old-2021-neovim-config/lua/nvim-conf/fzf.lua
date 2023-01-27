--  nvim/config/fzf.lua
--
--  NeoVim configuration file for fzf-lua
--  Improved fzf.vim written in lua
--  <https://github.com/ibhagwan/fzf-lua>
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
vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>",
                        {noremap = true, silent = true})

