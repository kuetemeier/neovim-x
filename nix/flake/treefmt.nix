{...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    # treefmt.build.check = false;
    #
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;
      # programs.nixpkgs-fmt.enable = true;
      programs.alejandra.enable = true;
      # programs.prettier.enable = true;
      programs.biome.enable = true;
      # TODO: check if needed with biome
      programs.taplo.enable = true;
      programs.beautysh = {
        enable = true;
        indent_size = 4;
      };
    };
  };
}
