{ pkgs, ... } :
{
  config = {

    plugins.lsp = {
      enable = true;

      # nil - Nix files
      # https://github.com/oxalica/nil
      servers.nil_ls.enable = true;
      servers.nil_ls.package = pkgs.unstable.nil;

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
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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
