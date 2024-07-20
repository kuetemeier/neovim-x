#  telescope.nix - Neovim telescope configuration
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
{...}: {
  imports = [
    ./dressing.nix
  ];
  config = {
    plugins.telescope.enable = true;

    keymaps = [
      {
        key = "<leader>ff";
        mode = "n";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Telescope: Find files";
        options.silent = true;
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Telescope: Live grep over all project files";
        options.silent = true;
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Telescope: Find buffer";
        options.silent = true;
      }
      {
        key = "<leader>fh";
        mode = "n";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "Telescope: Find help tag";
        options.silent = true;
      }
      {
        key = "<leader>fc";
        mode = "n";
        action = "<cmd>Telescope commands<CR>";
        options.desc = "Telescope: Find command";
        options.silent = true;
      }
      {
        key = "<leader>f:";
        mode = "n";
        action = "<cmd>Telescope search_history<CR>";
        options.desc = "Telescope: Search in command history";
        options.silent = true;
      }
      {
        key = "<leader>f/";
        mode = "n";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "Telescope: Search in current file";
        options.silent = true;
      }
      {
        key = "<leader>fm";
        mode = "n";
        action = "<cmd>Telescope marks<CR>";
        options.desc = "Telescope: Search in marks";
        options.silent = true;
      }
      {
        key = "<leader>fr";
        mode = "n";
        action = "<cmd>Telescope registers<CR>";
        options.desc = "Telescope: Search in Registers";
        options.silent = true;
      }
      {
        key = "<leader>fs";
        mode = "n";
        action = "lua require('telescope.builtin').spell_suggest()";
        options.desc = "Telescope: Spell suggest";
        options.silent = true;
      }
      {
        key = "<leader>fo";
        mode = "n";
        action = "<cmd>Telescope oldfiles<CR>";
        options.desc = "Telescope: Recently opened files";
        options.silent = true;
      }
      {
        key = "<leader>fk";
        mode = "n";
        action = "<cmd>Telescope keymaps<CR>";
        options.desc = "Telescope: Find key mapping";
        options.silent = true;
      }
      {
        key = "<leader>?";
        mode = "n";
        action = "<cmd>Telescope keymaps<CR>";
        options.desc = "Telescope: Find key mapping";
        options.silent = true;
      }
    ];
  };
}
