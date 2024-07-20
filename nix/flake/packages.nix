{
  self,
  inputs,
  fetchFromGitHub,
  ...
}: {
  perSystem = {
    system,
    inputs',
    config,
    self',
    lib,
    ...
  }: let
    nixpkgsCfg = import ./_nixpkgs.nix {
      inherit config inputs lib self fetchFromGitHub;
      getSystem = system;
    };

    pkgsX = import inputs.nixpkgs {
      inherit system;

      config = nixpkgsCfg.nixpkgs.config;
      overlays = nixpkgsCfg.nixpkgs.overlays;
    };

    nixvim' = inputs'.nixvim.legacyPackages;
    neovimSuites = self.lib.rakeLeaves ../../suites;
    neovimXPkgs =
      builtins.mapAttrs
      (name: value:
        nixvim'.makeNixvimWithModule {
          module = value;
          #TODO
          # inherit pkgs;
          pkgs = pkgsX;
        })
      neovimSuites;
  in {
    _module.args.pkgs = lib.mkForce pkgsX;

    packages = neovimXPkgs // {default = neovimXPkgs.neovim-x;};
  };
}
