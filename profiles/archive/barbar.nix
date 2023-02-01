#  barbar.nix - Neovim barbar configuration
#
#  > The neovim tabline plugin.
#  https://github.com/romgrk/barbar.nvim
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

{ config, pkgs, ... }:

let
  inherit (builtins) toString;

  mkMap = actionStr: description: {
    silent = true;
    action = "<cmd>${actionStr}<CR>";
    inherit description;
  };

  mkMapGotoBufferPosition = pos:
    mkMap "BufferGoto ${toString(pos)}" "Go to buffer (tab) ${toString(pos)} in position";

in

{
  config = {
    plugins.barbar = {
      enable = true;

      # Enable animations
      animations = true;

      # Auto-hide the tab bar when there is only one buffer
      autoHide = true;

      # Enable the close button
      closeable = true;

      # Enable file type icons
      icons = true;
    };

    maps.normalVisualOp = {

      # Move to previous / next
      "<A-,>" = mkMap "BufferPrevious" "Move to previous buffer (tab)";
      "<A-.>" = mkMap "BufferNext" "Move to next buffer (tab)";

      # Re-order to previous/next
      "<A-<>" = mkMap "BufferMovePrevious" "Re-order buffer (tab) to previous position";
      "<A->>" = mkMap "BufferMoveNext" "Re-order buffer (tab) to next position";

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
      "<A-0>" = mkMap "BufferLast" "Go to last buffer (tab) in position";

      /* pin */
      "<A-p>" = mkMap "BufferPin" "Pin/unpin buffer";

      # Close buffer
      "<A-c>" = mkMap "BufferClose" "Close buffer (tab)";
      "<leader>bc" = mkMap "BufferClose" "Close buffer (tab)";
      "<leader>ba" = mkMap "BufferCloseAllButCurrent" "Close all buffers (tabs) but current";

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
      "<leader>bp" = mkMap "BufferPick" "Magic buffer-picking mode";
      # "<C-p>" = mkMap "BufferPickDelete" "Magic buffer-picking mode";

      # Sort automatically by...
      "<leader>bb" = mkMap "BufferOrderByBufferNumber" "Sort automatically by buffer number";
      "<leader>bd" = mkMap "BufferOrderByDirectory" "Sort automatically by directory";
      "<leader>bl" = mkMap "BufferOrderByLanguage" "Sort automatically by language";
      "<leader>bw" = mkMap "BufferOrderByWindowNumber" "Sort automatically by window number";

      "<leader>be" = mkMap "BarbarEnable" "Enables barbar (enabled by default)";
      "<leader>bs" = mkMap "BarbarDisable" "Disables barbar";
    };
  };
}
