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

" ...[ Plugins ]... {
" ________________________________________________________________________


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

" }


