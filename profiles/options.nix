{ config, pkgs, ... }:
{
  config = {
    options = {

      # Mouse support
      mouse = "a";

      # Background
      background = "dark";

      # Enable filetype indentation
      #filetype plugin indent on

      termguicolors = true;

      # Line Numbers
      number = true;
      relativenumber = true;

      # Spellcheck
#      spelllang = "en_us";

      # Use X clipboard
#      clipboard = "unnamedplus";

      # Some defaults
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
  };

}
