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

      servers = {
        pyright.enable = true;
        rust-analyzer.enable = true;
        cssls.enable = true;
        eslint.enable = true;
      };

      onAttach = ''
        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      '';
    };

    maps = {
      # LSP stuff
      normal."gD" = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      normal."gd" = "<cmd>lua vim.lsp.buf.definition()<CR>";
      normal."K" = "<cmd>lua vim.lsp.buf.hover()<CR>";
      normal."gi" = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      # normal."<C-k>" = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
      normal."gr" = "<cmd>lua vim.lsp.buf.references()<CR>";
      normal."<leader>ck" = "<cmd>lua vim.diagnostic.open_float()<CR>";
      normal."<leader>ca" = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      normal."<leader>cf" = "<cmd>lua vim.lsp.buf.formatting_sync()<CR>";
    };

    extraPackages = [pkgs.alejandra];
  };
}
