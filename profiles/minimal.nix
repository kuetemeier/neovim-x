{ config, pkgs, modules, ... }:
{
  config = {
    d = "Hallo Welt Profile Override";
  };
  modules = with modules; [ comment ];
}
