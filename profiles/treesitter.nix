#  .nix - Neovim configuration
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
{
  config,
  pkgs,
  ...
}: {
  config = {
    plugins.treesitter = {
      enable = true;

      # Enable tree-sitter based indention
      indent = true;

      # Enable tree-sitter based folding
      folding = false;

      ensureInstalled = true;

      disabledLanguages = ["bash"];
    };

    # rainbow - Rainbow parentheses for neovim using tree-sitter
    #   nvim-ts-rainbow
  };
}
