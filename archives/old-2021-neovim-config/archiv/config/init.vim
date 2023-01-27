"
"  .config/nvim/init.vim
"  nvim / vim configuration file
"
"  Copyright (c) 1998-2021 Joerg Kuetemeier <https://kuetemeier.de>

"  ...[ Apache License 2.0]... {

"  Licensed under the Apache License, Version 2.0 (the "License");
"  you may not use this file except in compliance with the License.
"  You may obtain a copy of the License at
"
"    http://www.apache.org/licenses/LICENSE-2.0
"
"  Unless required by applicable law or agreed to in writing, software
"  distributed under the License is distributed on an "AS IS" BASIS,
"  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"  See the License for the specific language governing permissions and
"  limitations under the License.
"
" }

" ...[ Start the vim / neovim magic ]... {
" ________________________________________________________________________

  " This configuration is needed by a lot of plugins

  " Use Vim settings, rather then Vi settings.
  " This setting must be as early as possible, as it has side effects.
  set nocompatible

  " TODO: check for "plugin on" and "plugin indent on"
  filetype plugin on

  " Have Vim load indentation rules according to the detected filetype.
  if has("autocmd")
    filetype plugin indent on
  endif

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

  " .[ Syntax highlighting ]. {

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
      syntax on " Vim5 and later versions support syntax highlighting

      " configure syntastic syntax checking to check on open as well as save
      "let g:syntastic_check_on_open=1
      "let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
    endif

  " }

  " don't unload buffer when it is |abandon|ed
  " notice: required by many config options in this file
  "         e.g. 'set path+=**' etc.
  set hidden

  " Jump to another file easy
  " type 'gf' to jump to a file under the cursor (CTRL-6 jumps back)
  " gd ................................ jump to local definitions
  " gD ................................ jump to global definitions
  "
  " Search down into subfolders
  " Provides tab-completion for all file-related tasks
  set path+=**

" }

" ...[ Local config - before ]... {
" ________________________________________________________________________

" TODO make .config, nvim and vim compatible

  " Run local config, if it exits
  if filereadable(expand("~/.vimrc.local.before"))
      source ~/.vimrc.local.before
  endif

" }

" ...[ Environment ]... {
" ________________________________________________________________________

  " ..[ Identify platform ].. {
  " _________________________

    silent function! OSX()
      return has('macunix')
    endfunction
    silent function! LINUX()
      return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
      return  (has('win16') || has('win32') || has('win64'))
    endfunction

  " }

  " ..[ Basics ].. {
  " ______________

    if !WINDOWS()
      set shell=/bin/sh
    endif

  " }

  " ..[ Windows Compatible ].. {
  " __________________________

    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if WINDOWS()
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif

  " }

" }

" ...[ Plugins ]... {
" ________________________________________________________________________

  " [ ## Initialize Plugin System (vim-plug) ] {
  " ___________________________________________

    " <https://github.com/junegunn/vim-plug>

    " Specify a directory for plugins
    " - For Neovim: stdpath('data') . '/plugged'
    " - Avoid using standard Vim directory names like 'plugin'
    if has('nvim')
        call plug#begin(stdpath('data') . '/plugged')
    else
        silent! call plug#begin('~/.vim/plugged')
    endif

  " }

  " [ ### Plug - Goyo - Distraction-free writing in Vim ] {
  " ___________________________________________________

    " <https://github.com/junegunn/goyo.vim>
    "
    " ## Usage
    "
    " :Goyo ......................... Toggle Goyo
    " :Goyo [dimension] ............. Turn on resize Goyo
    " :Goyo! ........................ Turn Goyo off
    "
   Plug 'junegunn/goyo.vim'

  " }

  " .[ Plug - VimWiki ]. {

