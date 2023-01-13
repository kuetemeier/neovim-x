{ config, pkgs }:
let
  lib = pkgs.lib;
  modules = import ../modules { inherit config pkgs; };
  profileDefinitions = {
    minimal = import ./minimal.nix { inherit config pkgs modules; };
    # system = (import ./system.nix { inherit config pkgs; } );
    # jkr = (import ./jkr.nix { inherit config pkgs; } );
    # jkr-pde = (import ./jkr-pde.nix { inherit config pkgs; } );
  };

  mkProfile = (name: definition:
    let
      config' = if (builtins.hasAttr "config" definition) then definition.config else { };
      moduleConfigs = if (builtins.hasAttr "modules" definition) then definition.modules else [ ];
      mergedModuleConfigs = builtins.foldl' (a: b: lib.recursiveUpdate a b) { } moduleConfigs;
    in
    # merge all modules configurations with the profile configuration
    (lib.recursiveUpdate mergedModuleConfigs config'));
in
builtins.mapAttrs mkProfile profileDefinitions
