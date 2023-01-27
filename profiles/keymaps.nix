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
    };
  };

}
