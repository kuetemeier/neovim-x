#  folding.nix - Neovim folding configuration
#  Enter `:help folding` in Neovim for more infos about folding
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

{
  config = {
    options = {
      # turn on folding
      foldenable = true;

      # fold on the marker
      foldmethod = "marker";

      # A column with the specified width is shown at the side of the window
      # which indicates open and closed folds.
      # you may wish to change this to 1 or 3
      # TODO: Fix staring error
      # foldcolumn = 0;

      # autofold anything (but you can still fold manually).
      # foldlevel = 0

      # Specify the movements which open folds.
      foldopen = "block,hor,mark,percent,quickfix,tag,search";

    };

    maps = {
      normal."z0" = { silent = true; action = "<cmd>:set foldlevel=0<CR>"; };
      normal."z1" = { silent = true; action = "<cmd>:set foldlevel=1<CR>"; };
      normal."z2" = { silent = true; action = "<cmd>:set foldlevel=2<CR>"; };
      normal."z3" = { silent = true; action = "<cmd>:set foldlevel=3<CR>"; };
      normal."z4" = { silent = true; action = "<cmd>:set foldlevel=4<CR>"; };
      normal."z5" = { silent = true; action = "<cmd>:set foldlevel=5<CR>"; };
      normal."z6" = { silent = true; action = "<cmd>:set foldlevel=6<CR>"; };
      normal."z7" = { silent = true; action = "<cmd>:set foldlevel=7<CR>"; };
      normal."z8" = { silent = true; action = "<cmd>:set foldlevel=8<CR>"; };
      normal."z9" = { silent = true; action = "<cmd>:set foldlevel=9<CR>"; };
    };

    # TODO: Convert to lua, make international language (lines = Zeilen)
    extraConfigVim = ''
      function! NeatFoldText() " {
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{' . '\d*\s*', ''', 'g') . ' '
        " }
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart(''' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
      endfunction
      " }

      set foldtext=NeatFoldText()
    '';
  };
}
