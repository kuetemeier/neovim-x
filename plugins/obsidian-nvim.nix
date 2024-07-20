#  /neovim/plugins/obsidian-nvim.nix
#
#  > Neovim plugin for Obsidian, written in Lua
#  https://github.com/epwalsh/obsidian.nvim
#
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
  config,
  ...
}: let
  cfg = config.plugins.obsidian;

  obsidianPlugin = pkgs.vimUtils.buildVimPlugin rec {
    pname = "obsidian-nvim";
    version = "v1.15.0";
    src = pkgs.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = version;
      sha256 = "sha256-/7Wp38XTmkUAHFYwDaK5uH6eAfh7+3YQti1lfTnlNkc=";
    };
  };
in {
  options = with lib; {
    plugins.obsidian = {
      enable = mkEnableOption "Enable obsidian";
    };
  };

  config = lib.mkIf cfg.enable {
    plugins.nvim-cmp.enable = true; # required by obsidian-nvim
    # plugins.packer.enable = true;
    # plugins.packer.plugins = [
    #   {
    #     name = "epwalsh/obsidian.nvim";
    #     tag = "v1.15.0";
    #   }
    # ];

    extraPlugins = [obsidianPlugin];

    extraConfigLua = lib.mkDefault ''
      require("obsidian").setup({
        dir = "~/Documents/jkr-notes",
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        }
      })
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

