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

