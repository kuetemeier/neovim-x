"  .config/nvim/init.vim
"  nvim / vim configuration file
"
"  Copyright (c) 1998-2021 Joerg Kuetemeier <https://kuetemeier.de>
"
"  {{{ Apache License 2.0
"      __________________
"
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
"  }}}

" {{{ Start the vim / neovim magic
"     ____________________________

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

  " {{{ Syntax highlighting
  "     ___________________

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
      syntax on " Vim5 and later versions support syntax highlighting

      " configure syntastic syntax checking to check on open as well as save
      "let g:syntastic_check_on_open=1
      "let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
    endif

  " }}}

  " don't unload buffer when it is |abandon|ed
  " notice: required by many config options in this file
  " e.g. 'set path+=**' etc.
  set hidden

  " Jump to another file easy
  " type 'gf' to jump to a file under the cursor (CTRL-6 jumps back)
  " gd ................................ jump to local definitions
  " gD ................................ jump to global definitions
  "
  " Search down into subfolders
  " Provides tab-completion for all file-related tasks
  set path+=**

  " Globally enable (1) or disable (0) plugin loading (e.g. for debugging)
  let g:pluginsLoad=1

" }}}

" {{{ Custom Functions
"     ________________

  " Source a file (if it exists) {
  function! SourceIfExists(file)
    if filereadable(expand(a:file))
      exe 'source' a:file
    endif
  endfunction

  " Check if the given (name) Plugin is loaded
  function! PlugLoaded(name)
    return match(&runtimepath, a:name) != -1
  endfunction

" }}}

" {{{ Load local config
"     _________________
"
" If it exists and before the rest of the main config

  " Run nix specific config, if it exits
  if filereadable(expand("~/.config/nvim/init-nix-before.vim"))
      source ~/.config/nvim/init-nix-before.vim
  endif

  " Run local config, if it exits
  if filereadable(expand("~/.config/nvim/init-local-before.vim"))
      source ~/.config/nvim/init-local-before.vim
  endif

" }}}

" {{{ Environment
"     ___________

  " {{{ Identify platform
  "     _________________

    silent function! OSX()
      return has('macunix')
    endfunction
    silent function! LINUX()
      return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
      return  (has('win16') || has('win32') || has('win64'))
    endfunction

  " }}}

  " {{{ Basics
  "     ______

    if !WINDOWS()
      set shell=/bin/sh
    endif

  " }}}

  " {{{ Windows Compatible
  "     __________________

    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if WINDOWS()
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif

  " }}}

  " {{{ Detect TMUX
  "     ___________

    if executable('tmux') && filereadable(expand('~/.zshenv')) && $TMUX !=# ''
      let g:vim_is_in_tmux = 1
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    else
      let g:vim_is_in_tmux = 0
    endif

  " }}}

  " {{{ Detect usage as 'man pager'
  "     ___________________________

    if exists('g:vim_man_pager')
      let g:vim_enable_startify = 0
    else
      let g:vim_enable_startify = 1
    endif

  " }}}

" }}}

