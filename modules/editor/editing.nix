# Working with text inside a buffer: extensions to Vim's grammar (operators,
# motions, text objects), search, indentation, and completion.
{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    targets-vim
    vim-asterisk
  ];

  opts = {
    # Indentation
    tabstop = 4;
    shiftwidth = 4;

    # Search
    ignorecase = true;
    smartcase = true;

    # Completion (Neovim's default plus "fuzzy")
    completeopt = [
      "menu"
      "popup"
      "fuzzy"
    ];
  };

  plugins.sleuth.enable = true;
  plugins.nvim-autopairs.enable = true;
  plugins.nvim-surround.enable = true;
  plugins.repeat.enable = true;

  # Motion
  plugins.leap = {
    enable = true;
    luaConfig.post = ''
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
    '';
  };

  # Completion
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "default";
        "<Esc>" = [
          {
            __raw = ''
              function()
                vim.snippet.stop()
              end
            '';
          }
          "fallback"
        ];
      };
      completion = {
        accept = {
          dot_repeat = false;
          auto_brackets.enabled = false;
        };
        list.selection.auto_insert = false;
        menu.draw.components.label.text.__raw = ''
          function(ctx)
            return ctx.label
          end
        '';
      };
      sources.default = [
        "lsp"
        "snippets"
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<ESC>";
      action = "<Cmd>noh<CR>";
    }

    # Motion
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<Plug>(leap)";
    }
    {
      mode = "n";
      key = "S";
      action = "<Plug>(leap-from-window)";
    }

    # Search
    {
      mode = "n";
      key = "*";
      action = "<Plug>(asterisk-z*)";
    }
    {
      mode = "n";
      key = "#";
      action = "<Plug>(asterisk-z#)";
    }
    {
      mode = "n";
      key = "g*";
      action = "<Plug>(asterisk-gz*)";
    }
    {
      mode = "n";
      key = "g#";
      action = "<Plug>(asterisk-gz#)";
    }
  ];
}
