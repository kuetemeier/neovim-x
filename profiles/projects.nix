#  .nix - Neovim configuration
#
# > The superior project management solution for neovim
# https://github.com/ahmedkhalf/project.nvim
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
{...}: let
  mkMapCmd = (import ../helpers.nix).mkMapCmd;
in {
  config = {
    plugins.project-nvim = {
      enable = true;

      silentChdir = false;
    };

    # nvim-tree integreation in projects
    plugins.nvim-tree = {
      syncRootWithCwd = true;
      respectBufCwd = true;
      updateFocusedFile = {
        enable = true;
        updateRoot = true;
      };
    };

    extraConfigLua = ''
      require('telescope').load_extension('projects')
    '';

    maps.normal."<leader>fp" = mkMapCmd "Telescope projects" "Telescope: Search latest projects";
  };
}
