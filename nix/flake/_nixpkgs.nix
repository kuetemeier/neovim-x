{
  inputs,
  getSystem,
  ...
}: let
  # Our Nixpkgs configuration
  config = {
    allowUnfree = true;
    allowInsecure = true;
  };

  packages = [
    inputs.flat-flake.overlays.default

    (final: prev: let
      inherit (prev.stdenv.hostPlatform) system;
      inherit ((getSystem system).allModuleArgs) inputs';

      latest = import inputs.latest {
        inherit system config;
      };

      unstable = import inputs.unstable {
        inherit system config;
      };
    in {
      nixVersions =
        prev.nixVersions.extend
        (final': prev': {
          master = inputs'.nix.packages.nix;
          selected = final'.stable;
        });

      inherit latest unstable;
    })
  ];
in {
  nixpkgs = {
    inherit config;
    overlays = [] ++ packages;
  };
}
