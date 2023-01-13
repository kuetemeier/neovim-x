{ config, pkgs, lib, inputs } : 
{
  # imports = [
  #   ../profiles/base.nix
  # ];
  config = {
    extraConfigLua = ''
      print ("Hello from jkr-test")
    '';
  };
}
