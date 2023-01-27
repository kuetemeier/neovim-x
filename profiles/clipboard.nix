#  clipboard.nix - Neovim configuration for better clipboard support 
#
#  This profile includes the common configuration for the
#  `nvim-jkr` and `nvim-jkr-pde` suites
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

{ config, pkgs, ... }:

{
  config = {

    extraConfigLua = ''
      -- this should work for Linux, Windows and Mac
      vim.opt.clipboard:append { 'unnamedplus' }
      vim.opt.pastetoggle = '<F2>'
      vim.g.paste_mode = false

      function kuetemeierPasteToggle()
        if (vim.g.paste_mode == false) then
          print ('Toggle paste_mode on')
          vim.api.nvim_set_option('paste', true)
          vim.api.nvim_set_option('list', false)
          vim.g.paste_mode = true
        else
          print ('Toggle pase_mode off')
          vim.api.nvim_set_option('paste', false)
          vim.api.nvim_set_option('list', true)
          vim.g.paste_mode = false
        end
      end
    '';

    # Add `xlip` (X11 support) and `wl-clipboard` (Wayland support)
    extraPackages = [ pkgs.xclip pkgs.wl-clipboard ]; 

    maps = {
      normalVisualOp."<F2>" = {
        silent = true;
        action = "<cmd>lua kuetemeierPasteToggle()<CR>";
      };
    };
  
  };
}

