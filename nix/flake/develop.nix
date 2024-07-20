{...}: {
  perSystem = {
    inputs',
    pkgs,
    config,
    self',
    lib,
    ...
  }: {
    # Run: nix develop
    devShells.default = pkgs.mkShell {
      packages = [
        pkgs.just
        config.packages.default
        config.treefmt.build.wrapper
      ];
      # Provides $FLAKE_ROOT in dev shell
      inputsFrom = [
        config.flake-root.devShell
        config.pre-commit.devShell
      ];
      shellHook = ''
        alias j=just
        echo $'\e[1;32mWelcom to development Shell~\e[0m'
        echo 'Hint: just use "just"'
        echo
        just
      '';
    };
  };
}
