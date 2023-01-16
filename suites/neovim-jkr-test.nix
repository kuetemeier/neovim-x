#  nvim-jkr-test.nix - Neovim configuration for testing a development
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

{ config, pkgs, lib, inputs }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/hello-world.nix
  ];

  config = {
    extraConfigLua = ''
      print ("Happy testing!")
    '';
  };

}
