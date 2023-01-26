#  base-desktop.nix - Base for my Neovim configuration desktop configurations
#
#  This profile includes the common configuration for the
#  `nvim-jkr` and `nvim-jkr-pde` suites
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

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Build our configuration on the base.nix configuration
    ./base.nix
    ./lightline.nix
    ./lsp.nix
  ];

  config = {

    viAlias = true;
    vimAlias = true;

    # --------------------
    # Base desktop plugins

    plugins.barbar.enable = true;

    plugins.lazygit.enable = true;

    # plugins.obsidian.enable = true;

    plugins.startify.enable = true;

    plugins.telescope.enable = true;

    maps.normal = {
      "<leader>ff" = "<cmd>Telescope find_files<cr>";
      "<leader>fg" = "<cmd>Telescope live_grep<cr>";
      "<leader>fb" = "<cmd>Telescope buffers<cr>";
      "<leader>fh" = "<cmd>Telescope help_tags<cr>";

      "<c-p>" = "<cmd>Telescope find_files<cr>";
      "<c-s-p>" = "<cmd>Telescope commands<cr>";
      "<c-k>" = "<cmd>Telescope buffers<cr>";
      "<c-s-k>" = "<cmd>Telescope keymaps<cr>";
    };

    plugins.which-key.enable = true;

    plugins.treesitter = {
      enable = true;

      # Enable tree-sitter based indention
      indent = true;

      # Enable tree-sitter based folding
      folding = false;

      ensureInstalled = true;

      disabledLanguages = [ "bash" ];
    };

      # rainbow - Rainbow parentheses for neovim using tree-sitter
   #   nvim-ts-rainbow

    plugins.gitsigns.enable = true;

    # https://github.com/junegunn/goyo.vim
    # Distraction-free writing in Vim
    plugins.goyo.enable = true;

    # https://github.com/nvim-tree/nvim-tree.lua
    # A file explorer tree for neovim written in lua
    # (includes nvim-web-devicons)
    plugins.nvim-tree.enable = true;

    plugins.nvim-tree = {
      disableNetrw = true;
      hijackNetrw = true;
      # autoClose = true;

      git = {
        enable = true;
      };
    };

  };

}
