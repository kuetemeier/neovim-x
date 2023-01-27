--  nvim/config/web-devicons.lua
--
--  NeoVim configuration file for nvim-web-devicons
--  lua `fork` of vim-web-devicons for neovim
--  <https://github.com/kyazdani42/nvim-web-devicons>
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
-- {{{ Example config
-- ----------------
--
-- require'nvim-web-devicons'.setup {
--  -- your personnal icons can go here (to override)
--  -- DevIcon will be appended to `name`
--  override = {
--   zsh = {
--     icon = "",
--     color = "#428850",
--     name = "Zsh"
--   }
--  };
--  -- globally enable default icons (default to false)
--  -- will get overriden by `get_icons` option
--  default = true;
-- }
--
-- }}}
require'nvim-web-devicons'.setup {default = true}
