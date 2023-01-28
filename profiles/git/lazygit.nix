#  lazygit.nix - Neovim lazygit configuration
#
#  > Plugin for calling lazygit from within neovim
#  https://github.com/kdheepak/lazygit.nvim
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

{ ... }:

{
  config = {
    plugins.lazygit.enable = true;

    maps.normal. "<leader>lg" = {
      silent = true;
      action = "<cmd>LazyGit<CR>";
      description = "Toggle LazyGit";
    };
  };
}