"   Plug 'vimwiki/vimwiki'

  " }

  " .[ Plug - ALE - Linting and fixing (async) ]. {

    Plug 'dense-analysis/ale'

  " }

  " .[ Plug - syntastic - Show errors hints and higlights ]. {

    Plug 'vim-syntastic/syntastic'

  " }

  " .[ Plug - tabular - Markdown syntastic highlight ]. {

    Plug 'godlygeek/tabular'

  " }

  " .[ Plug - vim-markdown - THE Markdown plugin for vim ]. {

    Plug 'plasticboy/vim-markdown'

  " }

  " .[ Plug - vim-instant-markdown - Markdown realtime preview ]. {

    " External dependencies: Before you want to use it, please run
    " `sudo npm -g install instant-markdown-d`
    Plug 'suan/vim-instant-markdown'

  " }

  " .[ Plug - Lf - lf in vim for file management ]. {

    " required for neovim
    Plug 'rbgrouleff/bclose.vim'
    Plug 'thezeroalpha/vim-lf'

  " }


  " EditorConfig plugin for Vim
  Plug 'editorconfig/editorconfig-vim'

  "Plug 'itchyny/lightline.vim'

"  Plug 'tpope/vim-fugitive'
  Plug 'lambdalisue/gina.vim'

  Plug 'tpope/vim-surround'

  Plug 'chrisbra/csv.vim'

"  Plug 'junegunn/fzf.vim'

  Plug 'SirVer/ultisnips'

  " Git status icons
  Plug 'airblade/vim-gitgutter'

  " Vim plugin for TODO lists management
  Plug 'aserebryakov/vim-todo-lists'

  " Comment out lines
  Plug 'tpope/vim-commentary'

  " A git blame plugin for (neo)vim inspired by VS Code's GitLens plugin
"  Plug 'apzelos/blamer.nvim'

  " Dark powered asynchronous completion framework for neovim/Vim8
  Plug 'Shougo/deoplete.nvim'

  " A better color scheme for the late night coder
  Plug 'ajmwagar/vim-deus'

  " A (Neo)vim plugin for formatting code
  " see <https://github.com/sbdchd/neoformat> and add helpers
  Plug 'sbdchd/neoformat'

  " A solid language pack for Vim
  Plug 'sheerun/vim-polyglot'

  " Elixr support
  Plug 'elixir-editors/vim-elixir'

"  Plug 'vim-airline/vim-airline'

  "  Plug 'preservim/nerdtree'

  " .[ Initialize plugin system ]. {

    call plug#end()

  " }

" }

