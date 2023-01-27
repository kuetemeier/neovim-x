"  nvim/config/tree.vim
"
"  Note: See also tree.lua
"
"  NeoVim configuration file for nvim-tree.lua
"  A file explorer tree for neovim written in lua
"  <https://github.com/kyazdani42/nvim-tree.lua>
"
"     .|
"     ||_,  Jörg Kütemeier <https://kuetemeier.de>
"     |' `  Copyright (c) 1998-2021 - Apache License 2.0
"   `-'
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

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

