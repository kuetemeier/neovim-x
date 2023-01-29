# profiles/lsp/lsp.nix - Neovim language server configuration
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
  config = {
    plugins.lsp = {
      enable = true;

      # nil - Nix files
      # https://github.com/oxalica/nil
      servers.nil_ls = {
        enable = true;
        package = pkgs.unstable.nil;
        settings.formatting.command = ["alejandra"];
      };

      # bashls - Bash, Shell
      # https://github.com/bash-lsp/bash-language-server
      servers.bashls.enable = true;

      # TODO: Document, restructure and add more
      servers.elixirls.enable = true;
      servers.gopls.enable = true;
      servers.html.enable = true;
      servers.jsonls.enable = true;
      servers.sumneko-lua.enable = true;

      onAttach = ''
        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      '';
    };
    extraPackages = [pkgs.alejandra];
  };
}
