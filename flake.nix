{
  description = "jkr-neovim: Joerg Kuetemeier - NeoVim Configuration";

  inputs.nixvim.url = "github:pta2002/nixvim";
  inputs.flake-utils.url = "github:numtide/flake-utils";

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
      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
      packages = {
        inherit nvim;
        default = nvim;
      };
    });
}
