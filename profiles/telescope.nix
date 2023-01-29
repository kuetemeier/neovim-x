#  telescope.nix - Neovim telescope configuration
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
{...}: let
  mkMapCmd = (import ../helpers.nix).mkMapCmd;
in {
  config = {
    plugins.telescope.enable = true;

    maps.normal = {
      "<leader>ff" = mkMapCmd "Telescope find_files" "Telescope: Find files";

      "<c-o>" = mkMapCmd "Telescope live_grep" "Telescope: Live grep over all project files";
      "<leader>fg" = mkMapCmd "Telescope live_grep" "Telescope: Live grep over all project files";
      "<leader>fb" = mkMapCmd "Telescope buffers" "Telescope: Find buffer";
      "<leader>fh" = mkMapCmd "Telescope help_tags" "Telescope: Find help tag";
      "<leader>fk" = mkMapCmd "Telescope keymaps" "Telescope: Find key mapping";
      "<leader>?" = mkMapCmd "Telescope keymaps" "Telescope: Find key mapping";
      "<leader>fc" = mkMapCmd "Telescope commands" "Telescope: Find command";
      "<leader>f/" = mkMapCmd "Telescope search_history" "Telescope: Search in command history";
    };
  };
}
