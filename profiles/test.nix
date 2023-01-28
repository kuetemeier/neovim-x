#  test.nix - Neovim configuration
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

{ pkgs, ... }:

let
  luaFile = pkgs.writeScript "kuetemeierNeoVimHello.lua" (builtins.readFile ./test.lua);
in

{
  config = {
    extraConfigLua = ''
      if (io.open("${luaFile}")) then
        dofile("${luaFile}")
      end
    '';
  };
}
