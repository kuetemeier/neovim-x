#  ChatGPT.nix - Neovim configuration
#
#  > ChatGPT Neovim Plugin: Effortless Natural Language Generation with OpenAI's ChatGPT API
#  https://github.com/jackMort/ChatGPT.nvim
#
#       //_/  Jörg Kütemeier <https://kuetemeier.de>
#    ._// )   (c) Copyright 2023 - License: MPL-2.0
#
#
# {{{ MPL-2.0
#
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# }}}
{pkgs, ...}: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      ChatGPT-nvim
      nui-nvim
      plenary-nvim
      telescope-nvim
    ];
    extraConfigLua = ''
      local chatGPTIsInitialized = false
      local home = vim.fn.expand("$HOME")
      local chatGPTConfig = { }
      local chatGPTKeyFileExists = vim.fn.filereadable(home .. "/.keys/oai") == 1
      local chatGPTGPGKeyFileExists = vim.fn.filereadable(home .. "/.keys/oai.gpg") == 1

      function initChatGPT()
        -- Place OpenAI_API_KEY in Environment Variable or in a key file
        if os.getenv("OPENAI_API_KEY") or chatGPTKeyFileExists or chatGPTGPGKeyFileExists then

          -- OpenAI_API_KEY in clear text
          if chatGPTKeyFileExists then
            chatGPTConfig.api_key_cmd = "cat " .. home .. "/.keys/oai"
          end

          -- OpenAI_API_KEY encrypted with GPG
          if chatGPTGPGKeyFileExists then
            chatGPTConfig.api_key_cmd = "gpg --decrypt " .. home .. "/.keys/oai.gpg"
          end

          require("chatgpt").setup(chatGPTConfig)

          chatGPTIsInitialized = true
        else
          print "ERROR: No ChatGPT Key-File found! Place API key in ~/.keys/oai oder ~/.keys/oai.gpg"
        end
      end

      function jkrChatGPTEditWithInstructions()
        if chatGPTIsInitialized then
          vim.cmd "ChatGPTEditWithInstructions"
        else
          initChatGPT()
          vim.cmd "ChatGPTEditWithInstructions"
        end
      end


      function jkrChatGPT()
        if chatGPTIsInitialized then
          vim.cmd "ChatGPT"
        else
          initChatGPT()
          vim.cmd "ChatGPT"
        end
      end
    '';

    keymaps = [
      {
        key = "<leader>ke";
        mode = "";
        action = "<cmd>lua jkrChatGPTEditWithInstructions()<CR>";
        options.desc = "ChatGPT: Edit selection of file with instructions in ChatGPT";
        options.silent = true;
      }
      {
        key = "<leader>kc";
        mode = "";
        action = "<cmd>lua jkrChatGPT()<CR>";
        options.desc = "ChatGPT: Toggle ChatGPT Window";
        options.silent = true;
      }
    ];
  };
}
