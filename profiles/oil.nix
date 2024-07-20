{...}: {
  config = {
    plugins.oil = {
      enable = true;

      settings = {
        columns = ["icon"];
        view_options.show_hidden = true;
        # win_options = {
        #   wrap = false;
        #   signcolumn = "no";
        #   cursorcolumn = false;
        #   foldcolumn = "0";
        #   spell = false;
        #   list = false;
        #   conceallevel = 3;
        #   concealcursor = "ncv";
        # };
        keymaps = {
          # "<C-c>" = false;
          "<leader>qq" = "actions.close";
          # "<C-l>" = false;
          "<C-r>" = "actions.refresh";
          "y." = "actions.copy_entry_path";
        };
        skip_confirm_for_simple_edits = true;
      };
    };

    keymaps = [
      {
        key = "<leader>o";
        mode = "n";
        action = "<cmd>Oil<CR>";
        options.desc = "Open parent directory";
        options.silent = true;
      }
    ];
  };
}
