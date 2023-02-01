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
  mkMap = (import ../helpers.nix).mkMapCmd;
  mkMapGotoBufferPosition = pos:
    mkMap "BufferLineGoToBuffer ${toString pos}" "Go to buffer (tab) ${toString pos} in position";
in {
  config = {
    plugins.bufferline = {
      enable = true;

      diagnostics = "nvim_lsp";
      # separatorStyle = "slant";

      extraOptions = {
        mode = "buffers";
        # "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise}): string
        numbers = "ordinal";

        show_buffer_icons = true;
        show_buffer_close_icon = true;
        show_tab_indicators = true;
      };
    };

    maps.normalVisualOp = {
      # Move to previous / next
      "<A-,>" = mkMap "BufferLineCyclePrev" "Move to previous buffer (tab)";
      "<A-.>" = mkMap "BufferLineCycleNext" "Move to next buffer (tab)";

      # Re-order to previous/next
      "<A-<>" = mkMap "BufferLineMovePrev" "Re-order buffer (tab) to previous position";
      "<A->>" = mkMap "BufferLineMoveNext" "Re-order buffer (tab) to next position";

      # Goto buffer (tab) in position
      "<A-1>" = mkMapGotoBufferPosition 1;
      "<A-2>" = mkMapGotoBufferPosition 2;
      "<A-3>" = mkMapGotoBufferPosition 3;
      "<A-4>" = mkMapGotoBufferPosition 4;
      "<A-5>" = mkMapGotoBufferPosition 5;
      "<A-6>" = mkMapGotoBufferPosition 6;
      "<A-7>" = mkMapGotoBufferPosition 7;
      "<A-8>" = mkMapGotoBufferPosition 8;
      "<A-9>" = mkMapGotoBufferPosition 9;
      "<A-0>" = mkMapGotoBufferPosition 0;
      # "<A-0>" = mkMap "BufferLast" "Go to last buffer (tab) in position";

      /*
      pin
      */
      "<A-p>" = mkMap "BufferLinePick" "Pick a buffer";

      # Close buffer
      "<A-c>" = mkMap "bdelete" "Close buffer (tab)";
      #"<leader>bc" = mkMap "BufferClose" "Close buffer (tab)";
      #      "<leader>ba" = mkMap "BufferCloseAllButCurrent" "Close all buffers (tabs) but current";

      # Wipeout buffer
      #                          :BufferWipeout
      # Close commands
      #                          :BufferCloseAllButCurrent
      #                          :BufferCloseAllButVisible
      #                          :BufferCloseAllButPinned
      #                          :BufferCloseAllButCurrentOrPinned
      #                          :BufferCloseBuffersLeft
      #                          :BufferCloseBuffersRight

      # Magic buffer-picking mode
      #"<leader>bp" = mkMap "BufferPick" "Magic buffer-picking mode";
      # "<C-p>" = mkMap "BufferPickDelete" "Magic buffer-picking mode";

      # Sort automatically by...
      #"<leader>bb" = mkMap "BufferOrderByBufferNumber" "Sort automatically by buffer number";
      #"<leader>bd" = mkMap "BufferOrderByDirectory" "Sort automatically by directory";
      #"<leader>bl" = mkMap "BufferOrderByLanguage" "Sort automatically by language";
      #"<leader>bw" = mkMap "BufferOrderByWindowNumber" "Sort automatically by window number";

      #"<leader>be" = mkMap "BarbarEnable" "Enables barbar (enabled by default)";
      #"<leader>bs" = mkMap "BarbarDisable" "Disables barbar";
    };
  };
}
