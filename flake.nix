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
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:kuetemeier/nixvim?ref=jkr";
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
    , nixvim
    , flake-utils
    }:

    with builtins;

    let

      flakeOutput = flake-utils.lib.eachDefaultSystem (system:

    let
      config = { };
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      inputs = self.inputs;

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
          nixvim'.makeNixvimWithModule { module = value; })
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
      packages = rec {
        # Default Neovim configuration for systems
        neovim = self.packages.${system}.neovim-jkr-system;

        # Default package is my Neovim configuration for Desktops
        # Just run it with `nix run` or `nix run .#neovim-jkr -- test.md`
        default = self.packages.${system}.neovim-jkr;

        # Hello World package for fun and tests
        inherit (pkgs) hello;
      } // neovimJkrPkgs // { };

      apps = rec {
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
