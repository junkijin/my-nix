# Things outside the current buffer: files, project-wide search, quickfix,
# and git.
{
  # fugitive reads this while its own `plugin/` scripts are sourced.
  globals.fugitive_legacy_commands = 0;

  opts = {
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";
  };

  # Files
  plugins.oil = {
    enable = true;
    settings.keymaps = {
      "<C-h>" = false;
      "<C-l>" = false;
      "`" = false;
      "~" = false;
    };
  };

  # Picker
  plugins.fzf-lua = {
    enable = true;
    keymaps = {
      "<leader>f" = "files";
      "<leader>g" = "live_grep";
    };
    settings = {
      winopts = {
        border = "thicc";
        backdrop = 100;
        preview.hidden = "hidden";
      };
      grep.winopts.preview = {
        layout = "vertical";
        hidden = false;
        vertical = "down:70%";
      };
      keymap.fzf = {
        __unkeyed-1 = false;
        "ctrl-q" = "select-all+accept";
        "ctrl-w" = "accept";
      };
    };
  };

  # fzf-lua pulls in fzf itself; ripgrep backs live_grep and grepprg.
  dependencies.ripgrep.enable = true;

  # Quickfix
  plugins.nvim-bqf.enable = true;

  # Git
  plugins.fugitive.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>Oil<cr>";
    }
  ];
}
