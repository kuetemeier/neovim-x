#  colorizer.nix - Neovim configuration
#
#  > A high-performance color highlighter for Neovim which has no external dependencies!
#  https://github.com/norcalli/nvim-colorizer.lua
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
{
  config,
  pkgs,
  ...
}: {
  config = {
    extraPlugins = [pkgs.vimPlugins.nvim-colorizer-lua];
    extraConfigLua = ''
      require 'colorizer'.setup {
        filetypes = {
          '*';
          css = { css = true; };
          scss = { css = true; };
          sass = { css = true; };
          less = { css = true; };
          stylus = { css = true; };
          html = { names = false; };
        };
        user_default_options = {
          RGB      = true;         -- #RGB hex codes
          RRGGBB   = true;         -- #RRGGBB hex codes
          names    = true;         -- "Name" codes like Blue
          RRGGBBAA = false;        -- #RRGGBBAA hex codes
          rgb_fn   = false;        -- CSS rgb() and rgba() functions
          hsl_fn   = false;        -- CSS hsl() and hsla() functions
          css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes: foreground, background
          mode     = 'background'; -- Set the display mode.

          -- RGB = false;
          -- names = false;
          -- RRGGBBAA = true;
          -- AARRGGBB = true;
        };
        buftypes = {
          '*';
          '!prompt';
          '!popup';
        };
      }
    '';
  };
}