" ...[ Plugin Configuration ]... {
" ________________________________________________________________________

  " .[ Conf - VimWiki ]. {

    let g:vimwiki_list = [{'path': '~/Documents/notes/notes/',
                          \ 'syntax': 'markdown', 'ext': '.md'}]

  "}

  " .[ Conf - ALE ]. {

    let g:ale_sign_error                  = '✘'
    let g:ale_sign_warning                = '⚠'
    highlight ALEErrorSign ctermbg        =NONE ctermfg=red
    highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
    "let g:ale_linters_explicit            = 1
    "let g:ale_lint_on_text_changed        = 'never'
    let g:ale_lint_on_enter               = 1
    let g:ale_lint_on_save                = 1
    let g:ale_fix_on_save                 = 1

    "\   'markdown':      ['mdl', 'writegood'],
    "let g:ale_linters = {
    "\   'markdown':      ['markdownlint'],
    "\}

    "let g:ale_fixers = {
    "\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
    "\}
    "


    "highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
    "highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5
    let g:ale_warn_about_trailing_whitespace = 0
    let g:ale_maximum_file_size = 1024 * 1024
    let g:ale_completion_enabled = 1
    let g:ale_code_actions_enabled = 1
    let g:ale_set_balloons_legacy_echo = 1
    let g:ale_c_parse_compile_commands = 1

    " Options for different linters.
    let g:ale_python_mypy_ignore_invalid_syntax = 1
    let g:ale_python_mypy_options = '--incremental'
    let g:ale_typescript_tslint_ignore_empty_files = 1
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1

    " Use newer clang versions where available.
    if executable('clang-10')
        let g:ale_c_cc_executable = 'clang-10'
        let g:ale_cpp_cc_executable = 'clang++-10'
    endif

    if executable('clangd-10')
        let g:ale_c_clangd_executable = 'clangd-10'
        let g:ale_cpp_clangd_executable = 'clangd-10'
    endif

  " }

  " .[ Conf - vim-markdown ]. {

    " See Filetype -> Markdown configuration

  " }

  " .[ Conf - lightline ]. {

    " " hide '-- INSERT --', it's already in the statusline
    " set noshowmode

    " let g:lightline = {
    "       \ 'colorscheme': 'wombat',
    "       \ 'mode_map': {
    "         \ 'n' : 'N',
    "         \ 'i' : 'I',
    "         \ 'R' : 'R',
    "         \ 'v' : 'V',
    "         \ 'V' : 'VL',
    "         \ "\<C-v>": 'VB',
    "         \ 'c' : 'C',
    "         \ 's' : 'S',
    "         \ 'S' : 'SL',
    "         \ "\<C-s>": 'SB',
    "         \ 't': 'T',
    "         \ },
    "       \ }

    " " Restore lightline colorscheme on vimrc / init.vim reload
    " augroup lightline_hl | au!
    "   au Colorscheme * call lightline#disable() | call lightline#enable()
    " augroup END

    " " Reload Lightline configuration
    " command! LightlineReload call LightlineReload()

    " function! LightlineReload()
    "   call lightline#init()
    "   call lightline#colorscheme()
    "   call lightline#update()
    " endfunction

  " }

  " .[ Conf - Lf ]. {

    "if filereadable("/usr/bin/lf")

      augroup lf
        autocmd! *
        autocmd FileType lf setlocal nornu
        autocmd FileType lf setlocal nonumber
      augroup END

    "endif

    "map <leader>l <Plug>LfEdit
    "map <leader>L <Plug>LfSplit

  " }

  " .[ Conf - vim-commentary ]. {

  noremap <space>/ :Commentary<CR>
  vnoremap <space>/ :Commentary<CR>

  " }

  " .[ Conf - more... ]. {

      " deoplete
      let g:deoplete#enable_at_startup = 1
      "let g:deoplete#enable_smart_case = 1
      let b:deoplete_disable_auto_complete = 1
      call deoplete#custom#option({
        \ 'auto_complete': v:true,
        \ 'smart_case': v:true,
      \})
      call deoplete#custom#source('_', 'max_menu_width', 80)

      " airline
      let g:airline#extensions#tabline#enabled = 1
      let no_buffers_menu=1

      " syntastic
      set statusline+=%#warningmsg#
      set statusline+=%{SyntasticStatuslineFlag()}
      set statusline+=%*
      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_auto_loc_list = 1
      let g:syntastic_check_on_open = 1
      let g:syntastic_check_on_wq = 1

      " for command mode
"      nnoremap <Tab> >>
"      nnoremap <S-Tab> <<
      " deoplete tab-completion and indention
      inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
      inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<C-d>"

      " Clears highlighted search terms
      nnoremap <silent> <C-l> :nohl<CR><C-l

      " Opens terminal
      noremap <F6> :term<CR>
      " Toggle terminal input
      tnoremap <F12> <C-\><C-n>

      " AutoFormat
      noremap <F5> :Neoformat<CR>

  " }
" }

" ...[ Colors ]... {
" ________________________________________________________________________

  " .[ Try to use Truecolor Mode ]. {

    " for vim 7
    " fix terminal color scheme
    set t_Co=256

    " For Neovim 0.1.3 and 0.1.4
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    " for vim 8 and Neovim >= 0.1.5
    if (has("termguicolors"))
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif

    " If you use tmux, you must use version 2.2 or newer. Put this in your config:
    " set -g default-terminal "tmux-256color"
    " set -ga terminal-overrides ",*256col*:Tc"

  " }

  " .[ Set color scheme ]. {

    "colorscheme hybrid
    colorscheme deus
    let g:deus_termcolors=256

  " }

  " .[ Transparent Background ]. {

    " transparent bg
    " autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    " For Vim<8, replace EndOfBuffer by NonText
    " autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

  " }
"}

