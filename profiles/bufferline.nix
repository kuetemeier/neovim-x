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
{...}: let
  mkMap = key: action: desc: {
    key = "${key}";
    mode = "";
    action = "<cmd>${action}<CR>";
    options.desc = "${desc}";
    options.silent = true;
  };
  mkGoto = pos: {
    key = "<A-${toString pos}>";
    mode = "";
    action = "<cmd>BufferLineGoToBuffer ${toString pos}<CR>";
    options.desc = "Go to buffer (tab) ${toString pos} in position";
    options.silent = true;
  };
in {
  config = {
    plugins.web-devicons.enable = true;
    plugins.bufferline = {
      enable = true;

      settings.options.diagnostics = "nvim_lsp";
      # separatorStyle = "slant";

      settings.options = {
        mode = "buffers";
        # "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise}): string
        numbers = "ordinal";

        show_buffer_icons = true;
        show_buffer_close_icon = true;
        show_tab_indicators = true;
      };
    };

    keymaps =
      # Goto buffer (tab) in position
      (builtins.map
        mkGoto
        [1 2 3 4 5 6 7 8 9 0])
      ++ [
        # Move to previous / next
        (mkMap "<A-,>" "BufferLineCyclePrev" "Move to previous buffer (tab)")
        (mkMap "<A-.>" "BufferLineCycleNext" "Move to next buffer (tab)")

        # Re-order to previous/next
        (mkMap "<A-<>" "BufferLineMovePrev" "Re-order buffer (tab) to previous position")
        (mkMap "<A->>" "BufferLineMoveNext" "Re-order buffer (tab) to next position")
      ];
  };
}
