{ config, pkgs, ... } :
rec {

  # Base plugins to be included in all my Neovim configurations
  base = with pkgs.vimPlugins; [

      vim-commentary # Comment out/in lines

      editorconfig-vim # EditorConfig plugin for Vim

      vim-markdown # THE Markdown plugin for vim

  ];


  all = base ++ [];
}