" {{{ Plugins
"     _______

  if pluginsLoad

  " {{{ Init Plugin system
  "     __________________
    call SourceIfExists("~/.config/nvim/config/plugins-init.vim")
  " }}}

  " {{{ Must have plugins
  "     _________________
  let g:pluginsMustHave=1
  if pluginsMustHave

    " {{{ vim-commentary - Comment out lines
    Plug 'tpope/vim-commentary'
    " }}}

    " {{{ deopplete.nvim - Dark powered asynchronous completion framework for neovim/Vim8
    "" NOTE: Pyhton support required
    "" You must install pynvim, e.g. with `pip3 install --user pynvim`
    "" or with `pacman -S python-pynvim`
    "if has('nvim')
    "  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "else
    "  Plug 'Shougo/deoplete.nvim'
    "  Plug 'roxma/nvim-yarp'
    "  Plug 'roxma/vim-hug-neovim-rpc'
    "endif
    "Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    "" Python Autocompletion: do not forget to install jedi
    ""Plug 'deoplete-plugins/deoplete-jedi'
    "" Ruby Autocompletion: do not forget to install solargraph
    ""Plug 'uplus/deoplete-solargraph'
    " }}}

    " {{{ EditorConfig plugin for Vim
    Plug 'editorconfig/editorconfig-vim'
    " }}}

    " {{{ vim-polyglot - A solid language pack for Vim (e.g. for syntax highlighting
    Plug 'sheerun/vim-polyglot'
    " }}}

  endif
  " }}}

  " {{{ Load some plugins
  "     _________________

  let g:pluginsLoadMore=1
  if pluginsLoadMore

    " {{{ Markdown-TOC - Create Table of Content form Markdown files
    Plug 'rderik/vim-markdown-toc', { 'branch': 'add-anchors-to-headings/drc2r' }
    " }}}

    " {{{ Goyo - Distraction-free writing in Vim
    Plug 'junegunn/goyo.vim'
    " <https://github.com/junegunn/goyo.vim>
    "
    " :Goyo ......................... Toggle Goyo
    " :Goyo [dimension] ............. Turn on resize Goyo
    " :Goyo! ........................ Turn Goyo off
    " }}}

    " {{{ VimWiki - A personal wiki for Vim
    Plug 'vimwiki/vimwiki'
    " }}}

    " {{{ ALE - Linting and fixing (async)
    Plug 'dense-analysis/ale'
    " }}}

    " {{{ syntastic - Show errors hints and higlights
    Plug 'vim-syntastic/syntastic'
    " }}}

    " {{{ tabular - Vim script for text filtering and alignment
    Plug 'godlygeek/tabular'
    " Align Text with Tabular.vim:
    " <http://vimcasts.org/episodes/aligning-text-with-tabular-vim/>
    " }}}

    " {{{ vim-markdown - THE Markdown plugin for vim
    Plug 'plasticboy/vim-markdown'
    " }}}

    " {{{ vim-instant-markdown - Markdown realtime preview
    " External dependencies: Before you want to use it, please run
    " `sudo npm -g install instant-markdown-d`
    Plug 'suan/vim-instant-markdown'
    " }}}

    " {{{ Lf - lf in vim for file management
    " required hack for neovim
    Plug 'rbgrouleff/bclose.vim'
    Plug 'thezeroalpha/vim-lf'
    " }}}

    " {{{ gina - Git for vim
    " Alternative: 'tpope/vim-fugitive'
    Plug 'lambdalisue/gina.vim'
    " }}}

    " {{{ surround - easier bracket management
    Plug 'tpope/vim-surround'
    " }}}

    " {{{ csv - CSV format support for vim
    Plug 'chrisbra/csv.vim'
    " }}}

    " {{{ fzf - fzf in vim
    Plug 'junegunn/fzf.vim'
    " }}}

    " {{{ ultisnips - snippet management
    " TODO: remaps the tab keys... colides with autocompletion
"    Plug 'SirVer/ultisnips'
    " }}}

    " {{{ nvim-cmp

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip user.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

set completeopt=menu,menuone,noselect

lua <<EOF

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  require'lspconfig'.denols.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  --require('lspconfig')[%YOUR_LSP_SERVER%].setup {
  --  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  --}

