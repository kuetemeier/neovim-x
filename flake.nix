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
    ,
    }:
    let
      config = {
        colorschemes.gruvbox.enable = true;
      };
      config2 = {
        colorschemes.gruvbox.enable = false;
      };
    in
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};

      # module = (import ./module-test.nix { inherit config pkgs; inputs = self.inputs; });

      importNixFilesFromDir = dir: with rec {
        inherit (builtins) readDir attrNames substring stringLength listToAttrs;
        inherit (pkgs.lib.attrsets) filterAttrs;
        inherit (pkgs.lib.strings) hasSuffix;

        files = readDir dir;
        nixFiles = filterAttrs (name: _: hasSuffix ".nix" name) files;
        fileNames = attrNames nixFiles; 
        # remove '.nix'
        onlyNames = map (name: substring 0 ((stringLength name) - 4) name) fileNames;
        res = listToAttrs
          (map (name: {
                inherit name;
                value = import (dir + "/${name}.nix") { inherit config pkgs; lib = pkgs.lib; inputs = self.inputs; };
                } ) onlyNames);

      }; res;

      nixvim' = nixvim.legacyPackages."${system}";

      suites = importNixFilesFromDir ./suites;

      jkr-nvim-test = nixvim'.makeNixvimWithModule { module = suites.jkr-test; };

      jkr-nvim-minimal = nixvim'.makeNixvim (import ./profiles { inherit config pkgs; }).minimal;

      jkr-nvim-default = nixvim'.makeNixvim (import ./default-config.nix { inherit config pkgs; });
      # jkr-nvim-test = nixvim'.makeNixvimWithModule { inherit module; };

    in
    {
      packages = rec {
        nvim = jkr-nvim-default;
        inherit jkr-nvim-test;
        hello = pkgs.hello;
        inherit jkr-nvim-minimal;

        default = nvim;
      };

      apps = rec {
        # default configuration
        jkr-nvim-default = {
          type = "app";
          program = "${self.packages.${system}.nvim}/bin/nvim";
        };
        default = jkr-nvim-default;

        # test configuration - `nix run .#jkr-test`
        jkr-test = {
          type = "app";
          program = "${self.packages.${system}.jkr-nvim-test}/bin/nvim";
        };
        test = jkr-test;

        # For fun and tests - Hello World - `nix run .#hello`
        hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
      };

      # For Development: style .nix files with `nix fmt` in this repo
      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    });
}