" ...[ Basic settings ]... {
" ________________________________________________________________________

  " ..[ Options ].. {
  " ___________________

    " specify default encoding
    set encoding=utf-8

    set fileencodings=ucs-bom,utf-8,default,latin1

    set fileformats=unix,dos,mac

    " visualize break ($) or tab (^|)
    set list

    " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert
    " mode. This is a list of items, separated by commas. Each item allows
    " a way to backspace over something.
    set backspace=indent,eol,start

    " don't create backup files
    set nobackup
    set nowritebackup

    " disabled to dected double edit
    "set noswapfile

    set history=200

    set undolevels=200

    " Show the line and column number of the cursor position,
    " separated by a comma.
    set ruler

    " display incomplete commands
    set showcmd

    " Always display the status line
    set laststatus=2

    " Automatically :write before running commands
    " set autowrite

    " Watch for file changes
    set autoread

    " Enable the use of the mouse
    set mouse=a

    " Hide the mouse cursor while typing
    set mousehide

    "set showmatch     " When a bracket is inserted, briefly jump to the matching
                      " one. The jump is only done if the match can be seen on the
                      " screen. The time to show the match can be set with
                      " 'matchtime'.
    set noshowmatch

    set ttyfast       " optimize for fast terminal connections

    " Disable bell (beep) and flashing screen
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=

    " Always use vertical diffs
    set diffopt+=vertical

    set fillchars=vert:\┃,diff:⎼,fold:⎼

    " Highlight current line
    set cursorline

    " Enable autocompletion
    set wildmode=longest,list,full

    " Display all matching files when we tab complete
    set wildmenu

  " }

  " ..[ Movement ].. {
  " ________________

    " have the h and l cursor keys wrap between lines (like <Space> and <BkSpc>
    " do by default), and ~ covert case over line breaks; also have the cursor
    " keys wrap in insert mode:
    set whichwrap=h,l,~,[,]

    " use <Ctrl>+N/<Ctrl>+P to cycle through files:
    nnoremap <C-N> :next<CR>
    nnoremap <C-P> :prev<CR>

  " }

  " ..[ Search configuration ].. {
  " ____________________________

    set hlsearch        " When there is a previous search pattern, highlight all
                        " its matches.

    set incsearch       " While typing a search command, show immediately where the
                        " so far typed pattern matches.

    set ignorecase      " Ignore case in search patterns.

    set smartcase       " Override the 'ignorecase' option if the search pattern
                        " contains upper case characters.

  " }

  " ..[ Better copy & paste ].. {
  " ___________________________

    " Paste Mode On/Off
    " :set paste / :set no paste
    map <F2> :call Paste_on_off()<CR>
    set pastetoggle=<F2>

    if has('clipboard')
      if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
      else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
      endif
    endif

    let paste_mode = 0 " 0 = normal, 1 = paste

    func! Paste_on_off()
      if g:paste_mode == 0
        set paste
        set nolist
        let g:paste_mode = 1
      else
        set nopaste
        set list
        let g:paste_mode = 0
      endif
      return
    endfunc

    vnoremap <C-c> "*Y :let @+=@*<CR>
    map <C-p> "+P


    " .[ Copy and Paste with clipboard Support ]. {
    " ___________________________________________

      " TODO: more testing with alecritty and bspwm, perhaps use "*

      " Copy to clipboard
      vnoremap  <leader>y "*Y :let @+=@*<CR>
      "nnoremap  <leader>Y "+yg_

      "nnoremap  <leader>y "+y
      nnoremap  <leader>yy "*yy :let @+=@*<CR>


      " Paste from clipboard
      nnoremap <leader>p "+p
      nnoremap <leader>P "+P
      vnoremap <leader>p "+p
      vnoremap <leader>P "+P

    " }

  " }

  " ..[ Use 'ag' insteat of 'grep' ].. {
  " __________________________________

    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    if executable('ag')
      " Use Ag over Grep
      set grepprg=ag\ --nogroup\ --nocolor

      " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

      " ag is fast enough that CtrlP doesn't need to cache
      let g:ctrlp_use_caching = 0
    endif

  " }

  " ..[ Tab handling ].. {
  " ____________________

    " Softtabs, 2 spaces
    set tabstop=2     " Number of spaces that a <Tab> in the file counts for
    set shiftwidth=2  " Number of spaces to use for each step of (auto)indent
    set shiftround
    set expandtab     " Use the appropriate number of spaces to insert a <Tab>.
                      " Spaces are used in indents with the '>' and '<' commands
                      " and when 'autoindent' is on. To insert a real tab when
                      " 'expandtab' is on, use CTRL-V <Tab>.
  " }

  " ..[ Display extra whitespace ].. {
  " ________________________________

  set list listchars=tab:»·,trail:·

  " }

  " ..[ Make it obvious where 80 characters is ].. {
  " ______________________________________________

    set textwidth=79 " width of document (used by gd)
    set colorcolumn=+1
    set nowrap " don't automatically wrap on load
    set fo-=t  " don't automatically wrap text when typing
    highlight ColorColumn ctermbg=233

    set colorcolumn=79,120
  " }

  " ..[ Line Numbers ].. {

    " print the line number in front of each line
    set number
    " show relative line number in front of each line
    set relativenumber

    " Related:
    " nnoremap <F2> :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<cr>
    " set numberwidth=5

    "highlight clear SignColumn      " SignColumn should match background
    " highlight clear LineNr          " Current line number row will have same background color in relative mode
    highlight clear CursorLineNr    " Remove highlight color from current line number
    highlight CursorLineNr ctermbg=233

   " }

