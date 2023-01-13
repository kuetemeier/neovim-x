let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib; 
in
{
      # readNixFilesFromDir = dir: with builtins; with lib.attrsets; with lib.strings;
      #   map (name: substring 0 ((stringLength name) - 4) name) # remove '.nix'
      #     (attrNames # convert set to list
      #      (filterAttrs
      #       (name: _: hasSuffix ".nix" name) # filter for '.nix' in name
      #        readDir dir)); # read all files

  importNixFilesFromDir = dir: with rec {
    inherit (builtins) readDir attrNames substring stringLength listToAttrs;
    inherit (lib.attrsets) filterAttrs;
    inherit (lib.strings) hasSuffix;

    files = readDir dir;
    nixFiles = filterAttrs (name: _: hasSuffix ".nix" name) files;
    fileNames = attrNames nixFiles; 
    # remove '.nix'
    onlyNames = map (name: substring 0 ((stringLength name) - 4) name) fileNames;
    res = listToAttrs
      (map (name: { inherit name; value = import (dir + "/${name}.nix"); } ) onlyNames);

  }; res;
}
