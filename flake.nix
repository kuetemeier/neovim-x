#  flake.nix - Flake file for my Neovim configurations
#
#  See README.md
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}

{
  description = "jkr-neovim: Joerg Kuetemeier - NeoVim Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    # Nix Language server, an incremental analysis assistent for writing in Nix.
    # https://github.com/oxalica/nil
    nil = {
      # url = "github:oxalica/nil";
      url = "github:oxalica/nil?ref=2023-01-01";
      # url = "github:oxalica/nil?ref=6e5321582ca7595455edf2a9643f83ce390d0a71";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixvim = {
      # url = "github:kuetemeier/nixvim?ref=jkr";
      # Last Update 2023-01-26
      url = "github:pta2002/nixvim?ref=c73bef16ab2f8fe87210a840a2178a593f107eae";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        # TODO: beautysh.inputs.utils.follows = "flake-utils";
      };
    };

  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixvim
    , flake-utils
    , nil
    }:

    with builtins;

    let

      flakeOutput = flake-utils.lib.eachDefaultSystem (system:

    let
      config = { };
      unstable-overlay = final: prev: {
        unstable = import nixpkgs-unstable { inherit system; config = { allowUnfree = true; }; };
      };
      # TODO: use correct version of nil package => making overlay work
      pkgs = (nixpkgs.legacyPackages.${system}.extend unstable-overlay).extend nil.overlays.nil;
      # pkgs =  import nixpkgs { inherit system; overlays = [ nil.overlays.nil ]; };
      inherit (pkgs) lib;
      inherit (self) inputs;

      nixvim' = nixvim.legacyPackages."${system}";

      # importNixFilesFromDir :: Path -> attrSet
      #
      # Example
      #
      #   importNixFilesFromDir ./suites
      #   => {
      #         jkr-test = ( imported file ./suites/jkr-test.nix );
      #         jkr      = ( imported file ./suites/jkr.nix );
      #         ...
      #      }
      importNixFilesFromDir = dir: with rec {
        inherit (builtins) readDir attrNames substring stringLength listToAttrs;
        inherit (lib.attrsets) filterAttrs;
        inherit (lib.strings) hasSuffix;

        files = readDir dir;
        nixFiles = filterAttrs (name: _: hasSuffix ".nix" name) files;
        fileNames = attrNames nixFiles;
        # remove '.nix'
        onlyNames = map (name: substring 0 ((stringLength name) - 4) name) fileNames;
        res = listToAttrs
          (map
            (name: {
              inherit name;
              value = import (dir + "/${name}.nix") { inherit config pkgs lib inputs; };
            })
            onlyNames);

      }; res;

      # Import ./suites configurations
      suites = importNixFilesFromDir ./suites;

      # Build all Packages from ./suites
      neovimJkrPkgs = builtins.mapAttrs
        (name: value:
          nixvim'.makeNixvimWithModule { module = value; inherit pkgs; })
        suites;

      # Build all Apps from ./suites
      neovimJkrApps = builtins.mapAttrs
        (name: value:
          {
            type = "app";
            program = "${self.packages.${system}.${name}}/bin/nvim";
          })
        suites;

    in
    {
      packages = {
        # Default Neovim configuration for systems
        neovim = self.packages.${system}.neovim-jkr-system;

        # Default package is my Neovim configuration for Desktops
        # Just run it with `nix run` or `nix run .#neovim-jkr -- test.md`
        default = self.packages.${system}.neovim-jkr;

        # Hello World package for fun and tests
        inherit (pkgs) hello;
      } // neovimJkrPkgs // { };

      apps = {
        # Plain Neovim (for tests and debugging)
        plain = {
          type = "app";
          program = "${pkgs.neovim}/bin/neovim";
        };

        # Set default App to neovim-jkr
        default = self.apps.${system}.neovim-jkr;

        # For fun and tests - Hello World - `nix run .#hello`
        hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
      } // neovimJkrApps;

      # For Development: style .nix files with `nix fmt` in this repo
      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    });
  in flakeOutput // rec {
    overlays.default = final: prev: {
      neovim-jkr = flakeOutput.packages.${final.system}.neovim-jkr;
      neovim-jkr-minimal = flakeOutput.packages.${final.system}.neovim-jkr-minimal;
      neovim-jkr-system = flakeOutput.packages.${final.system}.neovim-jkr-system;
    };
    overlay = overlays.default;
  };
}
