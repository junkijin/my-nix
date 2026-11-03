# Language support: treesitter grammars, language servers, and formatters.
# Adding a language usually touches all three sections below.
{ config, lib, ... }:

let
  inherit (lib.nixvim) toLuaObject;

  oxfmtRootFiles = [
    ".oxfmtrc.json"
    ".oxfmtrc.jsonc"
    "oxfmt.config.ts"
    "oxfmt.config.mts"
  ];

  prettierRootFiles = [
    ".prettierrc"
    ".prettierrc.json"
    ".prettierrc.yml"
    ".prettierrc.yaml"
    ".prettierrc.toml"
    ".prettierrc.json5"
    ".prettierrc.js"
    ".prettierrc.ts"
    ".prettierrc.mjs"
    ".prettierrc.mts"
    ".prettierrc.cjs"
    ".prettierrc.cts"
    "prettier.config.js"
    "prettier.config.ts"
    "prettier.config.mjs"
    "prettier.config.mts"
    "prettier.config.cjs"
    "prettier.config.cts"
  ];

  jsFormatterSpec = {
    __unkeyed-1 = "oxfmt";
    __unkeyed-2 = "prettier";
    stop_after_first = true;
  };
in
{
  # Treesitter
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    folding.enable = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      bash
      css
      diff
      git_config
      git_rebase
      gitcommit
      go
      gomod
      gowork
      gotmpl
      html
      javascript
      jsdoc
      json
      lua
      luadoc
      markdown
      markdown_inline
      regex
      toml
      tsx
      typescript
      vim
      vimdoc
      yaml
      zig
    ];
  };

  # Start with every fold open.
  opts.foldlevel = 99;
  opts.foldlevelstart = 99;

  # LSP
  plugins.lspconfig.enable = true;

  # Each server installs its nixpkgs binary.
  lsp.servers = {
    nixd.enable = true;
    eslint = {
      enable = true;
      package = null;
    };
    gopls = {
      enable = true;
      package = null;
    };
    zls = {
      enable = true;
      package = null;
    };
    oxlint = {
      enable = true;
      package = null;
      # Prefer the project-local oxlint, fall back to the one on PATH.
      config.cmd.__raw = ''
        function(dispatchers, config)
          local dir = (config or {}).root_dir
          while dir do
            local bin = vim.fs.joinpath(dir, "node_modules/.bin/oxlint")
            if vim.fn.executable(bin) == 1 then
              return vim.lsp.rpc.start({ bin, "--lsp" }, dispatchers)
            end
            local parent = vim.fs.dirname(dir)
            if parent == dir then
              break
            end
            dir = parent
          end
          return vim.lsp.rpc.start({ "oxlint", "--lsp" }, dispatchers)
        end
      '';
    };
    tailwindcss = {
      enable = true;
      package = null;
      config.settings.tailwindCSS.classFunctions = [
        "cva"
        "cx"
        "cn"
      ];
    };
    vtsls = {
      enable = true;
      package = null;
      config.settings = {
        javascript.updateImportsOnFileMove.enabled = "always";
        typescript = {
          updateImportsOnFileMove.enabled = "always";
          tsserver.pluginPaths = [ "./node_modules" ];
        };
        vtsls = {
          enableMoveToFileCodeAction = true;
          autoUseWorkspaceTsdk = true;
        };
      };
    };
  };

  # Formatting
  plugins.conform-nvim = {
    enable = true;
    # Installs every formatter listed in `formatters_by_ft` from nixpkgs.
    autoInstall.enable = true;
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        javascript = jsFormatterSpec;
        javascriptreact = jsFormatterSpec;
        typescript = jsFormatterSpec;
        typescriptreact = jsFormatterSpec;
      };
      formatters = {
        oxfmt.condition.__raw = ''require("conform.util").root_file(${toLuaObject oxfmtRootFiles})'';
        prettier.condition.__raw = ''require("conform.util").root_file(${toLuaObject prettierRootFiles})'';
      };
      # Same as `require("conform").format({ bufnr = buf })` on BufWritePre.
      format_on_save.timeout_ms = 1000;
      notify_no_formatters = false;
    };
  };

  opts.formatexpr = "v:lua.require'conform'.formatexpr()";
}
