# How the editor looks: colorscheme, statusline, indent guides, and how
# diagnostics and LSP status are displayed.
{ lib, ... }:

let
  inherit (lib.nixvim) emptyTable;
in
{
  opts = {
    termguicolors = true;
    background = "dark";
    number = true;
    signcolumn = "number";
    colorcolumn = "+0";
    pumheight = 10;

    # Statusline, tabline, title
    laststatus = 3;
    showtabline = 0;
    title = true;
    titlestring = ''%t%( %M%)%( (%{expand("%:~:.:h")})%)'';
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
        lualine_z = emptyTable;
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

  # Plain Lua scripts with no plugin dependency, sourced from runtimepath `plugin/`.
  extraFiles = {
    "plugin/indent-guides.lua".source = ./plugin/indent-guides.lua;
    "plugin/lsp-progress.lua".source = ./plugin/lsp-progress.lua;
  };

  diagnostic.settings.signs = false;

  # Neovim enables semantic tokens by default; `activate = false` turns them off.
  lsp.semanticTokens = {
    enable = true;
    activate = false;
  };
}
