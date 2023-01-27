{ config, options, lib, pkgs, ... }:

with lib;

let
  cfg = config.kuetemeier.configs.nvim;
  mkDefault = mkOverride 900;

in
{
  options.kuetemeier.configs.nvim = {
    enable = mkEnableOption "kuetemeier configs nvim";
  };

  config = mkIf cfg.enable {

    environment.variables.EDITOR = mkDefault "nvim";
    environment.variables.VISUAL = mkDefault "nvim";

    environment.shellAliases.v = mkDefault "nvim";

    environment.systemPackages = with pkgs;
      [
        (neovim.override {
          vimAlias = true;
          viAlias = true;

          configure = {
            customRC = ''
                      " Use Vim settings, rather than Vi Settings
                      set nocompatible
                      "************************************************
                      "" Settings
                      "************************************************
                      " deoplete


                      let g:deoplete#enable_at_startup = 1
                      let b:deoplete_disable_auto_complete = 1
                      call deoplete#custom#option({
                          \ 'auto_complete': v:true,
                          \ 'smart_case': v:true,
                      \})
                      call deoplete#custom#source('_', 'max_menu_width', 80)

                      " for command mode
                  "      nnoremap <Tab> >>
                  "      nnoremap <S-Tab> <<
                      " deoplete tab-completion and indention
                      inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
                      inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<C-d>"

                      " airline
                      let g:airline#extensions#tabline#enabled = 1
                      " syntastic
                      set statusline+=%#warningmsg#
                      set statusline+=%{SyntasticStatuslineFlag()}
                      set statusline+=%*
                      let g:syntastic_always_populate_loc_list = 1
                      let g:syntastic_auto_loc_list = 1
                      let g:syntastic_check_on_open = 1
                      let g:syntastic_check_on_wq = 1
                      " haskell
                      let g:haskellmode_completion_ghc = 0
                      let g:haskell_classic_highlighting = 1
                      au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
                      au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
                      autocmd FileType haskell setlocal shiftwidth=2 softtabstop=2
                      "************************************************
                      "" Key mappings
                      "************************************************
                      " Leader Key is `,`
                      let mapleader=','
                      " Buffer navigation
                      noremap <leader>q :bp<CR>
                      noremap <leader>w :bn<CR>
                      noremap <leader>c :bd<CR>
                      noremap <leader>C :bd!<CR>
                      " Clears highlighted search terms
                      nnoremap <silent> <C-l> :nohl<CR><C-l
                      " Opens terminal
                      noremap <leader>t :term<CR>
                      " Toggle terminal input
                      tnoremap <F12> <C-\><C-n>
                      " AutoFormat
                      noremap <F5> :Neoformat<CR>
                      " Toggle paste
                      set pastetoggle=<F10>
                      " Open Nerdtree
                      noremap <F3> :NERDTreeToggle<CR>
                      " Tab to autocomplete
                      inoremap <silent><expr> <TAB>
                      \ pumvisible() ? "\<C-n>" :
                      \ <SID>check_back_space() ? "\<TAB>" :
                      \ deoplete#mappings#manual_complete()
                      function! s:check_back_space() abort "{{{
                  let col = col('.') - 1
                  return !col || getline('.')[col - 1]  =~ '\s'
                      endfunction"}}}
                      "************************************************
                      "" Core
                      "************************************************
                      syntax on          " Syntax highlighting
                      filetype plugin indent on      " File type detection + language dependent indenting
                      let no_buffers_menu=1
                      set backspace=indent,eol,start      " Backspace works as expected
                      set relativenumber        " Relative line numbers
                      set hidden          " Allows hidden buffers
                      set cursorline          " Highlight current line
                      " Fix terminal color scheme
                      set t_Co=256
                      " set termguicolors
                      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
                      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
                      set background=dark " Setting dark mode
                      " Color scheme
                      colorscheme deus
                      let g:deus_termcolors=256


              " {{{ Folding
              "     _______

                if has('folding')

                  " fold on the marker
                  set foldmethod=marker

                  " turn on folding
                  set foldenable

                  " A column with the specified width is shown at the side of the window
                  " which indicates open and closed folds.
                  " you may wish to change this to 1 or 3
                  set foldcolumn=0

                  " autofold anything (but I can still fold manually).
                  "  set foldlevel=0

                  " Specify the movements which open folds.
                  set foldopen=block,hor,mark,percent,quickfix,tag,search

                  function! NeatFoldText() " {
                    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{' . '\d*\s*', ''', 'g') . ' '
                    " }
                    let lines_count = v:foldend - v:foldstart + 1
                    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
                    let foldchar = matchstr(&fillchars, 'fold:\zs.')
                    let foldtextstart = strpart(''' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
                    let foldtextend = lines_count_text . repeat(foldchar, 8)
                    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
                    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
                  endfunction
                  " }

                  set foldtext=NeatFoldText()

                  " Code folding options
                  nmap <leader>..0 :set foldlevel=0<CR>
                  nmap <leader>..1 :set foldlevel=1<CR>
                  nmap <leader>..2 :set foldlevel=2<CR>
                  nmap <leader>..3 :set foldlevel=3<CR>
                  nmap <leader>..4 :set foldlevel=4<CR>
                  nmap <leader>..5 :set foldlevel=5<CR>
                  nmap <leader>..6 :set foldlevel=6<CR>
                  nmap <leader>..7 :set foldlevel=7<CR>
                  nmap <leader>..8 :set foldlevel=8<CR>
                  nmap <leader>..9 :set foldlevel=9<CR>

                endif

              " }}}



            '';
            vam.knownPlugins = pkgs.vimPlugins // {
              deus = pkgs.vimUtils.buildVimPlugin {
                name = "deus";
                src = pkgs.fetchFromGitHub {
                  owner = "ajmwagar";
                  repo = "vim-deus";
                  rev = "bd29baa02917d926e68ca880217d17cbb317ac00";
                  sha256 =
                    "1sn62nvdjs8i4lvmqj19gyj5k9w588whaylk50xn4y2z57cyf7a7";
                };
              };
            };
            vam.pluginDictionaries = [{
              names = [
                "airline"
                "deus"
                "deoplete-nvim"
                "haskell-vim"
                "nerdtree"
                "neoformat"
                "syntastic"
                "vim-polyglot"
                "vim-hdevtools"
                "vim-multiple-cursors"
                "editorconfig-vim"
                "vim-commentary"
              ];
            }];
          };

        })
      ];

  };
}
