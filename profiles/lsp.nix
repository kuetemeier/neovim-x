{ pkgs, ... } :
{
  config = {

    plugins.lsp = {
      enable = true;

      # nil - Nix files
      # https://github.com/oxalica/nil
      servers.nil_ls = {
        enable = true;
        package = pkgs.unstable.nil;
        settings.formatting.command = [ "nixpkgs-fmt" ];
      };

      # bashls - Bash, Shell
      # https://github.com/bash-lsp/bash-language-server
      servers.bashls.enable = true;

      # TODO: Document, restructure and add more
      servers.elixirls.enable = true;
      servers.gopls.enable = true;
      servers.html.enable = true;
      servers.jsonls.enable = true;
      servers.sumneko-lua.enable = true;

      onAttach = ''
        vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      '';
    };

    plugins.lspkind = {
      enable = true;
      mode = "symbol_text";
      cmp.ellipsisChar = "…";
      cmp.menu = {
        buffer = "[Buffer]";
        nvim_lsp = "[LSP]";
        luasnip = "[LuaSnip]";
        nvim_lua = "[Lua]";
        latex_symbols = "[Latex]";
      };
      cmp.after = ''
        function(entry, vim_item, kind)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "   " .. strings[2]
          return kind
        end
      '';
    };

    plugins.lspsaga = {
      enable = true;
    };

  };
}
