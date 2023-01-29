# profiles/lsp/default.nix - Neovim language server configuration
#
#
#      //_/  Jörg Kütemeier <https://kuetemeier.de>
#   ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de>
# SPDX-License-Identifier: MPL-2.0
#
{pkgs, ...}: {
  imports = [
    ./lsp.nix
    ./lspkind.nix
    ./lspsaga.nix
  ];
}
