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

