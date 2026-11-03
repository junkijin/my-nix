{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    opts = {
      termguicolors = true;
      background = "dark";
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
