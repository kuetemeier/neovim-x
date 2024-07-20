{...}: {
  plugins.gitblame.enable = true;

  extraConfigLua = ''
    -- Deactivate Git Blame by default. You can toggle it on, whenever you wish.
    vim.g.gitblame_enabled = 0
  '';

  keymaps = [
    {
      key = "<leader>gb";
      mode = "n";
      action = "<cmd>GitBlameToggle<CR>";
      options.desc = "Toggle Git Blame";
      options.silent = true;
    }
  ];
}
