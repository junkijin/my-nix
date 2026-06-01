{ config, lib, pkgs, ... }:

let
  indentminiNvim = pkgs.vimUtils.buildVimPlugin {
    pname = "indentmini.nvim";
    version = "2025-05-30";
    src = pkgs.fetchFromGitHub {
      owner = "nvimdev";
      repo = "indentmini.nvim";
      rev = "38572ce5a7a064a5deb89d6d861b7c40fc929ab1";
      hash = "sha256-XcoBNrvFMmEMcgrknDg/HnxRNssom6vLeOKiu1qJKBo=";
    };
  };

  nvimTreesitterWithParsers = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    parsers:
    with parsers; [
      bash
      comment
      css
      diff
      dtd
      editorconfig
      fish
      git_config
      git_rebase
      gitattributes
      gitcommit
      gitignore
      graphql
      go
      gomod
      gosum
      html
      javascript
      jsdoc
      json
      latex
      lua
      markdown
      markdown_inline
      ruby
      scss
      styled
      toml
      tsx
      typescript
      typst
      vim
      vimdoc
      xml
      yaml
      zig
    ]
  );

in
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-material
      vim-repeat
      targets-vim
      vim-asterisk
      leap-nvim
      nvim-web-devicons
      lualine-nvim
      fzf-lua
      oil-nvim
      nvimTreesitterWithParsers
      nvim-treesitter-endwise
      nvim-ts-autotag
      blink-cmp
      nvim-lspconfig
      conform-nvim
      guess-indent-nvim
      indentminiNvim
      nvim-autopairs
      nvim-surround
      nvim-bqf
      persistence-nvim
      smart-splits-nvim
      vim-fugitive
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      stylua
      prettier
      oxfmt
      deno
      gopls
      zls
      ruby-lsp
      vtsls
      tailwindcss-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./config/init.lua;
    "nvim/plugin" = {
      source = ./config/plugin;
      recursive = true;
    };
    "nvim/after" = {
      source = ./config/after;
      recursive = true;
    };
    "nvim/lsp" = {
      source = ./config/lsp;
      recursive = true;
    };
  };

  home.activation.removeLegacyNvimPackLock = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    target="${config.xdg.configHome}/nvim/nvim-pack-lock.json"

    if [ -e "$target" ] || [ -L "$target" ]; then
      $DRY_RUN_CMD rm -f "$target"
    fi
  '';
}
