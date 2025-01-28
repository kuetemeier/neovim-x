#  flake.nix
#  Flake: Main flake file
#  @see: /nix/flake
#
{
  description = "Neovim - Batteries included";

  inputs = {
    # Crane
    #
    # A Nix library for building cargo projects. Never build twice
    # thanks to incremental artifact caching.
    #
    # GitHub: https://github.com/ipetkov/crane

    # crane.inputs.nixpkgs.follows = "nixpkgs";
    crane.url = "github:ipetkov/crane";

    # devenv
    #
    # Fast, Declarative, Reproducible, and Composable Developer Environments
    # using Nix
    #
    # Homepage: https://devenv.sh/
    # GitHub: https://github.com/cachix/devenv

    devenv.inputs.flake-compat.follows = "flake-compat";
    devenv.inputs.nix.follows = "nixpkgs";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    devenv.inputs.pre-commit-hooks.follows = "pre-commit-hooks-nix";
    devenv.url = "github:cachix/devenv";

    # TODO: remove linyinfeng to remove devshell - We use devenv

    devshell.inputs.nixpkgs.follows = "nixpkgs";
    # devshell.inputs.systems.follows = "systems";
    devshell.url = "github:numtide/devshell";

    flake-compat.flake = false;
    flake-compat.url = "github:edolstra/flake-compat";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";

    flake-root.url = "github:srid/flake-root";

    flake-utils.inputs.systems.follows = "systems";
    flake-utils.url = "github:numtide/flake-utils";

    # flat-flake
    #
    # Enforce flat flake inputs
    #
    # GitHub: https://github.com/linyinfeng/flat-flake

    flat-flake.inputs.crane.follows = "crane";
    flat-flake.inputs.flake-compat.follows = "flake-compat";
    flat-flake.inputs.flake-parts.follows = "flake-parts";
    flat-flake.inputs.flake-utils.follows = "flake-utils";
    flat-flake.inputs.nixpkgs.follows = "nixpkgs";
    flat-flake.inputs.rust-overlay.follows = "rust-overlay";
    flat-flake.inputs.systems.follows = "systems";
    flat-flake.inputs.treefmt-nix.follows = "treefmt-nix";
    flat-flake.url = "github:linyinfeng/flat-flake";

    gitignore-nix.inputs.nixpkgs.follows = "nixpkgs";
    gitignore-nix.url = "github:hercules-ci/gitignore.nix";

    # Haumea
    #
    # Filesystem-based module system for Nix
    #
    # GitHub: https://github.com/nix-community/haumea

    haumea.inputs.nixpkgs.follows = "nixpkgs";
    haumea.url = "github:nix-community/haumea";

    latest.url = "github:nixos/nixpkgs/master";

    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    #nixpkgs.url = "github:NixOS/nixpkgs/latest";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    #nixvim.url = "github:pta2002/nixvim?ref=36f2e51b28ee3389a67ed5e9ed5c4bd388b06918";
    # nixvim.inputs.nixpkgs.follows = "unstable";
    # nixvim.url = "github:pta2002/nixvim?ref=nixos-24.11";
    # nixvim.url = "github:nix-community/nixvim?ref=nixos-24.11";
    nixvim.url = "github:nix-community/nixvim?ref=main";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # nix-github-actions
    #
    # A library to turn Nix Flake attribute sets into Github Actions matrices
    #
    # GitHub: https://github.com/nix-community/nix-github-actions
    #
    # required by: poetry2nix
    nix-github-actions.url = "github:nix-community/nix-github-actions";
    nix-github-actions.inputs.nixpkgs.follows = "nixpkgs";

    nvfetcher.inputs.flake-compat.follows = "flake-compat";
    nvfetcher.inputs.flake-utils.follows = "flake-utils";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";
    nvfetcher.url = "github:berberman/nvfetcher";

    # poetry2nix
    #
    # Convert poetry projects to nix automagically
    #
    # GitHub: https://github.com/nix-community/poetry2nix
    #
    # Required by: nixvim

    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.flake-utils.follows = "flake-utils";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
    poetry2nix.inputs.systems.follows = "systems";
    poetry2nix.inputs.treefmt-nix.follows = "treefmt-nix";
    poetry2nix.inputs.nix-github-actions.follows = "nix-github-actions";

    pre-commit-hooks-nix.inputs.flake-compat.follows = "flake-compat";
    pre-commit-hooks-nix.inputs.gitignore.follows = "gitignore-nix";
    pre-commit-hooks-nix.inputs.nixpkgs-stable.follows = "nixpkgs";
    pre-commit-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";

    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";

    sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    systems.url = "github:nix-systems/default";

    # required by: flatflake, poetry2nix
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;}
    ({
      self,
      lib,
      ...
    }: let
      selfLib = import ./nix/lib {inherit inputs lib;};
    in {
      # Alternative:
      # systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      # or more "minimal"
      # systems = [ "x86_64-linux" "aarch64-linux" ];
      # But we "use them all" ;-)
      systems = lib.systems.flakeExposed;

      flake.lib = selfLib;
      imports =
        [
          inputs.devenv.flakeModule
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.flake-root.flakeModule
          inputs.flat-flake.flakeModules.flatFlake

          # Install treefmt and set outputs.formatter.<system> to to treefmt
          # Use `nix fmt` to format source tree
          inputs.treefmt-nix.flakeModule

          # Make sure that commits are well-formatted at commit time
          # TODO: Check if renamed to git-hooks:
          # <https://github.com/cachix/git-hooks.nix>
          inputs.pre-commit-hooks-nix.flakeModule
        ]
        ++ selfLib.buildModuleList ./nix/flake;
    });
}