EOF

    " }}}

    " {{{ gitgutter - Git status icons
    Plug 'airblade/vim-gitgutter'
    " }}}

    " {{{ vim-todo-lists - TODO lists management
    Plug 'aserebryakov/vim-todo-lists'
    " }}}

    " {{{ blaber.nvim - A git blame plugin for (neo)vim inspired by VS Code's GitLens plugin
    " Plug 'apzelos/blamer.nvim'
    " }}}

    " {{{ neoformat - A (Neo)vim plugin for formatting code
    " see <https://github.com/sbdchd/neoformat> and add helpers
    Plug 'sbdchd/neoformat'
    " }}}

    " {{{ vim-elixir - Elixr language support
    Plug 'elixir-editors/vim-elixir'
    " }}}

    " Lightline Plugins and configuration {{{
    Plug 'itchyny/lightline.vim'
    Plug 'sainnhe/artify.vim'
    Plug 'albertomontesg/lightline-asyncrun' " Integration of https://github.com/skywind3000/asyncrun.vim
    "Plug 'neoclide/coc.nvim', {'branch': 'release'} " Git status is provided by coc-git
    Plug 'rmolin88/pomodoro.vim'
    Plug 'ryanoasis/vim-devicons'
    " }}}

    " {{{ vim-dispatch - Asynchronous build and test dispatcher
    Plug 'tpope/vim-dispatch'
    " }}}

    " {{{ ack.vim - Run your favorite search tool from Vim, with an enhanced results list
    Plug 'mileszs/ack.vim'
    " }}}

    " {{{ vim-startify - Startscreen for vim
    if g:vim_enable_startify == 1
      Plug 'mhinz/vim-startify'
    endif
    " }}}

    " {{{ Tmuxline
    if g:vim_is_in_tmux == 1 && !has('win32')
      Plug 'sainnhe/tmuxline.vim', {'on': ['Tmuxline', 'TmuxlineSnapshot']}
    endif
    " }}}

  endif
  " }}}

  " {{{ Colorscheme Plugins
  "     ___________________

    Plug 'sainnhe/gruvbox-material'
    Plug 'sainnhe/edge'
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/everforest'
    Plug 'joshdick/onedark.vim'
    " A better color scheme for the late night coder
    Plug 'ajmwagar/vim-deus'
    Plug 'rakr/vim-one'
    Plug 'morhetz/gruvbox'
    Plug 'sonph/onehalf', { 'rtp': 'vim' }

  " }}}

  " {{{ Initialize plugin system
  "     ________________________
    call plug#end()
  " }}}

  " {{{ Plugin Configuration
  "     ____________________

    " {{{ VimWiki - Config
    if PlugLoaded("vimwiki")
      let g:vimwiki_list = [{'path': '~/Documents/notes/notes/',
                            \ 'syntax': 'markdown', 'ext': '.md'}]
    endif " }}}

    " {{{ ALE - Config
    if PlugLoaded("ale")
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
    endif
    " }}}

    " {{{ vim-markdown - Config
    if PlugLoaded("vim-markdown")
      " See Filetype -> Markdown configuration

      " Enable fenced code block syntax highlighting in markdown documents
      let g:markdown_fenced_languages = [
        \ 'html',
        \ 'css',
        \ 'scss',
        \ 'sass=scss',
        \ 'js=javascript',
        \ 'jsx=javascriptreact',
        \ 'ts=typescript',
        \ 'tsx=typescript.tsx',
        \ 'c',
        \ 'cpp',
        \ 'cs',
        \ 'java',
        \ 'py=python',
        \ 'python',
        \ 'go',
        \ 'rust',
        \ 'rs=rust',
        \ 'php',
        \ 'sh',
        \ 'shell=sh',
        \ 'bash=sh',
        \ 'vim',
        \ 'sql',
        \ 'json',
        \ 'yaml',
        \ 'toml'
        \ ]

      " Syntax highlight is synchronized in 50 lines. It may cause collapsed
      " highlighting at large fenced code block. In the case, please set larger
      " value in your vimrc
      let g:markdown_minlines = 100

    endif
    " }}}

    " {{{ lightline - Config
    if PlugLoaded("vim-markdown")
    " TODO: refactor

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

    endif
    " }}}

    " {{{ Lf - Config

      if executable("lf")
        augroup lf
          autocmd! *
          autocmd FileType lf setlocal nornu
          autocmd FileType lf setlocal nonumber
        augroup END
      endif

      "map <leader>l <Plug>LfEdit
      "map <leader>L <Plug>LfSplit

    " }}}

    " {{{ vim-commentary - Config
    if PlugLoaded("vim-commentary")
      " map keys for easier commenting
      noremap <space>/ :Commentary<CR>
      vnoremap <space>/ :Commentary<CR>
    endif
    " }}}

    " {{{ deoplete - Config
    if PlugLoaded("deoplete")
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
    endif
    " }}}

    " {{{ syntastic - Config
    if PlugLoaded("syntasic")
      " syntastic
      set statusline+=%#warningmsg#
      set statusline+=%{SyntasticStatuslineFlag()}
      set statusline+=%*
      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_auto_loc_list = 1
      let g:syntastic_check_on_open = 1
      let g:syntastic_check_on_wq = 1
    endif
    " }}}

    if PlugLoaded("neoformat")
      " AutoFormat
      noremap <F5> :Neoformat<CR>
    endif

    if PlugLoaded("ack")
      " Inspired by <https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/>
      " Use ripgrep for searching ⚡️
      " Options include:
      " --vimgrep -> Needed to parse the rg response properly for ack.vim
      " --type-not sql -> Avoid huge sql file dumps as it slows down the search
      " --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
      let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

      " Auto close the Quickfix list after pressing '<enter>' on a list item
      let g:ack_autoclose = 1

      " Any empty ack search will search for the work the cursor is on
      let g:ack_use_cword_for_empty_search = 1

      " Don't jump to first match
      cnoreabbrev Ack Ack!

      " Maps <leader>/ so we're ready to type the search keyword
      nnoremap <Leader>/ :Ack!<Space>
      " }}}

      " Navigate quickfix list with ease
      nnoremap <silent> [q :cprevious<CR>
      nnoremap <silent> ]q :cnext<CR>
    endif

  " }}}

  endif
