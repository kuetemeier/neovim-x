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
    ./nvim-tree.nix
    ./clipboard.nix
    ./lightline.nix
    ./telescope.nix
    ./git.nix
    ./lsp.nix
    ./floaterm.nix
    # ./marks.nix # TODO: Fix breakting boarders
    # ./mark-radar.nix
  ];

  config = {

    # --------------------
    # Base desktop plugins

    plugins.barbar.enable = true;

    # plugins.obsidian.enable = true;

    plugins.startify.enable = true;

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


    # https://github.com/junegunn/goyo.vim
    # Distraction-free writing in Vim
    plugins.goyo.enable = true;

  };

}
