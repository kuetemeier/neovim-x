#  base.nix - Base for my Neovim configuration
#
#  This builds the common base for my NeoVim configuration and will be
#  importet by mostly all suites.
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
  imports = [
    ../plugins
    ../modules
    ./colorscheme.nix
    ./keymaps.nix
    ./options.nix
    ./goyo.nix

    # base profiles
    ./comments.nix
    ./folding.nix
    ./which-key.nix
    ./bufferline.nix
    ./terminal.nix
    ./undotree.nix
    #./multicursors.nix
    ./surround.nix
    ./oil.nix
    ./git
  ];

  config = {
    viAlias = true;
    vimAlias = true;
  };
}
