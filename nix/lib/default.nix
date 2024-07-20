{
  inputs,
  lib,
}:
lib.makeExtensible (self: {
  data = lib.importJSON ../data/data.json;

  flakeStateVersion = "24.05";

  buildModuleList = import ./build-module-list.nix {inherit self lib;};
  flattenTree = import ./flatten-tree.nix {inherit lib;};
  rakeLeaves = import ./rake-leaves.nix {inherit inputs lib;};
  optionalPkg = import ./optional-pkg.nix {inherit lib;};
  requireSystemFeatures = import ./require-system-features.nix {inherit lib;};
  requireBigParallel = self.requireSystemFeatures ["big-parallel"];
  nvimMkMapCmd = import ./nvimMkMapCmd.nix {};
})