" }

" ...[ Keybindings and Mappings ]... {
" ________________________________________________________________________

  " Set <Leader> key to <space>
  let mapleader = " "

  " map sort function to a key
  vnoremap <Leader>s :sort<CR>


  "make < > shifts keep selection
  vnoremap < <gv
  vnoremap > >gv

  "nnoremap <Leader>b :set background=dark<CR>
  nnoremap <Leader>b :Buffers<CR>

  nnoremap <Leader><Leader>s :Gina status<CR>
  nnoremap <Leader><Leader>c :Gina commit<CR>
  nnoremap <Leader><Leader>p :Gina push<CR>
  nnoremap <Leader><Leader>P :Gina pull<CR>
  nnoremap <Leader>h :History<CR>
  nnoremap <Leader>H :History:<CR>
  nnoremap <Leader><Leader>h :History/<CR>

  " Run commands that require an interactive shell
  nnoremap <silent> <Leader>r :RunInInteractiveShell<space>

  " Quick quit command
  noremap <Leader>e :quit<CR> " Quit current window
  noremap <Leader>E :qa!<CR>  " Quit all windows

  " Yank from the cursor to the end of the line, to be consistent
  " with other capitals C and D.
  " TODO: test if nnoremap or map Y y$
  nnoremap Y y$

  " ..[ Remapping of german keys ].. {
  " ________________________________

    " map <silent> Ü [
    " inoremap <silent> Ü [
    " map <silent> ö :
    " inoremap <silent> ö :
    " map <silent> Ä ]
    " inoremap <silent> Ä ]
    " map <silent> ü {
    " map <silent> ä }
    " inoremap <silent> ü {
    " inoremap <silent> ä }
    " noremap <silent> ß /
    " inoremap <silent> ß /

    " " key combinations to genereate german umlauts
    " inoremap <silent> o" ö
    " inoremap <silent> a" ä
    " inoremap <silent> u" ü
    " inoremap <silent> O" Ö
    " inoremap <silent> A" Ä
    " inoremap <silent> U" Ü

  " }

  " ..[ Additional ESC sequences for mode changes ].. {
  " _________________________________________________

    " some like to have 'jk' as sequence... bad idea if your name is Jörg Kütemeier
    inoremap <silent> jj <esc>
    inoremap <silent> jl <esc>
    nnoremap <silent> <leader>. :

  " }

  " ..[ Easier formatting of paragraphs ].. {
  " _______________________________________

    " have Q reformat the current paragraph
    " (or selected text if there is any)

    vmap Q gq
    nmap Q gqap

    vnoremap Q gqqp
    vnoremap Q gq

  " }

  " ..[ Easier moving between tabs ].. {
  " __________________________________

    " Easier moving between tabs
