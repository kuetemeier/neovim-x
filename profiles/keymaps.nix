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
{...}: {
  config = {
    # set <leader> before everything else
    extraConfigLuaPre = ''
      vim.g.mapleader = " "
    '';

    keymaps = [
      # normal = {
      #   # leader = " ";  -- done above with extraConfigLuaPre
      # };

      # Make sure leader does not do it's default action
      {
        key = "<Space>";
        mode = "n";
        action = "<Nop>";
      }

      # use alt+hjkl to move between split/vsplit panels
      {
        key = "<A-h>";
        mode = "n";
        action = "<C-w>h";
      }
      {
        key = "<A-j>";
        mode = "n";
        action = "<C-w>j";
      }
      {
        key = "<A-k>";
        mode = "n";
        action = "<C-w>k";
      }
      {
        key = "<A-l>";
        mode = "n";
        action = "<C-w>l";
      }

      {
        key = "<A-h>";
        mode = "t";
        action = "<C-\><C-n><C-w>h";
      }
      {
        key = "<A-j>";
        mode = "t";
        action = "<C-\><C-n><C-w>j";
      }
      {
        key = "<A-k>";
        mode = "t";
        action = "<C-\><C-n><C-w>k";
      }
      {
        key = "<A-l>";
        mode = "t";
        action = "<C-\><C-n><C-w>l";
      }

      # resize windows (horizontal splits)
      {
        key = "<leader>+";
        mode = "n";
        action = "<cmd>exe \"resize \" . (winheight(0) * 3/2)<CR>";
      }
      {
        key = "<leader>-";
        mode = "n";
        action = "<cmd>exe \"resize \" . (winheight(0) * 2/3)<CR>";
      }

      # Indent, stay in visual mode
      {
        key = "<";
        mode = "v";
        action = "<gv";
      }
      {
        key = ">";
        mode = "v";
        action = ">gv";
      }

      # Move text under cursor up and down
      {
        key = "<A-j>";
        mode = "v";
        action = ":m .+1<CR>==";
      }
      {
        key = "<A-k>";
        mode = "v";
        action = ":m .-2<CR>==";
      }

      # When pasting in visual mode, do not yank the replaces text
      {
        key = "p";
        mode = "v";
        action = "\"_dP";
      }
    ];
  };
}
