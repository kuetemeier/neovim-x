{ config, pkgs, inputs, ... }:
{
  imports = [
    ./a.nix
  ];
  config = {
    colorschemes.gruvbox.enable = true;

    maps.normal = {
      leader = " ";
    };

    options = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;

      mouse = "a";
    };
  };
}
