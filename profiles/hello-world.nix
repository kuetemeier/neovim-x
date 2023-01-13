#  hello-world.nix - Minimal Neovim configuration
#
#  Prints "Hello World from jkr!" into Neovim output.
#  A demonstration how to use extra Lua and a simple profile test.
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

{ config, ... }:

{
  config = {
    extraConfigLua = ''
      print ("Hello Worl from jkr!")
    '';
  };
}
