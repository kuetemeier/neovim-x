#  completion.nix - Neovim auto completion configuration
#
#  nvim-cmp
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

{ ... }:

{
  config = {
    plugins.nvim-cmp = {
      enable = true;

      sources = [ { name = "nvim_lsp"; } ];
      mappingPresets = [ "insert" ];
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      formatting.fields = [ "kind" "abbr" "menu" ];

      window.completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
        col_offset = -4;
        side_padding = 0;
        border = "single";
      };

      window.documentation = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
        border = "single";
      };
    };
  };
}
