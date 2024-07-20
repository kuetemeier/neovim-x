#  terminal.nix - Neovim terminal configuration
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
{...}: {
  config = {
    keymaps = [
      {
        key = "<leader>tt";
        mode = "n";
        action = "<cmd>terminal<CR>";
        options.desc = "Open Terminal";
        options.silent = true;
      }
    ];
    extraConfigVim = ''
      " turn terminal to normal mode with escape
      tnoremap <Esc> <C-\><C-n>

      " TODO: not working
      " start terminal in insert mode
      au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    '';
  };
}
