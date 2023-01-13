{
  description = "jkr-neovim: Joerg Kuetemeier - NeoVim Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:pta2002/nixvim";
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

    flake-utils.lib.eachDefaultSystem (system:

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

      suites = importNixFilesFromDir ./suites;

      nvimJkrPkgs = builtins.mapAttrs
        (name: value:
          nixvim'.makeNixvimWithModule { module = value; })
        suites;

      nvimJkrApps = builtins.mapAttrs
        (name: value:
          {
            type = "app";
            program = "${self.packages.${system}.${name}}/bin/nvim";
          })
        suites;

    in
    {
      packages = rec {
        nvim = self.packages.${system}.nvim-jkr-system;
        default = self.packages.${system}.nvim-jkr;
        inherit (pkgs) hello;
      } // nvimJkrPkgs // { };

      apps = rec {
        plain = {
          type = "app";
          program = "${pkgs.neovim}/bin/nvim";
        };

        default = self.apps.${system}.nvim-jkr;

        # # default configuration
        # nvim-jkr = {
        #   type = "app";
        #   program = "${self.packages.${system}.nvim-jkr}/bin/nvim";
        # };
        # default = nvim-jkr;

        # For fun and tests - Hello World - `nix run .#hello`
        hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
      } // nvimJkrApps;

      # For Development: style .nix files with `nix fmt` in this repo
      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    });
}
