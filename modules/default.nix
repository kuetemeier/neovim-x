{ config, pkgs }:
{
  comment = import ./comment.nix { inherit config pkgs; };
}
