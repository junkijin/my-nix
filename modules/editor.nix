{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

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
