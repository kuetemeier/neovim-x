{ config, pkgs, modules }:
{
  modules = with modules; [ theme options keymaps comment ];

  config = {
  };
}
