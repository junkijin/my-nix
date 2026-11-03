{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

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

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

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
