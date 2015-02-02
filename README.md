# dotvim - Personal Vim Configuration

This is [my](https://github.com/jkuetemeier) ***personal*** vim configuration.
It is inspired by [dotvim](https://github.com/bling/dotvim) created by [Bailey
Ling](https://github.com/bling), particularly the configuration structure. I
also would like to thank [Steve Francia](http://spf13.com/) aka.
[spf13](https://github.com/spf13), [Tim Pope](https://github.com/tpope) and
[Shougo](https://github.com/Shougo) for their work, plugins an configuration
examples.

## Installation

1.  clone this repository into your `~/.vim` directory
2.  `git clone --recursive git@github.com:jkuetemeier/dotvim.git .vim`
3.  `mv ~/.vimrc ~/.vimrc.backup`
4.  Choose a dotvimrc file `ln -s ~/.vim/dotvimrc ~/.vimrc` or create one:

```
let g:dotvim_settings = {}
let g:dotvim_settings.version = 1
source ~/.vim/vimrc
```
5.  On Fedora: `sudo yum install cmake gcc-c++ python-libs python-devel`
5.  startup vim and neobundle will detect and ask you install any missing
    plugins. You can also manually initiate this with `:NeoBundleInstall`.
    NOTE: *This step may take a long time for some plugins*
6.  done!


## Introduction

While it is very easy to install this and get up and running on a brand new
machine, i recommend that you do not install this unless you fully understand
everything that's going on inside. Scan it for tips and tricks, or fork and
customize it for *your* needs.

### Versioning

the `g:dotvim_settings.version` is a simple version number which is manually
edited.  it is used to detect whether significant breaking changes have been
introduced so that users of the distribution can be notified accordingly.

## Customization

*  since the distribution is just one file, customization is straightforward.
   any customizations can be added to the `g:dotvim_settings` variable, which
   will be used whilst sourcing the distribution's `vimrc` file.  here is an
   example:

```
" this is the bare minimum
let g:dotvim_settings = {}
let g:dotvim_settings.version = 2

" here are some basic customizations, please refer to the top of the vimrc file
" for all possible options
let g:dotvim_settings.default_indent = 3
let g:dotvim_settings.max_column = 80
let g:dotvim_settings.colorscheme = 'my_awesome_colorscheme'

" change the default directory where all miscellaneous persistent files go
let g:dotvim_settings.cache_dir = "/some/place/else"

" by default, language specific plugins are not loaded.  this can be changed
" with the following:
let g:dotvim_settings.plugin_groups_exclude = ['ruby','python']

" if there are groups you want always loaded, you can use this:
let g:dotvim_settings.plugin_groups_include = ['go']

" alternatively, you can set this variable to load exactly what you want
let g:dotvim_settings.plugin_groups = ['core','web']

" if there is a particular plugin you don't like, you can define this variable
" to disable them entirely let
g:dotvim_settings.disabled_plugins=['vim-foo','vim-bar']

" finally, load the distribution
source ~/.vim/vimrc

" anything defined here are simply overrides
set wildignore+=\*/node_modules/\*
set guifont=Wingdings:h10
```

## Autocomplete

The default configuration uses [youcompleteme][ycm] + [ultisnips][us].
 [youcompleteme][ycm] needs to compile a Pyhton module. If there is no
 Python or compile environment, you can use.

1.  [neocomplete][nc] + [neosnippet][ns] if you have `lua` enabled.
2.  [neocomplcache][ncl] + [neosnippet][ns] if you only have vimscript
    available

This can be configured with `g:dotvim_settings.autocomplete_method`.

## Standard modifications

*  if you have either [ack](http://betterthangrep.com/) or
   [ag](https://github.com/ggreer/the_silver_searcher) installed, they will be
   used for `grepprg`
*  all temporary files are stored in `~/.vim/.cache`, such as backup files and
   persistent undo

## Mappings

### Insert mode
*  `jj`, `kj` remapped for "smash escape"

### Normal mode
*  `<Leader>fef` format entire file
*  `<Leader>f$` strip current line of trailing white space
*  window shortcuts
  *  `<Leader>v` vertical split
  *  `<Leader>s` horizontal split
  *  `<Leader>vsa` vertically split all buffers
  *  `<C-h>` `<C-j>` `<C-k>` `<C-l>` move to window in the direction of hkjl
*  window killer
  *  `Q` remapped to close windows and delete the buffer (if it is the last
     buffer window)
* searching
  *  `<Leader>fw` find the word under cursor into the quickfix list
  *  `<Leader>ff` find the last search into the quickfix list
  *  `/` replaced with `/\v` for sane regex searching
  *  `<cr>` toggles hlsearch
*  `<Down>` `<Up>` maps to `:bprev` and `:bnext` respectively
*  `<Left>` `<Right>` maps to `:tabprev` and `:tabnext` respectively
*  `gp` remapped to visually reselect the last paste
*  `gb` for quick going to buffer
*  `<Leader>l` toggles `list` and `nolist`
*  profiling shortcuts
   * `<Leader>DD` starts profiling all functions and files into a file
     `profile.log`
   * `<Leader>DP` pauses profiling
   * `<Leader>DC` continues profiling
   * `<Leader>DQ` finishes profiling and exits vim
* `<Leader>p` insert in new line

### Visual mode
*  `<Leader>s` sort selection
*  `>` and `<` automatically reselects the visual selection

## Plugins

### [unite.vim](https://github.com/Shougo/unite.vim)
*  this is an extremely powerful plugin that lets you build up lists from
   arbitrary sources
*  mappings
  *  `<space><space>` go to anything (files, buffers, MRU, bookmarks)
  *  `<space>y` select from previous yanks
  *  `<space>l` select line from current buffer
  *  `<space>b` select from current buffers
  *  `<space>o` select from outline of current file
  *  `<space>s` quick switch buffer
  *  `<space>/` recursively search all files for matching text (uses `ag` or
     `ack` if found)

### [bufkill.vim](http://www.vim.org/scripts/script.php?script_id=1147)
*  `<Leader>bd`, `<Leader>q` or `:BD` will kill a buffer without changing the
   window layout

### [sneak.vim](https://github.com/justinmk/vim-sneak)
*  motion on steriods

### [easygrep](http://www.vim.org/scripts/script.php?script_id=2438)
*  makes search/replacing in your project a lot easier without relying on
   `find` and `sed`
*  the loading time of this plugin is relatively heavy, so it is not loaded at
   startup.  to load it on-demand, use `<Leader>vo`, which opens the options
   window.
*  `<Leader>vv` find word under the cursor
*  `<Leader>vV` find whole word under the cursor
*  `<Leader>vr` perform global search replace of word under cursor, with
   confirmation
*  `<Leader>vR` same as vr, but matches whole word

### [fugitive](https://github.com/tpope/vim-fugitive)
*  git wrapper
*  `<Leader>gs` status
*  `<Leader>gd` diff
*  `<Leader>gc` commit
*  `<Leader>gb` blame
*  `<Leader>gl` log
*  `<Leader>gp` push
*  `<Leader>gw` stage
*  `<Leader>gr` rm
*  in addition to all the standard bindings when in the git status window, you
   can also use `U` to perform a `git checkout --` on the current file

### [gitv](https://github.com/gregsexton/gitv)
*  nice log history viewer for git
*  `<Leader>gv`

### [unimpaired](https://github.com/tpope/vim-unimpaired)
*  many additional bracket `[]` maps
*  `<C-up>` to move lines up
*  `<C-down>` to move lines down

### [nerdtree](https://github.com/scrooloose/nerdtree)
*  file browser
*  `<F9>` toggle browser
*  `<F8>` open tree to path of the current file

### [tcomment](https://github.com/tomtom/tcomment_vim)
*  very versatile commenting plugin that can do motions
*  `gcc` to toggle or `gc{motion}`

### [scratch](https://github.com/mtth/scratch.vim)
*  Unobtrusive scratch window
*  `gs` in normal mode opens scratch window in insert mode
*  `gs` in visual mode pastes the current selection
*  variant `gS` clears the scratch buffer before opening it

### [ctrlp](https://github.com/kien/ctrlp.vim)
*  fuzzy file searching
*  `<C-p>` to bring up the search
*  `\t` search the current buffer tags
*  `\T` search global tags
*  `\l` search all lines of all buffers
*  `\b` search open buffers
*  `\o` parses the current file for functions with
   [funky](https://github.com/tacahiroy/ctrlp-funky)

### [nrrwrgn](http://github.com/chrisbra/NrrwRgn)
*  `<Leader>nr` puts the current visual selection into a new scratch buffer,
   allowing you to perform global commands and merge changes to the original
   file automatically

### [tabular](https://github.com/godlygeek/tabular)
*  easily aligns code
*  `<Leader>a&`, `<Leader>a=`, `<Leader>a:`, `<Leader>a,`, `<Leader>a|`

### [gist](https://github.com/mattn/gist-vim)
*  automatically get or push changes for gists with `:Gist`

### [emmet](https://github.com/mattn/emmet-vim)
*  makes for writing html/css extremely fast
*  for supported most filetypes, `<tab>` will be mapped to automatically expand
   the line (you can use `<C-v><Tab>` to insert a tab character if needed)
*  for other features, default plugin mappings are available, which means
   `<C-y>` is the prefix, followed by a variety of options (see `:help
   zencoding`)

### [undotree](https://github.com/mbbill/undotree)
*  visualize the undo tree
*  `<F5>` to toggle

### [youcompleteme][ycm]/[ultisnips][us]
*  amazingly fast fuzzy autocomplete engine combined with an excellent snippets
   library
*  use `<C-n>`, `<tab>` and `<C-p>`, `<s-tab>` to go back/forward between
   selections, and `<Leader>m` to expand snippets. Jump through the replace
   positions with `<Leader>m` and `<Leader>.`.

### [neocomplcache][ncl]/[neosnippet][ns]
*  autocomplete/snippet support as a fallback choice when YCM and/or python is
   unavailable
*  `<Tab>` to select the next match, or expand if the keyword is a snippet
*  if you have lua installed, it will use [neocomplete][nc] instead

### [vimshell](https://github.com/Shougo/vimshell)
*  `<Leader>c` splits a new window with an embedded shell

### [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)
*  mapped to `<C-N>`, this will select all matching words and lets you
   concurrently change all matches at the same time

# and some more plugins
*  [surround](https://github.com/tpope/vim-surround) makes for quick work of
   surrounds
*  [repeat](https://github.com/tpope/vim-repeat) repeat plugin commands
*  [speeddating](https://github.com/tpope/vim-speeddating) `Ctrl+A` and
   `Ctrl+X` for dates
*  [gist](https://github.com/mattn/gist-vim) awesome plugin for your gist needs
*  [signature](https://github.com/kshenoy/vim-signature) shows marks beside
   line numbers
*  [matchit](https://github.com/vim-scripts/matchit.zip) makes your `%` more
   awesome
*  [syntastic](https://github.com/scrooloose/syntastic) awesome syntax checking
   for a variety of languages
*  [bufferline](https://github.com/bling/vim-bufferline) simple plugin which
   prints all your open buffers in the command bar
*  [indent-guides](https://github.com/nathanaelkane/vim-indent-guides) vertical
   lines
*  [signify](https://github.com/mhinz/vim-signify) adds + and - to the signs
   column when changes are detected to source control files (supports
   git/hg/svn)
*  [delimitmate](https://github.com/Raimondi/delimitMate) automagically adds
   closing quotes and braces
*  [startify](https://github.com/mhinz/vim-startify) gives you a better start
   screen
*  [expand-region](https://github.com/terryma/vim-expand-region) expand and
   shrink selections

# and even more plugins...
*  i think i've listed about half of the plugins contained in this
   distribution, so please have a look at the vimrc directly to see all plugins
   in use

## Credits

i wanted to give special thanks to all of the people who worked on the
following projects, or people simply posted their vim distributions, because i
learned a lot and took many ideas and incorporated them into my configuration.

*  [bling](https://github.com/bling/dotvim)
*  [janus](https://github.com/carlhuda/janus)
*  [spf13](https://github.com/spf13/spf13-vim)
*  [yadr](http://skwp.github.com/dotfiles/)
*  [astrails](https://github.com/astrails/dotvim)
*  [tpope](https://github.com/tpope)
*  [scrooloose](https://github.com/scrooloose)
*  [shougo](https://github.com/Shougo)
*  [lokaltog](https://github.com/Lokaltog)
*  [sjl](https://github.com/sjl)
*  [terryma](https://github.com/terryma)

## License Copyright 2015 Jörg Kütemeier

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License.  You may obtain a copy of the
License at

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied.  See the License for the
specific language governing permissions and limitations under the License.

[ycm]: https://github.com/Valloric/YouCompleteMe
[us]: https://github.com/SirVer/ultisnips
[nc]: https://github.com/Shougo/neocomplete.vim
[ncl]: https://github.com/Shougo/neocomplcache.vim
[ns]: https://github.com/Shougo/neosnippet.vim
