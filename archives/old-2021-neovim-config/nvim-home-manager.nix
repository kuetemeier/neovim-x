#  config/nvim/default-home-manager.nix
#  Nix Home-Manager configuration for NeoVim
#
#
#        //_/  Jörg Kütemeier <https://kuetemeier.de>
#     (_// )   (c) Copyright 2021 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the
#  Mozilla Public License, v. 2.0.
#
#  If a copy of the MPL was not distributed with this file,
#  You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}

{ config, pkgs, lib, ... }:

# let definitions {{{

let

  # Example:
  # (pluginGitHub {
  #   owner = "folke";
  #   repo = "which-key.nvim";
  #   version = "jkr-2021-12-02";
  #   rev = "d3032b6d3e0adb667975170f626cb693bfc66baa";
  #   sha256 = "sha256-mgLmwP8ci9VjRiwBedZDPXi6CjNtJy3iOJDbmSXtisk=";
  # })
  pluginGitHub =
    { repo
    , owner ? repo
    , rev
    , sha256
    , version ? rev
    }: pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = version;
      src = pkgs.fetchFromGitHub {
        inherit owner repo rev sha256;
      };
    };

    sumneko-lua-pkg = pkgs.sumneko-lua-language-server;

in

# }}}

{

  # NeoVim - Home-Manager Configuration {{{
  programs.neovim = { 

    enable = true;

    viAlias = true;
    vimAlias = true;

    withNodeJs = false;
    withRuby = false;
    withPython3 = false;

    # NOTE: use min. v0.5.1
    # NixOS 22.11 includes v0.8.1
    #package = pkgs.unstable.neovim-unwrapped;

    # NeoVim - extraPackages {{{
    extraPackages = with pkgs; [
      # to include libstdc++
      stdenv.cc.cc.lib

      # Tool to access the X clipboard from a console application
      xclip

      # General purpose Language Server
      # We will use it for linting and autoformatting
      # e.g. with luaformatter or markdownlint
      efm-langserver

      # helper for tree-sitter PlugIn
      tree-sitter

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      nodePackages.typescript
      nodePackages.typescript-language-server
      gopls
      nodePackages.pyright
      rust-analyzer

      # A work-in-progress language server for Nix, with syntax
      # checking and basic completion
      rnix-lsp

      nodePackages.vim-language-server # vim language server

      # Lua Language Server coded by Lua
      # WARNING: don't forget to change the lspconfig below,
      #          when you change this package
      sumneko-lua-pkg

      # A language server for Bash
      nodePackages.bash-language-server

      # HTML/CSS/JSON language servers extracted from [vscode]
      nodePackages.vscode-langservers-extracted

      # YAML Language Server
      nodePackages.yaml-language-server

      # Docker language server
      nodePackages.dockerfile-language-server-nodejs

      # A frontend-independent IDE "smartness" server for Elixir. Implements the
      # "Language Server Protocol" standard and provides debugger support via the
      # "Debug Adapter Protocol"
      elixir_ls

      shfmt

      # Prettier - an opinionated code formatter
      # https://prettier.io/
      # License: MIT
      nodePackages.prettier

      gcc
      nodejs
      (python39.withPackages (pp: with pp; [
        pynvim
      ]))

      # --------
      #  linter

      vim-vint # Fast and Highly Extensible Vim script Language Lint
      # implemented by Python

      shellcheck # Shell script analysis tool

      vale

      luaformatter # Code formatter for Lua
      nixpkgs-fmt

      # A fast, flexible, configuration-based command-line interface for linting
      # Markdown/CommonMark files with the `markdownlint` library
      nodePackages.markdownlint-cli2

    ]; # }}}

    # NeoVim - plugins {{{
    plugins = with pkgs.vimPlugins; [

      # vim-nix # Nix syntax highlighting

      vim-commentary # Comment out/in lines

      editorconfig-vim # EditorConfig plugin for Vim

      vim-markdown # THE Markdown plugin for vim
      vim-markdown-toc # Create Table of Content from Markdown files

      # https://github.com/iamcco/markdown-preview.nvim
      # markdown-preview-nvim

      vimwiki # A personal wiki for Vim

      goyo-vim # Distraction-free writing in Vim

      vimtex # Latex Support

      {
        plugin = gruvbox-community;
        config = ''
          set background=dark " Setting dark mode
          colorscheme gruvbox
          let g:gruvbox_italic=1
        '';
      }

      {
        plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }


      # fugitive.vim: A Git wrapper so awesome, it should be illegal
      # https://github.com/tpope/vim-fugitive
      # License: unknown
      vim-fugitive 

      # dispatch.vim: Asynchronous build and test dispatcher
      # https://github.com/tpope/vim-dispatch
      vim-dispatch

      vim-devicons # required by lightline-config TODO: move to nvim-web-devicons
      lightline-vim
      csv-vim # CSV format support for vim

      #  tree - Explorer  {{{
      # _________________

      # nvim-web-devicons - lua `fork` of vim-web-devicons for neovim
      nvim-web-devicons

      nvim-tree-lua

      # }}}


      #  Language Server Plugins  {{{
      # _________________________

      # lspconfig - Quickstart configurations for the Nvim LSP client 
      nvim-lspconfig

      # }}}


      #  Which Key  {{{
      # ___________

      # which-key - Create key bindings that stick. WhichKey is a lua plugin
      # for Neovim 0.5 that displays a popup with possible keybindings of the
      # command you started typing.
      # https://github.com/folke/which-key.nvim
      # License: Apache 2.0
      (pluginGitHub {
        owner = "folke";
        repo = "which-key.nvim";
        version = "jkr-2021-12-02";
        rev = "d3032b6d3e0adb667975170f626cb693bfc66baa";
        sha256 = "sha256-mgLmwP8ci9VjRiwBedZDPXi6CjNtJy3iOJDbmSXtisk=";
      })

      # }}}


      # {{{ (better) Syntax Highlighting
      #    ______________________________ 

      # treesitter - Nvim Treesitter configurations and abstraction layer
      nvim-treesitter

      # rainbow - Rainbow parentheses for neovim using tree-sitter
      nvim-ts-rainbow

      # }}}


      # {{{ Completion
      #    ____________

      # nvim-cmp - A completion plugin for neovim coded in Lua.
      # <https://github.com/hrsh7th/nvim-cmp>
      # License: MIT
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "nvim-cmp";
        version = "jkr-2021-11-24";
        rev = "2e4270d02843d15510b3549354e238788ca07ca5";
        sha256 = "sha256-hCPZiJCzeNre7z8e+/+HVOsg2TOPHk9o5kAtHW3rW9M=";
      })

      # cmp-buffer - nvim-cmp source for buffer words
      # <https://github.com/hrsh7th/cmp-buffer>
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "cmp-buffer";
        version = "jkr-2021-11-24";
        rev = "a706dc69c49110038fe570e5c9c33d6d4f67015b";
        sha256 = "sha256-FdWs15eTad4igwN5F5+CKxSMQi9eX07BXjM/HgTIURc=";
      })

      # cmp-nvim-lsp - nvim-cmp source for neovim builtin LSP client
      # <https://github.com/hrsh7th/cmp-nvim-lsp>
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "cmp-nvim-lsp";
        version = "jkr-2021-11-25";
        rev = "134117299ff9e34adde30a735cd8ca9cf8f3db81";
        sha256 = "sha256-jLfW4xoYnEOWa7oWSmkB7vNxu9Jgttbme+nTiAC92so=";
      })

      # cmp-path
      # https://github.com/hrsh7th/cmp-path
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "cmp-path";
        version = "jkr-2021-11-25";
        rev = "81518cf6ae29f5f0c79cd47770ae90ff5225ee13";
        sha256 = "sha256-0qNHc11+FqVZGEqPJqfKqsfkfGueZ0Y9uYJ7dsDqYYY=";
      })

      # cmp-cmdline - nvim-cmp source for vim's cmdline
      # https://github.com/hrsh7th/cmp-cmdline
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "cmp-cmdline";
        version = "jkr-2021-11-25";
        rev = "e5aa12620b6cae9ba5ce27aed2c47a99b81f004f";
        sha256 = "sha256-cHJfaxBcgb+VApPima+2jP7Cmv8P/KUuSijUzzvx8g8=";
      })

      # cmp-emoji - nvim-cmp source for emoji
      # https://github.com/hrsh7th/cmp-emoji
      (pluginGitHub {
        owner = "hrsh7th";
        repo = "cmp-emoji";
        version = "jkr-2021-11-25";
        rev = "19075c36d5820253d32e2478b6aaf3734aeaafa0";
        sha256 = "sha256-zc5GNkwdVHaeEoCer9tz40F2Xc8qTzPw6NbgkMjjWQI=";
      })

      # lspkind-nvim - vscode-like pictograms for neovim lsp completion items
      # https://github.com/onsails/lspkind-nvim
      (pluginGitHub {
        owner = "onsails";
        repo = "lspkind-nvim";
        version = "jkr-2021-11-25";
        rev = "1557ce5b3b8e497c1cb1d0b9d967a873136b0c23";
        sha256 = "sha256-e82PbisrgQvk/ZG6XY7JajbRwpNOzlslDGH8ehrPLmM=";
      })

      # cmp-latex-symbols - Add latex symbol support for nvim-cmp
      # https://github.com/kdheepak/cmp-latex-symbols
      (pluginGitHub {
        owner = "kdheepak";
        repo = "cmp-latex-symbols";
        version = "jkr-2021-11-25";
        rev = "29dc9e53d17cd1f26605888f85500c8ba79cebff";
        sha256 = "sha256-9KHNmb0yt/AmUOf1etbj7rkDXTYYj1S89K8ycD3gEp8=";
      })

      # }}}


      # {{{ fzf
      #    _____

      # nvim-fzf - A Lua API for using fzf in neovim
      # required by fzf-lua
      # <https://github.com/vijaymarupudi/nvim-fzf>
      # License: AGPL-3.0
      (pluginGitHub {
        owner = "vijaymarupudi";
        repo = "nvim-fzf";
        version = "jkr-2021-11-24";
        rev = "7cc3670b00f4d6e0968289f8b3bee7481cab3e73";
        sha256 = "sha256-65IgJwM0s6RurLL+LCLnOZiuBd/Zom7SeiRlR4pPl7o=";
      })

      # fzf-lua - Improved fzf.vim written in lua
      # <https://github.com/ibhagwan/fzf-lua>
      # License: AGPL-3.0
      (pluginGitHub {
        owner = "ibhagwan";
        repo = "fzf-lua";
        version = "jkr-2021-11-24";
        rev = "fad1ef47e3a887e19b7b183b822a04d512e7373c";
        sha256 = "sha256-9v9q/8LzaY8E7FnBfW92cAKe7eWWeh9ogrhj5uyb1RY=";
      })

      # }}}

      # plenary - full; complete; entire; absolute; unqualified. All the lua
      # https://github.com/nvim-lua/plenary.nvim
      # functions I don't want to write twice.
      (pluginGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        version = "jkr-2021-11-28";
        rev = "1c31adb35fcebe921f65e5c6ff6d5481fa5fa5ac";
        sha256 = "sha256-JAy4VL/jU+j3pxTvdbe5BlIwdEix4uA1xHxQCKYyqxw=";
      })

      # gitsigns - 
      # https://github.com/lewis6991/gitsigns.nvim
      # License: MIT
      (pluginGitHub {
        owner = "lewis6991";
        repo = "gitsigns.nvim";
        # version = "jkr-2021-11-28";
        # rev = "95845ef39ce0a98f68cdfdcf7dd586c5e965acc7";
        # updated 2022-12-03
        version = "v0.5";
        rev = "v0.5";
        sha256 = "sha256-kyiQoboYq4iNLOj1iKA2cfXQ9FFiRYdvf55bX5Xvj8A=";
      })

      #  Linter  {{{
      # ________

      # nvim-lint - An asynchronous linter plugin for Neovim (>= 0.5)
      #             complementary to the built-in Language Server Protocol support.
      # <https://github.com/mfussenegger/nvim-lint>
      # License: unknown
      (pluginGitHub {
        owner = "mfussenegger";
        repo = "nvim-lint";
        version = "jkr-2021-11-24";
        rev = "6ecc5da9335a908f0812cb33c7fa9bc38fb6a20d";
        sha256 = "sha256-K7ufWcorQdyEoBEN+NXpEk6s7aEw9PrApZBPoQdEQrw=";
      })

      # }}}


      #  Snippets  {{{
      # __________

      # LuaSnip - Snippet Engine for Neovim written in Lua
      # <https://github.com/L3MON4D3/LuaSnip>
      # Documentation: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
      # License: Apache 2.0
      (pluginGitHub {
        owner = "L3MON4D3";
        repo = "LuaSnip";
        version = "jkr-2021-11-24";
        rev = "f400b978b1dbca96e9e190b7009c415c09b8924c";
        sha256 = "sha256-/igENgj3s/yE8zQ3UObl8wMfAwMgHdTc1lEXS3ehK1Q=";
      })

      # cmp_luasnip - LuaSnip completion source for nvim-cmp
      # <https://github.com/saadparwaiz1/cmp_luasnip>
      # License: unknown
      (pluginGitHub {
        owner = "saadparwaiz1";
        repo = "cmp_luasnip";
        version = "jkr-2021-11-24";
        rev = "16832bb50e760223a403ffa3042859845dd9ef9d";
        sha256 = "sha256-DMeNqiAEkKxr4psDAC0IObAl0tU1eXRHUqe9ti11hkE=";
      })

      # friendly-snippets - Set of preconfigured snippets for different languages.
      # https://github.com/rafamadriz/friendly-snippets
      # License: MIT
      (pluginGitHub {
        owner = "rafamadriz";
        repo = "friendly-snippets";
        version = "jkr-2021-11-24";
        rev = "05bfa7681b8f11b664fab657001c2efb6f3ec85e";
        sha256 = "sha256-en6ijDAyfTZKgZv+wgA3yaP5Xpd25bZrBSk9gsVwY4Q=";
      })

      # }}}


    ]; # }}}

    extraConfig = ''
      if filereadable(expand("${config.xdg.configHome}/nvim/jkr-init.vim"))
        source ${config.xdg.configHome}/nvim/jkr-init.vim
      endif
    '';

  };
  # }}}

  # XDG config/nvim {{{
  # _______________

  # Build "init.vim"
  # Read NeoVim configuration files from filesystem.
  # This enables syntaxhighlighting and linting for those files.
  
  # Generated Config from the Home-Manager NeoVim Module
  # NO MORE: ${config.programs.neovim.generatedConfigViml}

  xdg.configFile."nvim/jkr-init.vim".text = ''
    " Here You can prepend some config, if needed

    " Our Base Configuration in 'vim' syntax - "hard included into init.vim"
    ${lib.strings.fileContents ./vim/base.vim}

    " NOTE: tree.vim must be included BEFORE tree.lua!
    " So, here seems to be a good place
    ${lib.strings.fileContents ./vim/tree.vim}

    " Our Base Configuration in 'lua' syntax - "hard included into init.vim"
    lua << EOF

    -- Define 'global' variables with path support from Nix
    Sumneko_root_path = "${sumneko-lua-pkg}/share/lua-language-server"
    Sumneko_binary = "${sumneko-lua-pkg}/bin/lua-language-server"

    ${lib.strings.fileContents ./lua/base.lua}

    -- LuaSnip plugin config
    require ('nvim-conf/luasnip')

    -- nvim-cmp plugin config
    require ('nvim-conf/completion')

    -- Language Server config
    require ('nvim-conf/lspconfig')

    -- web-devicons.lua plugin config
    require ('nvim-conf/web-devicons')

    -- tree.lua plugin config
    require ('nvim-conf/tree')

    -- treesitter.lua
    require ('nvim-conf/treesitter')

    -- fzf.lua
    require ('nvim-conf/fzf')

    -- gitsigns.lua
    require('nvim-conf/gitsigns')

    -- golang.lua
    require('nvim-conf/golang')

    -- lint.lua
    require('nvim-conf/lint')

    -- efm.lua
    require('nvim-conf/efm')

    EOF

    " Source local `vim/nvim-local.vim` Vim config file if it exits
    if filereadable(expand("${config.xdg.configHome}/nvim/vim/nvim-local.vim"))
      source ${config.xdg.configHome}/nvim/vim/nvim-local.vim
    endif

    " Source local `lua/nvim-local.lua` Lua config file if it exits
    if filereadable(expand("${config.xdg.configHome}/nvim/lua/nvim-local.lua"))
      lua require 'nvim-local'
    endif
  '';

  # Prepare some more stuff in the nvim config dir
  xdg.configFile = {
    "nvim/colors/hybrid.vim".source = ./colors/hybrid.vim;

    # WARNING: DON'T USE THIS!
    # "recursive" will not notice when source files are updated!
    # List them seperatly like below, so the nix build knows about them!
    # 
    # "nvim/lua/kuetemeier" = {
    #   source = ./lua/kuetemeier;
    #   recursive = true;
    # };

    "nvim/lua/base.lua".source = ./lua/base.lua;
    "nvim/lua/nvim-conf/completion.lua".source = ./lua/nvim-conf/completion.lua;
    "nvim/lua/nvim-conf/efm.lua".source = ./lua/nvim-conf/efm.lua;
    "nvim/lua/nvim-conf/fzf.lua".source = ./lua/nvim-conf/fzf.lua;
    "nvim/lua/nvim-conf/gitsigns.lua".source = ./lua/nvim-conf/gitsigns.lua;
    "nvim/lua/nvim-conf/golang.lua".source = ./lua/nvim-conf/golang.lua;
    "nvim/lua/nvim-conf/lint.lua".source = ./lua/nvim-conf/lint.lua;
    "nvim/lua/nvim-conf/lspconfig.lua".source = ./lua/nvim-conf/lspconfig.lua;
    "nvim/lua/nvim-conf/luasnip.lua".source = ./lua/nvim-conf/luasnip.lua;
    "nvim/lua/nvim-conf/mappings.lua".source = ./lua/nvim-conf/mappings.lua;
    "nvim/lua/nvim-conf/tree.lua".source = ./lua/nvim-conf/tree.lua;
    "nvim/lua/nvim-conf/treesitter.lua".source = ./lua/nvim-conf/treesitter.lua;
    "nvim/lua/nvim-conf/web-devicons.lua".source = ./lua/nvim-conf/web-devicons.lua;

    "nvim/vim/lightline-jkr.vim".source = ./vim/lightline-jkr.vim;
  };

  # }}}

}
