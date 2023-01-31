#  options-snip.nix - Neovim options - nix part
#
#  using lua-snip
#
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}
{pkgs, ...}: let
  jkr-neovim-options =
    pkgs.writeScript "jkr-neovim-options.lua"
    (builtins.readFile ./options.lua);
in {
  config = {
    options = {
      # Mouse support
      mouse = "a";

      # Background
      background = "dark";

      # Enable filetype indentation
      #filetype plugin indent on

      termguicolors = true;

      # Line Numbers
      number = true;
      relativenumber = true;

      # Spellcheck
      #      spelllang = "en_us";

      # Use X clipboard
      #      clipboard = "unnamedplus";

      # Some defaults
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = 1;

      # don't unload buffer when it is |abandon|ed
      # notice: required by many config options in this file
      # e.g. 'set path+=**' etc.
      hidden = true;

      # Default file encodings
      encoding = "utf-8";
      fileencodings = "utf-8,default,latin1";
      fileformats = "unix,dos,mac";

      # visualize break ($) or tab (^|)
      list = true;

      # Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert
      # mode. This is a list of items, separated by commas. Each item allows
      # a way to backspace over something.
      backspace = "indent,eol,start";

      # don't create backup files
      backup = false;
      writebackup = false;

      # disabled to dected double edit
      # swapfile = false;

      history = 200;

      undolevels = 200;

      # Show the line and column number of the cursor position,
      # separated by a comma.
      ruler = true;

      # Have the h and l cursor keys wrap between lines
      # (like <Space> and <BkSpc> do by default.
      # And ~ covert case over line breaks; also have the cursor
      # wrap in insert mode
      whichwrap = "h,l,~,[,],b,s";

      # Natural open new windows
      splitbelow = true;
      splitright = true;

      # automatically indent lines
      cindent = true;

      smartcase = true; # "smart" search
      ignorecase = true;

      # keeps lines above and below scrolling
      scrolloff = 4;
    };

    globals = {
      mapleader = " ";
    };

    extraConfigLua = ''
      --
      vim.opt.path:append { '**' }

      -- Load custom snippet configurations
      if (io.open("${jkr-neovim-options}")) then
        dofile("${jkr-neovim-options}")
      end
    '';
  };
}