"    map <Leader>n <esc>:tabprevious<CR>
"    map <Leader>m <esc>:tabnext<CR>

  " }

" }

" ...[ Folding ]... {
" ________________________________________________________________________

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
      let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{' . '\d*\s*', '', 'g') . ' '
      " }
      let lines_count = v:foldend - v:foldstart + 1
      let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
      let foldchar = matchstr(&fillchars, 'fold:\zs.')
      let foldtextstart = strpart('' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
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

" }

" ...[ Windows and Panels ] {
" ________________________________________________________________________
"

  " ..[ Natural open new windows ].. {
  " ________________________________

    " Open new split panes to right and bottom, which feels more natural
    set splitbelow
    set splitright

  " }

  " ..[ Quicker window movement ].. {
  " _______________________________

    " use alt+hjkl to move between split/vsplit panels
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

  " }

  " ..[ Resize windows ].. {
  " ______________________

    " You can use the command :resize +5 or :res -5 to resize windows
    " this are just quick shortcuts
    nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

  " }

" }

" ...[ File- and MIME-Type configuration ]... {
" ________________________________________________________________________

  " ..[ Default Autocommands ].. {
  " ____________________________

  " group autocmd's to give vim a chance to overwrite them when it resources
  " this config file.
  " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html

  augroup vimrcEx
    " clear group
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Cucumber navigation commands
    autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
    autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile Appraisals set filetype=ruby
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 80 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80 spelllang=de,en

    autocmd BufRead,BufNewFile *.de.md setlocal spelllang=de
    autocmd BufRead,BufNewFile *.en.md setlocal spelllang=en

    " Allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass setlocal iskeyword+=-

    " help section - disable spellcheck and quit with 'q'
    autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>

    autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
    autocmd FileType gitcommit setlocal spell
  augroup END
  " }

  " ..[ Indent modes ].. {

    " don't automatically indent lines
    " set noautoindent
    "set smartindent  # depricated over cindent
    set cindent

    "  turn of for this files:
    autocmd BufEnter *.html setlocal indentexpr=
    autocmd BufEnter *.htm setlocal indentexpr=
    autocmd BufEnter *.xml setlocal indentexpr=
    autocmd BufEnter *.xsd setlocal indentexpr=

  " }

  " ..[ Markdown ].. {

    " Enable Markdown folding
    " https://bitcrowd.dev/folding-sections-of-markdown-in-vim
    let g:markdown_folding = 1
    " au FileType markdown setlocal foldlevel=1
    au FileType markdown setlocal foldlevel=99

    " ...[ Plugin Vim-markdown ]... {

      " Disabled automatically folding
      let g:vim_markdown_folding_disabled=1
      " LeTeX math
      let g:vim_markdown_math=1
      " Highlight YAML frontmatter
      let g:vim_markdown_frontmatter=1

      " Vim-instant-markdown -----------------

      " If it takes your system too much, you can specify
      " let g:instant_markdown_slow = 1
      " if you don't want to manually control it
      " you can open this setting
      " and when you open this, you can manually trigger preview
      " via the command :InstantMarkdownPreview
      let g:instant_markdown_autostart = 0

    " }

  " }

  " ..[ HTML ].. {

    " Treat <li> and <p> tags like the block tags they are
    let g:html_indent_tags = 'li\|p'

  " }

" }

" ...[ Spell checking ] {
" ________________________________________________________________________

  " ..[ Activate spell checking ].. {
  " _______________________________

    if has("spell")
      " turn spelling on by default
      " set spell

      " toggle spelling with F4 key
      map <F4> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

      " they were using white on white
      highlight PmenuSel ctermfg=black ctermbg=lightgray

      " limit it to just the top 10 items
      set sps=best,10
    endif

  " }

  " ..[ Spellfile location ].. {
  " __________________________

    " Set spellfile to location that is guaranteed to exist, can be
    " symlinked to Dropbox or kept in Git.
    " set spellfile=$HOME/.config/nvim/spell/vim-spell-en.local
  " }

" }

" ...[ Usefull Things ]... {
" ________________________________________________________________________

  " ..[ Open a Terminal <c-s-n> ].. {
  " _______________________________

    function! OpenTerminal()
      split term://zsh
      resize 10
    endfunction

    " Open a terminal on ctrl+shift+n
    nnoremap <c-s-n> :call OpenTerminal()<CR>

  " }

  " ..[ Faster editing of your init.vim (.vimrc) <leader>v ].. {
  " __________________________________________________________

    " Edit your .config/nvim/init.vim or ~/.vimrc faster
    nnoremap <Leader>v :e $MYVIMRC<cr>

    " Reload config file (neovim/vim)
    nnoremap <leader>sv :source $MYVIMRC<CR>

  " }

  " ..[ Auto-Reload init.vim / .vimrc on save ].. {
  " _____________________________________________

    " TODO: create a function for a transparent background
    " and use it in the basic settings and in ReloadVimrc

    "silent function! SetTransparentBG()
    "    hi Normal guibg=NONE ctermbg=NONE
    "    hi EndOfBuffer guibg=NONE ctermbg=NONE
    "endfunction

    " Reloads vimrc after saving but keep cursor position
    " Source: <https://medium.com/@voyeg3r/vim-nvim-useful-tricks-456efd767240>
    if !exists('*ReloadVimrc')
        fun! ReloadVimrc()
            let save_cursor = getcurpos()
            source $MYVIMRC
            call setpos('.', save_cursor)
            hi Normal guibg=NONE ctermbg=NONE
            hi EndOfBuffer guibg=NONE ctermbg=NONE
       endfun
    endif
    autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

  " }

  " ..[ Disable automatic commenting on new line ].. {
    " <https://vim.fandom.com/wiki/Disable_automatic_comment_insertion>
    " tempory reenable: ":set formatoptions+=cro"

    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " }


  " ..[ Save (some) configurations per file and window ].. {

    " the settings are saved under .vim/views - you can savely delete this
    " files to reset the file/window specific settings

    " save cursor position in file and window
    set viewoptions+=cursor

    " save manually created folds, opened/closed folds and local fold options
    set viewoptions+=folds

    " don't save options and mappings local to window and buffer
    " leave this, to prevent vim to auto change dirs
    set viewoptions-=options

    if !exists("g:skipview_files")
        let g:skipview_files = []
    endif

    function! MakeViewCheck()
        if &l:diff | return 0 | endif
        if &buftype != '' | return 0 | endif
        if expand('%') =~ '\[.*\]' | return 0 | endif
        if empty(glob(expand('%:p'))) | return 0 | endif
        if &modifiable == 0 | return 0 | endif
        if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
        if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

        let file_name = expand('%:p')
        for ifiles in g:skipview_files
            if file_name =~ ifiles
                return 0
            endif
        endfor

        return 1
    endfunction

    augroup AutoView
        autocmd!
        " Autosave & Load Views.
        autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
        autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
    augroup END



  " }

  " ..[ Tmux support ].. {
  " ____________________

    " TODO: NOT WORKING on ish / blocking neovim on ish

    " Automatic window renaming
    " <http://dhruvasagar.com/2013/11/26/vim-for-multiple-projects-in-tmux-windows>
"    augroup Tmux
"      au!
"
"      autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
"      autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
"    augroup END

  " }

" }

" ...[ To be polished and experimental stuff... ]... {
" ________________________________________________________________________

    if has('nvim')
        " Neovim specific commands
    else
        " Standard vim specific commands
    endif

    ":set tabstop=4      " To match the sample file
    ":set noexpandtab    " Use tabs, not spaces
    ":%retab!
    "

    " Better navigation through vim help on german keyboards
    "nnoremap ü <C-]>
    "nnoremap Ü <C-O>

    " Create the 'tags' file (may need to install ctags first)
    command! MakeTags !ctags -R .


    " turn terminal to normal mode with escape
    tnoremap <Esc> <C-\><C-n>

    " start terminal in insert mode
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif

    " Distraction free writing
    map <leader>F :Goyo \| set linebreak<CR>

    " Activate spellcheck
    map <leader>e :setlocal spell! spelllang=de_de,en_us<CR>
    " TODO integrate hunspell

    " compiling and preview
    map <leader>c :w! \| !compiler <c-r>%<CR><CR>

    map <leader>o :!opout <c-r>%<CR><CR>

    " TODOs

    " check https://github.com/jreybert/vimagit


    "map <leader>l :Lf<CR>

    map <leader>l <Plug>LfEdit
    map <leader>L <Plug>LfSplit

    noremap <F3> :NERDTreeToggle<CR>

    " ------------------------------
    " configure netrw

    " ## Navigation in netrw
    "
    " enter - Open files/directories
    " - - Go up one directory
    " u - Go back to previously visited directory (like <C-o> in vim)
    " U - Go forward to subsequently visited directory (like <C-i> in vim)

    " enter works just fine to open files and directories, but there are some other options available too:

    " o - Open file/directory in new horizontal split
    " v - Open file/directory in new vertical split
    " t - Open file/directory in new tab
    " p - Preview file without (moving the cursor from netrw)
    " x - Open the file/directory with the default system app

    " - <https://shapeshed.com/vim-netrw/>
    " - <https://blog.stevenocchipinti.com/2016/12/28/using-netrw-instead-of-nerdtree-for-vim/>
    " - <https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f>

    " changing the directory view (toggle different styles with `i`)
    let g:netrw_liststyle = 3

    " remove the top banner
    let g:netrw_banner = 0

    " change how files are opened
    " 1 - open files in a new horizontal split
    " 2 - open files in a new vertical split
    " 3 - open files in a new tab
    " 4 - open in previous window
    "let g:netrw_browse_split = 4

    " let g:netrw_altv = 1

    " set with to 25% of page
    "let g:netrw_winsize = 25

    " augroup ProjectDrawer
    "   autocmd!
    "   autocmd VimEnter * :Vexplore
    " augroup END

" }

" ...[ Local config - after ]... {
" ________________________________________________________________________

" TODO make .config, nvim and vim compatible

  " Run local config, if it exits
  if filereadable(expand("~/.vimrc.local"))
      source ~/.vimrc.local
  endif

  " ..[ Inspirations for local config ].. {

    " this stuff is (or will be no longer) activated in global config,
    " but you can put it into your .vimrc.local

    " .[ Train j k l h movements ]. {
      " remap arrow keys to train movement with h,l,k,j

      "nnoremap <Left> :echoe "Use h"<CR>
      "nnoremap <Right> :echoe "Use l"<CR>
      "nnoremap <Up> :echoe "Use k"<CR>
      "nnoremap <Down> :echoe "Use j"<CR>
    " }

    " .[ Reminder for remapped ESC ]. {

      " remind me to use jj or jk inplace of ESC
      "inoremap <silent> <esc> :echoe "Use jj"<CR>

    " }

  " }

" }

" ...[ Thanks to ]... {
" ________________________________________________________________________
"
"  Thanks to the default vimrc files from Arch, Debian, Ubuntu, CentOS,
"  Manjaro and many more...
"
"  Special thanks to all the people who shared their dotfiles, snippets
"  and knowledge on the internet.
"
"  - <https://wiki.archlinux.org/index.php/vim/.vimrc>
"  - <https://github.com/tpope/tpope/blob/master/.vimrc>
"  - <https://github.com/joshuaspence/dotfiles/tree/master/home/vim/>
"
"  and many more...
"
" }

" ...[ Vim Modline ]... {
" ________________________________________________________________________
"
" vim: set sw=2 ts=2 sts=2 et tw=79 fmr={,} fdm=marker:
"
" }

call SourceIfExists("~/.config/nvim/local.vim")
call SourceIfExists("~/.local.vim")