" }}} Plugins

" {{{ Colors
"     ______

  " {{{ Try to use Truecolor Mode
  "     _________________________

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

  " }}}

  " {{{ Set color scheme
  "     ________________

    "colorscheme gruvbox-material
    "colorscheme hybrid

    "colorscheme sonokai
    let g:lightline = { 'colorscheme': 'jellybeans' }

    "colorscheme one
    "colorscheme onedark
    "colorscheme onehalfdark
    "let g:lightline = { 'colorscheme': 'onedark' }

    "colorscheme deus
    let g:deus_termcolors=256

    " set background=light     " for the light version
    set background=dark        " for the dark version
    let g:one_allow_italics = 1 " I love italic for comments

    "colorscheme gruvbox
    colorscheme hybrid
    "let g:lightline = { 'colorscheme': 'gruvbox' }
  " }}}

  " {{{ Transparent Background
  "     ______________________

    " transparent bg
    " autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    " For Vim<8, replace EndOfBuffer by NonText
    " autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

  " }}}

"}}}

call SourceIfExists("~/.config/nvim/config/lightline-jk.vim")

" {{{ Basic settings
"     ______________

  " {{{ Options
  "     _______

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

    " When a bracket is inserted, briefly jump to the matching
    " one. The jump is only done if the match can be seen on the
    " screen. The time to show the match can be set with
    " 'matchtime'.
    set showmatch

    " NeoVim loads a <default> plugin 'matchparen' (see h: pi_paren)
    " Setting `loaded_machparen` to 1 disables this
    " So no more jumping around when moving over a bracket.
    let loaded_matchparen = 1

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

    " Wrap long lines
    set wrap

  " }}}

  " {{{ Movement
  "     ________

    " have the h and l cursor keys wrap between lines (like <Space> and <BkSpc>
    " do by default), and ~ covert case over line breaks; also have the cursor
    " keys wrap in insert mode:
    set whichwrap=h,l,~,[,]

    " use <Ctrl>+N/<Ctrl>+P to cycle through files:
    nnoremap <C-N> :next<CR>
    nnoremap <C-P> :prev<CR>

  " }}}

  " {{{ Search configuration
  "     ____________________

    set hlsearch        " When there is a previous search pattern, highlight all
                        " its matches.

    set incsearch       " While typing a search command, show immediately where the
                        " so far typed pattern matches.

    set ignorecase      " Ignore case in search patterns.

    set smartcase       " Override the 'ignorecase' option if the search pattern
                        " contains upper case characters.

  " }}}

  " Better copy & paste {{{
  " _______________________

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

    " {{{ Copy and Paste with clipboard Support
    "     _____________________________________

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

    " }}}

  " }}}

  " {{{ Tab handling
  "     ____________

    " Softtabs, 2 spaces
    set tabstop=2     " Number of spaces that a <Tab> in the file counts for
    set shiftwidth=2  " Number of spaces to use for each step of (auto)indent
    set shiftround
    set expandtab     " Use the appropriate number of spaces to insert a <Tab>.
                      " Spaces are used in indents with the '>' and '<' commands
                      " and when 'autoindent' is on. To insert a real tab when
                      " 'expandtab' is on, use CTRL-V <Tab>.
  " }}}

  " {{{ Display extra whitespace
  "     ________________________

  set list listchars=tab:»·,trail:·

  " }}}

  " {{{ Make it obvious where 80 characters is
  "     ______________________________________

    set textwidth=79 " width of document (used by gd)
    set colorcolumn=+1
    set nowrap " don't automatically wrap on load
    set fo-=t  " don't automatically wrap text when typing
    highlight ColorColumn ctermbg=233

    set colorcolumn=79,120
  " }}}

  " {{{ Line Numbers
  "     ____________

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

   " }}}

" }}}

