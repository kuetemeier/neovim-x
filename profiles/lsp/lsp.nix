#  /neovim/profiles/lsp/lsp.nix
#  Neovim language server configuration
#
#        //_/  Jörg Kütemeier <https://kuetemeier.de>
#     ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}
{
  pkgs,
  lib,
  ...
}: let
  mkMap = key: action: desc: {
    key = "${key}";
    mode = "";
    action = "<cmd>${action}<CR>";
    options.desc = "${desc}";
    options.silent = true;
  };
in {
  config = {
    plugins.lsp = {
      enable = true;

      # nil - Nix files
      # https://github.com/oxalica/nil
      servers.nil-ls = {
        enable = true;
        # package = pkgs.unstable.nil;
        package = pkgs.nil;
        settings.formatting.command = ["alejandra"];
      };

      servers.ruff-lsp = lib.mkForce {
        enable = false;
        # package = pkgs.ruff-lsp;
      };

      # bashls - Bash, Shell
      # https://github.com/bash-lsp/bash-language-server
      servers.bashls.enable = true;

      # TODO: Document, restructure and add more
      # elixir: temporary disabled, compiler errors and not time to fix ;-)
      # servers.elixirls.enable = true;
      servers.gopls.enable = true;
      servers.html.enable = true;
      servers.jsonls.enable = true;
      servers.lua-ls.enable = true;
      servers.terraformls.enable = true;

      # servers = {
      #   pyright.enable = true;
      #   rust-analyzer.enable = true;
      #   cssls.enable = true;
      #   eslint.enable = true;
      # };

      # onAttach = ''
      #   vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      # '';
    };

    keymaps = [
      # LSP stuff
      (mkMap "gD" "lua vim.lsp.buf.declaration()" "")
      (mkMap "gd" "lua vim.lsp.buf.definition()" "")
      (mkMap "K" "lua vim.lsp.buf.hover()" "")
      (mkMap "gi" "lua vim.lsp.buf.implementation()" "")
      # (mkMap "<C-k>"  "lua vim.lsp.buf.signature_help()" "")
      (mkMap "gr" "lua vim.lsp.buf.references()" "")
      (mkMap "<leader>ck" "lua vim.diagnostic.open_float()" "")
      (mkMap "<leader>ca" "lua vim.lsp.buf.code_action()" "")
      (mkMap "v" "lua vim.lsp.buf.code_action()" "")
      (mkMap "<leader>cf" "lua vim.lsp.buf.format { asynctrue }" "")
      (mkMap "<leader>lwa" "lua vim.lsp.buf.add_workspace_folder()" "")
      (mkMap "<leader>lwr" "lua vim.lsp.buf.remove_workspace_folder()" "")
      (mkMap "<leader>lwl" ''        lua function( " ")
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()) " ")
              end'' "")
    ];

    extraPackages = with pkgs; [
      alejandra
      shfmt
    ];
  };
}
# {{{ SPDX Copyright Tags and Vim / NeoVim Modeline
#
# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de/>
# SPDX-License-Identifier: MPL-2.0
#
# vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
# }}}

