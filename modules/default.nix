{ config, pkgs }:
{
  comment = import ./comment.nix { inherit config pkgs; };
  keymaps = import ./keymaps.nix { inherit config pkgs; };
  options = import ./options.nix { inherit config pkgs; };
  theme = import ./theme.nix { inherit config pkgs; };
}
