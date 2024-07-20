{...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    # Whether to add a derivation to the flake checks.
    # It will perform the pre-commit checks in nix flake check.
    pre-commit.check.enable = true;

    pre-commit.settings.hooks = {
      # lint shell scripts
      shellcheck.enable = true;

      treefmt.enable = true;
    };
  };
}
