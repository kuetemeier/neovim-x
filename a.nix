{ config, pkgs, lib, ... }:
{
  config = {
    # One of the big advantages of NixVim is how it provides modules for
    # popular vim plugins
    # Enabling a plugin this way skips all the boring configuration that
    # some plugins tend to require.
    plugins = {
      lightline = {
        enable = true;

        # This is optional - it will default to your enabled colorscheme
        colorscheme = "wombat";

        # This is one of lightline's example configurations
        active = {
          left = [
            [ "mode" "paste" ]
            [ "redaonly" "filename" "modified" "helloworld" ]
          ];
        };

        component = {
          helloworld = "Hello, world!";
        };
      };

      # Of course, there are a lot more plugins available.
      # You can find an up-to-date list here:
      # https://nixvim.pta2002.com/plugins
    };


    globals = {
      loaded_perl_provider = 0;
    };
  };
}
