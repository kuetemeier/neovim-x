{ pkgs, ... } :

{
  config = {
    extraConfigVim = builtins.readFile ./lightline.vim;

#    plugins.lightline.enable = true;
    extraPlugins = with pkgs.vimPlugins; [ lightline-vim vim-devicons ];
  };
}
