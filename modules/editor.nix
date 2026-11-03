{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    luaLoader.enable = true;

    # Must precede every `<leader>` mapping, including the ones plugins define.
    globals.mapleader = " ";

    clipboard.register = "unnamedplus";

    opts = {
      # Appearance
      termguicolors = true;
      background = "dark";
      number = true;
      signcolumn = "number";
      colorcolumn = "+0";
      scrolloff = 3;
      pumheight = 10;
      visualbell = true;

      # Statusline, tabline, title
      laststatus = 3;
      showtabline = 0;
      title = true;
      titlestring = ''%t%( %M%)%( (%{expand("%:~:.:h")})%)'';

      # Windows
      splitright = true;

      # Indentation
      tabstop = 4;
      shiftwidth = 4;

      # Search
      ignorecase = true;
      smartcase = true;
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # Folding
      foldlevel = 99;
      foldlevelstart = 99;

      # Files
      swapfile = false;
      writebackup = false;
      updatetime = 256;
    };

    colorschemes.gruvbox-material = {
      enable = true;
      settings = {
        foreground = "original";
        background = "medium";
        enable_bold = 1;
        enable_italic = 1;
      };
    };

    highlightOverride.BqfPreviewBorder.link = "Ignore";

    plugins.web-devicons.enable = true;

    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = false;
          component_separators = "";
          section_separators = "";
          always_show_tabline = false;
          globalstatus = true;
        };
        sections = {
          lualine_a = [
            {
              __unkeyed-1.__raw = ''
                function()
                  return " "
                end
              '';
              padding = {
                left = 0;
                right = 0;
              };
            }
          ];
          lualine_b = [
            {
              __unkeyed-1 = "branch";
              icon = "";
            }
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            {
              __unkeyed-1 = "diagnostics";
              symbols = {
                error = "";
                warn = "";
                info = "";
                hint = "";
              };
            }
            "encoding"
            "fileformat"
          ];
          lualine_y = [ "%l:%v" ];
          # nixvim drops empty lists, which would fall back to lualine's default ("location").
          lualine_z.__raw = "{}";
        };
        tabline = {
          lualine_a = [
            {
              __unkeyed-1 = "tabs";
              mode = 1;
            }
          ];
        };
        extensions = [
          "fzf"
          "oil"
          "quickfix"
        ];
      };
    };

    plugins.oil = {
      enable = true;
      settings.keymaps = {
        "<C-h>" = false;
        "<C-l>" = false;
        "`" = false;
        "~" = false;
      };
    };

    keymaps = [
      {
        mode = "ca";
        key = "W";
        action = "w";
      }
      {
        mode = "ca";
        key = "Q";
        action = "q";
      }
      {
        mode = "ca";
        key = "Wq";
        action = "wq";
      }
      {
        mode = "ca";
        key = "wQ";
        action = "wq";
      }
      {
        mode = "ca";
        key = "WQ";
        action = "wq";
      }
      {
        mode = "ca";
        key = "Wa";
        action = "wa";
      }
      {
        mode = "ca";
        key = "wA";
        action = "wa";
      }
      {
        mode = "ca";
        key = "WA";
        action = "wa";
      }
      {
        mode = "ca";
        key = "Qa";
        action = "qa";
      }
      {
        mode = "ca";
        key = "qA";
        action = "qa";
      }
      {
        mode = "ca";
        key = "QA";
        action = "qa";
      }
      {
        mode = "n";
        key = "]t";
        action = "<Cmd>tabn<CR>";
      }
      {
        mode = "n";
        key = "[t";
        action = "<Cmd>tabp<CR>";
      }
      {
        mode = "n";
        key = "<ESC>";
        action = "<Cmd>noh<CR>";
      }
      {
        mode = "n";
        key = "-";
        action = "<cmd>Oil<cr>";
      }
    ];

    extraPackages = [
      pkgs.fzf # fzf-lua
      pkgs.ripgrep # fzf-lua live_grep, grepprg
      pkgs.tree-sitter # nvim-treesitter :TSUpdate
      pkgs.nixd # nvim-lspconfig
      pkgs.nixfmt # conform.nvim
      pkgs.stylua # conform.nvim
    ];
  };
}
