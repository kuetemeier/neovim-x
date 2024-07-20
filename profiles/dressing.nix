#  /neovim/profiles/dessing.nix - Neovim configuration
#
#  > Neovim plugin to improve the default vim.ui interfaces
#  https://github.com/stevearc/dressing.nvim
#  @see ./telescope.nix
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
{pkgs, ...}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      dressing-nvim
    ];
    extraConfigLua = ''
      require('dressing').setup({
      })
    '';
  };
}
