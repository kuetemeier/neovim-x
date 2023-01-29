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
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Build our configuration on the base.nix configuration
    ./base.nix

    # and add:
    ./startify.nix # The fancy start screen for Vim
    ./nvim-tree.nix # file manager and netrw replacement
    ./clipboard.nix # system clipboard support
    ./lightline.nix # a pretty status line
    ./telescope.nix # fuzzy find files and everything else
    ./git # git support
    ./lsp # language server support
    ./languages # programming languages support
    ./floaterm.nix # a floating terminal
    ./goyo.nix # distraction free writing
    ./treesitter.nix
    ./completion-and-snippets # nvim-cmp, lua-snip and some magic
    ./projects.nix
    ./colorizer.nix
    ./trouble.nix
  ];

  config = {
    # --------------------
    # Base desktop plugins

    # plugins.obsidian.enable = true;
  };
}
