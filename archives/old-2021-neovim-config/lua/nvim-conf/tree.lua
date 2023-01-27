--  nvim/config/tree.lua
--
--  Note: See also tree.vim
--
--  NeoVim configuration file for nvim-tree.lua
--  A file explorer tree for neovim written in lua
--  <https://github.com/kyazdani42/nvim-tree.lua>
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
--  Config  {{{
-- ________
require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true, -- false by default, closes the tree when you open a file
      window_picker = {
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf",
          },
          buftype = {
            'terminal',
          },
        },
      },
    },
  },
  disable_netrw = true,
  hijack_netrw = true,

  git = {
    enable = true,
    ignore = false, -- false by default
  },
  create_in_closed_folder = false, -- true by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
  renderer = {
    indent_markers = {
      enable = true, -- false by default, this option shows indent markers when folders are open
    },
    highlight_git = true, -- false by default, will enable file highlight for git attributes (can be used without the icons).
    highlight_opened_files = "all", -- "none" by default, will enable folder and file icon highlight for opened files/directories.
    root_folder_modifier = ':~', -- This is the default. See :help filename-modifiers for more options
    add_trailing = false, -- false by default, append a trailing slash to folder names
    group_empty = false, -- false by default, compact folders that only contain a single folder into one node in the file tree
    icons = {
      padding = ' ', -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
      symlink_arrow = ' ➛ ', -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
      show = {
        file = true, -- Show an icon before the file name
        folder = true, -- Show an icon before the folder name
        folder_arrow = true, -- Show a small arrow before the folder node
        git = true, -- Show a git status icon (requires `git.enable=true`)
      },
    },

    special_files = {
      "Cargo.toml",
      "ReadMe.md",
      "README.md",
      "Makefile",
      "MAKEFILE",
    }, -- List of filenames that gets highlighted with NvimTreeSpecialFile

    symlink_destination = true, -- default true, show the destination of the symlink
  },
}

-- }}}

