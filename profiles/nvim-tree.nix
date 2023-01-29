#  nvim-tree.nix - Neovim nvim-tree configuration
#
#  A file explorer tree for neovim written in lua
#  https://github.com/nvim-tree/nvim-tree.lua
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
    # INFO: More configuration can be found in the projects.nix profile

    # (includes nvim-web-devicons)
    plugins.nvim-tree = {
      enable = true;
      disableNetrw = true;
      hijackNetrw = true;
      autoClose = true;

      git = {
        enable = true;
      };
    };
  };
}
