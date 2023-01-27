
#  ## Key mappings
#
#  (from: https://raw.githubusercontent.com/pta2002/nixvim/main/README.md )
#
#  It is fully possible to define key mappings from within NixVim. This is done
#  using the `maps` attribute:
#  
#  ```nix
#  {
#    programs.nixvim = {
#      maps = {
#        normalVisualOp.";" = ":";
#        normal."<leader>m" = {
#          silent = true;
#          action = "<cmd>make<CR>";
#        };
#      };
#    };
#  }
#  ```
#  
#  This is equivalent to this vimscript:
#  
#  ```vim
#  noremap ; :
#  nnoremap <leader>m <silent> <cmd>make<CR>
#  ```
#  
#  This table describes all modes for the `maps` option:
#  
#  | NixVim         | NeoVim                                           |
#  |----------------|--------------------------------------------------|
#  | normal         | Normal mode                                      |
#  | insert         | Insert mode                                      |
#  | visual         | Visual and Select mode                           |
#  | select         | Select mode                                      |
#  | terminal       | Terminal mode                                    |
#  | normalVisualOp | Normal, visual, select and operator-pending mode |
#  | visualOnly     | Visual mode only, without select                 |
#  | operator       | Operator-pending mode                            |
#  | insertCommand  | Insert and command-line mode                     |
#  | lang           | Insert, command-line and lang-arg mode           |
#  | command        | Command-line mode                                |
#  
#  The map options can be set to either a string, containing just the action,
#  or to a set describing additional options:
#  
#  | NixVim  | Default | VimScript                                |
#  |---------|---------|------------------------------------------|
#  | silent  | false   | `<silent>`                               |
#  | nowait  | false   | `<silent>`                               |
#  | script  | false   | `<script>`                               |
#  | expr    | false   | `<expr>`                                 |
#  | unique  | false   | `<unique>`                               |
#  | noremap | true    | Use the 'noremap' variant of the mapping |
#  | action  | N/A     | Action to execute                        |

{ pkgs, ... }:

{
  config = {

    # set <leader> before everything else
    extraConfigLuaPre = ''
      vim.g.mapleader = " " 
    '';

    maps = {
      normal = {
        # leader = " ";  -- done above with extraConfigLuaPre

        "<leader>e" = {
          silent = true;
          action = "<cmd>NvimTreeToggle<CR>";
        };

        "<leader>r" = {
          silent = true;
          action = "<cmd>NvimTreeRefresh<CR>";
        };

        "<leader>n" = {
          silent = true;
          action = "<cmd>NvimTreeFindFile<CR>";
        };

      };

      # use alt+hjkl to move between split/vsplit panels
      normal."<A-h>" = { action = "<C-w>h"; };
      normal."<A-j>" = { action = "<C-w>j"; };
      normal."<A-k>" = { action = "<C-w>k"; };
      normal."<A-l>" = { action = "<C-w>l"; };
      terminal."<A-h>" = { action = "<C-\><C-n><C-w>h"; };
      terminal."<A-j>" = { action = "<C-\><C-n><C-w>j"; };
      terminal."<A-k>" = { action = "<C-\><C-n><C-w>k"; };
      terminal."<A-l>" = { action = "<C-\><C-n><C-w>l"; };

      # resize windows (horizontal splits)
      normal."<leader>+" = { action = "<cmd>exe \"resize \" . (winheight(0) * 3/2)<CR>"; };
      normal."<leader>-" = { action = "<cmd>exe \"resize \" . (winheight(0) * 2/3)<CR>"; };
    };
  };

}