" {{{ Keybindings and Mappings
"     ________________________

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

  " {{{ Remapping of german keys
  "     ________________________

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

  " }}}

  " {{{ Additional ESC sequences for mode changes
  "     _________________________________________

    " some like to have 'jk' as sequence... bad idea if your name is Jörg Kütemeier
    inoremap <silent> jj <esc>
    inoremap <silent> jl <esc>
    nnoremap <silent> <leader>. :

  " }}}

  " {{{ Easier formatting of paragraphs
  "     _______________________________

    " have Q reformat the current paragraph
    " (or selected text if there is any)

    vmap Q gq
    nmap Q gqap

    vnoremap Q gqqp
    vnoremap Q gq

  " }}}

  " {{{ Move lines up and down

    nnoremap <C-Down> :m .+1<CR>==
    nnoremap <C-Up> :m .-2<CR>==
    inoremap <C-Down> <Esc>:m .+1<CR>==gi
    inoremap <C-Up> <Esc>:m .-2<CR>==gi
    vnoremap <C-Down> :m '>+1<CR>gv=gv
    vnoremap <C-Up> :m '<-2<CR>gv=gv

    nnoremap <C-j> :m .+1<CR>==
    nnoremap <C-k> :m .-2<CR>==
    inoremap <C-j> <Esc>:m .+1<CR>==gi
    inoremap <C-k> <Esc>:m .-2<CR>==gi
    vnoremap <C-j> :m '>+1<CR>gv=gv
    vnoremap <C-k> :m '<-2<CR>gv=gv

  " }}}

  " {{{ Map Shift-Tab to reverse Tab

    " for command mode
    nnoremap <S-Tab> <<
    nnoremap <Tab> >>
    " for insert mode
    inoremap <S-Tab> <C-d>

  " }}}

  " {{{ Easier moving between tabs
  "     __________________________

    " Easier moving between tabs
"    map <Leader>n <esc>:tabprevious<CR>
"    map <Leader>m <esc>:tabnext<CR>

  " }}}

  " Clears highlighted search terms
  nnoremap <silent> <C-l> :nohl<CR><C-l

  " Opens terminal
  noremap <F6> :term<CR>
  " Toggle terminal input
  tnoremap <F12> <C-\><C-n>

  " :set makeprg=ssh\ my_server\ 'make && ./main && exit'
  " :let &makeprg="ssh my_server 'make && ./main && exit'"
  map <F10> :Copen<cr>G
  map <F9> :update<cr>:Make<cr>
  map <F11> :cclose<cr>

" }}}

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
    " nmap <leader>..0 :set foldlevel=0<CR>
    " nmap <leader>..1 :set foldlevel=1<CR>
    " nmap <leader>..2 :set foldlevel=2<CR>
    " nmap <leader>..3 :set foldlevel=3<CR>
    " nmap <leader>..4 :set foldlevel=4<CR>
    " nmap <leader>..5 :set foldlevel=5<CR>
    " nmap <leader>..6 :set foldlevel=6<CR>
    " nmap <leader>..7 :set foldlevel=7<CR>
    " nmap <leader>..8 :set foldlevel=8<CR>
    " nmap <leader>..9 :set foldlevel=9<CR>

    nmap z0 :set foldlevel=0<CR>
    nmap z1 :set foldlevel=1<CR>
    nmap z2 :set foldlevel=2<CR>
    nmap z3 :set foldlevel=3<CR>
    nmap z4 :set foldlevel=4<CR>
    nmap z5 :set foldlevel=5<CR>
    nmap z6 :set foldlevel=6<CR>
    nmap z7 :set foldlevel=7<CR>
    nmap z8 :set foldlevel=8<CR>
    nmap z9 :set foldlevel=9<CR>
  endif

" }}}

" {{{ Windows and Panels
"     __________________
"

  " {{{ Natural open new windows
  "     ________________________

    " Open new split panes to right and bottom, which feels more natural
    set splitbelow
    set splitright

  " }}}

  " {{{ Quicker window movement
  "     _______________________

    " use alt+hjkl to move between split/vsplit panels
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

  " }}}

  " {{{ Resize windows
  "     ______________

    " You can use the command :resize +5 or :res -5 to resize windows
    " this are just quick shortcuts
    nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

  " }}}

" }}}

