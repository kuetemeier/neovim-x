{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.plugins.rene-calendar;

  rene-calendarPlugin = pkgs.vimUtils.buildVimPlugin rec {
    pname = "calendar-vim";
    # 2021-11-27
    version = "a7e73e02c92566bf427b2a1d6a61a8f23542cc21";
    src = pkgs.fetchFromGitHub {
      owner = "renerocksai";
      repo = "calendar-vim";
      rev = version;
      sha256 = "sha256-4XeDd+myM+wtHUsr3s1H9+GAwIjK8fAqBbFnBCeatPo=";
    };
  };
in {
  options = {
    plugins.rene-calendar = {
      enable = lib.mkEnableOption "Enable Calendar";
    };
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = [rene-calendarPlugin];

    # extraConfigLua = ''
    # '';
  };
}
