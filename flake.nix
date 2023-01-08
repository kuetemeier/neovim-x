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
    in
    flake-utils.lib.eachDefaultSystem (system:
    let
      nixvim' = nixvim.legacyPackages."${system}";
      nvim = nixvim'.makeNixvim config;
    in
    {
      packages = {
        inherit nvim;
        default = nvim;
      };

      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    });
}
