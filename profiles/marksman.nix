#  marksman.nix - Neovim markdown configuration
#
#  > Write Markdown with code assist and intelligence in the comfort of your
#  > favourite editor.
#  https://github.com/artempyanykh/marksman
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
{pkgs, ...}: {
  config = {
    extraPackages = with pkgs; [
      marksman
    ];
    extraConfigLua = ''
      require'lspconfig'.marksman.setup{}
    '';
  };
}
# {{{ SPDX Copyright Tags and Vim / NeoVim Modeline
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de/>
# SPDX-License-Identifier: MPL-2.0
#
# vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
# }}}

