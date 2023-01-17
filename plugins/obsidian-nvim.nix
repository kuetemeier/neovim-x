{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.plugins.obsidian;
in
{
  options = with lib; {
    plugins.obsidian = {
      enable = mkEnableOption "Enable obsidian";
    };
  };

  config =
    let
      # jkr-helpers = import ../jkr-helpers.nix { inherit pkgs lib; };
      # pluginGitHub = jkr-helpers.pluginGitHub; 

  pluginGitHub =
    { repo
    , owner ? repo
    , rev
    , sha256
    , version ? rev
    , ...
    }: pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = version;
      src = pkgs.fetchFromGitHub {
        inherit owner repo rev sha256;
      };
    };


    obsidian-nvimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "obsidian-nvim";
    # version = "9359f7ab453976ac4f5ab3c9b8bc30fc0b3c5e1c";
    version = "a0eab5dbf54d33dd79c87ae3d026b50c71ae55f9";
    src = pkgs.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = version;
      # sha256 = "sha256-EtTvS00cXTlnbND6v5mwjpqQUXPLho+SZElafYSqWdM=";
      sha256 = "sha256-GiZHHVzmcm6ktc/IuyJ0+FSBg0QXb0orKYWvkfsv3as=";
    };
  };

    in
    lib.mkIf cfg.enable {
      #extraPlugins = [ obsidian-nvimPlugin ];

      plugins.nvim-cmp.enable = true; # required by obsidian-nvim
      plugins.packer.enable = true;
      plugins.packer.plugins = [
      {
        name = "epwalsh/obsidian.nvim";
        tag = "v1.6.1";
      }
      ];

      #extraPackages = [ pkgs.stylua ];

      extraConfigLua = ''
        require("obsidian").setup({
          dir = "~/my-vault",
          completion = {
            nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
          }
        })
      '';
    };
}
