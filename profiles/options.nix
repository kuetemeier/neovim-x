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


      # don't unload buffer when it is |abandon|ed
      # notice: required by many config options in this file
      # e.g. 'set path+=**' etc.
      hidden = true;

      # Default file encodings
      encoding = "utf-8";
      fileencodings = "utf-8,default,latin1";
      fileformats = "unix,dos,mac";

      # visualize break ($) or tab (^|)
      list = true;

      # Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert
      # mode. This is a list of items, separated by commas. Each item allows
      # a way to backspace over something.
      backspace = "indent,eol,start";

      # don't create backup files
      backup = false;
      writebackup = false;

      # disabled to dected double edit
      # swapfile = false;

      history = 200;

      undolevels = 200;

      # Show the line and column number of the cursor position,
      # separated by a comma.
      ruler = true;
    };

    extraConfigLua = ''
      -- 
      vim.opt.path:append { '**' }
    '';
  };
}