" {{{ File- and MIME-Type configuration
"     _________________________________

  " {{{ Default Autocommands
  "     ____________________

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

    autocmd BufNewFile,BufRead *.json set foldmethod=syntax
  augroup END
  " }}}

  " {{{ Indent modes
  "     ____________

    " don't automatically indent lines
    " set noautoindent
    "set smartindent  # depricated over cindent
    set cindent

    "  turn of for this files:
    autocmd BufEnter *.html setlocal indentexpr=
    autocmd BufEnter *.htm setlocal indentexpr=
    autocmd BufEnter *.xml setlocal indentexpr=
    autocmd BufEnter *.xsd setlocal indentexpr=

  " }}}

  " {{{ Markdown
  "     ________

    " Enable Markdown folding
    " https://bitcrowd.dev/folding-sections-of-markdown-in-vim
    let g:markdown_folding = 1
    " au FileType markdown setlocal foldlevel=1
    au FileType markdown setlocal foldlevel=99

    " {{{ Plugin Vim-markdown
    "     ___________________

      " Disabled automatically folding
      let g:vim_markdown_folding_disabled=1
      " LeTeX math
      let g:vim_markdown_math=1
      " Highlight YAML frontmatter
      let g:vim_markdown_frontmatter=1

      " Vim-instant-markdown

      " If it takes your system too much, you can specify
      " let g:instant_markdown_slow = 1
      " if you don't want to manually control it
      " you can open this setting
      " and when you open this, you can manually trigger preview
      " via the command :InstantMarkdownPreview
      let g:instant_markdown_autostart = 0

    " }}}

  " }}}

  " {{{ HTML
  "     ____

    " Treat <li> and <p> tags like the block tags they are
    let g:html_indent_tags = 'li\|p'

  " }}}

" }}}

" {{{ Spell checking
"     ______________

  " {{{ Activate spell checking
  "     _______________________

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

  " }}}

  " {{{ Spellfile location
  "     __________________

    " Set spellfile to location that is guaranteed to exist, can be
    " symlinked to Dropbox or kept in Git.
    " set spellfile=$HOME/.config/nvim/spell/vim-spell-en.local
  " }}}

" }}}

" {{{ Usefull Things
"     ______________

  " {{{ Open a Terminal - <c-s-n>
  "     _________________________

    function! OpenTerminal()
      "split term://zsh
      split term://$SHELL
      resize 10
    endfunction

    " Open a terminal on ctrl+shift+n
    nnoremap <c-s-n> :call OpenTerminal()<CR>

  " }}}

  " {{{ Faster editing of your init.vim (.vimrc) - <leader>v
  "     ____________________________________________________

    " Edit your .config/nvim/init.vim or ~/.vimrc faster
    nnoremap <Leader>v :e $MYVIMRC<cr>

    " Reload config file (neovim/vim)
    nnoremap <leader>sv :source $MYVIMRC<CR>

  " }}}

  " {{{ Auto-Reload init.vim / .vimrc on save
  "     _____________________________________

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
"            hi Normal guibg=NONE ctermbg=NONE
"            hi EndOfBuffer guibg=NONE ctermbg=NONE
       endfun
    endif
    autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

  " }}}

  " {{{ Disable automatic commenting on new line
  "     ________________________________________

    " <https://vim.fandom.com/wiki/Disable_automatic_comment_insertion>
    " tempory reenable: ":set formatoptions+=cro"

    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " }}}

  " {{{ Save (some) configurations per file and window
  "     ______________________________________________

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

  " }}}

  " {{{ Tmux support
  "     ____________

    augroup tmux
      autocmd!
      if exists('$TMUX')
        autocmd BufReadPost,FileReadPost,BufNewFile,FocusGained * call system("tmux rename-window " . expand("%:t"))
        autocmd VimLeave,FocusLost * call system("tmux set-window-option automatic-rename")
      endif
    augroup END
  " }}}

" }}}

" {{{ To be polished and experimental stuff...
"     ________________________________________

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

    " {{{ Configure netrw
    "     _______________

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

    " }}}

" }}}

" {{{ Local config - after
"     ____________________

" TODO make .config, nvim and vim compatible

  " Run local config, if it exits
  if filereadable(expand("~/.vimrc.local"))
      source ~/.vimrc.local
  endif

  " {{{ Inspirations for local config

    " this stuff is (or will be no longer) activated in global config,
    " but you can put it into your .vimrc.local

    " .[ Train j k l h movements ]. {
      " remap arrow keys to train movement with h,l,k,j

      "nnoremap <Left> :echoe "Use h"<CR>
      "nnoremap <Right> :echoe "Use l"<CR>
      "nnoremap <Up> :echoe "Use k"<CR>
      "nnoremap <Down> :echoe "Use j"<CR>
    " }

    " {{{ Reminder for remapped ESC

      " remind me to use jj or jk inplace of ESC
      "inoremap <silent> <esc> :echoe "Use jj"<CR>

    " }}}

  " }}}

" }}}

" {{{ Thanks to
"     _________
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
"  - <https://github.com/sainnhe/dotfiles>
"
"  and many more...
"
" }}}

" {{{ Source local files - if exists
"     ______________________________

  call SourceIfExists("~/.config/nvim/local.vim")
  call SourceIfExists("~/.local.vim")

"}}}

" {{{ Vim line
" vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0
" }}}
