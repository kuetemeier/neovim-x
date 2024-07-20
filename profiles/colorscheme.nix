#  colorscheme.nix - Theme configuration for Neovim
#
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2021 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}
{lib, ...}: {
  colorschemes.gruvbox = {
    enable = lib.mkDefault true;

    settings = {
      italics = true;
      bold = true;
      underline = true;
      undercurl = true;

      #contrastDark = "medium";
      contrast_dark = "hard";
    };
  };

  colorschemes.kanagawa = {
    enable = lib.mkDefault false;
  };
}
