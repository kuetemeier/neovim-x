#  default.nix - Plugins of my Neovim configuration
#
#  Import this file to import all plugins into your configuration.
#  Typically this is done by `profiles/base.nix`.
#  This plugins will get merged with inputs.nixvim plugins.
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
    # ./obsidian-nvim.nix
    ./rene-calendar.nix
  ];
}
