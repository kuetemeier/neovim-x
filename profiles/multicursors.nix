{pkgs, ...}: let
  jkr-multicursors-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "jkr-multicursors-nvim";
    version = "2024-06-16";
    src = pkgs.fetchFromGitHub {
      owner = "kuetemeier";
      repo = "multicursors.nvim";
      rev = "59a28ff141b0b87f5d023b4380aa74496af9ae01";
      sha256 = "sha256-izYwDVd5aniM7PIQJ873phpj6kGOiO8n4cvl+TJj1r4=";
    };
  };
in {
  config = {
    plugins.hydra.enable = true;
    plugins.multicursors.enable = true;
    plugins.multicursors.package = jkr-multicursors-nvim;

    keymaps = [
      {
        key = "<leader>mm";
        mode = ["n" "v"];
        action = "<cmd>MCstart<CR>";
        options.desc = "Create a selection for selected text or word under the cursor";
        options.silent = true;
      }

      {
        key = "<leader>ml";
        mode = ["n" "v"];
        action = "<cmd>MCvisual<CR>";
        options.desc = "Select the last visual mode selection and start listening for the actions.";
        options.silent = true;
      }

      {
        key = "<leader>mb";
        mode = ["n" "v"];
        action = "<cmd>MCpattern<CR>";
        options.desc = "Prompts for a pattern and selects every match in the buffer.";
        options.silent = true;
      }

      {
        key = "<leader>mv";
        mode = ["n" "v"];
        action = "<cmd>MCvisualPattern<CR>";
        options.desc = " Prompts for a pattern and selects every match in the visual selection.";
        options.silent = true;
      }

      {
        key = "<leader>mu";
        mode = ["n" "v"];
        action = "<cmd>MCunderCursor<CR>";
        options.desc = "Select the char under the cursor and start listening for the actions.";
        options.silent = true;
      }

      {
        key = "<leader>mc";
        mode = ["n" "v"];
        action = "<cmd>MCclear<CR>";
        options.desc = "Clears all the selections.";
        options.silent = true;
      }
    ];
  };
}
