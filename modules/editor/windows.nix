# Splits, tabs, and Ghostty panes.
{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins.extend (
        vfinal: vprev: {
          # nixvim's Nixpkgs still ships smart-splits 2.1.0-unstable, which predates
          # the backend protocol (3.x) backend-ghostty needs. Drop this override
          # (and the flake input) once it ships 3.x.
          smart-splits-nvim = vprev.smart-splits-nvim.overrideAttrs (
            old:
            let
              version = "0-unstable-${inputs.smart-splits.shortRev}";
            in
            {
              inherit version;
              # buildVimPlugin bakes `version` into `name`, so update both.
              name = "vimplugin-${old.pname}-${version}";
              src = inputs.smart-splits;
            }
          );

          # Not packaged in nixpkgs.
          smart-splits-backend-ghostty = final.vimUtils.buildVimPlugin {
            pname = "smart-splits-backend-ghostty";
            version = "0-unstable-${inputs.smart-splits-backend-ghostty.shortRev}";
            src = inputs.smart-splits-backend-ghostty;
            dependencies = [ vfinal.smart-splits-nvim ];
          };
        }
      );
    })
  ];

  # `pkgs` is nixvim's Nixpkgs, with the overlay above applied.
  extraPlugins = [ pkgs.vimPlugins.smart-splits-backend-ghostty ];

  opts.splitright = true;

  plugins.smart-splits = {
    enable = true;
    settings = {
      mux.backend = "smart-splits-backend-ghostty";
      move.at_edge = "stop";
    };
    # The backend must be configured before smart-splits resolves it.
    luaConfig.pre = ''
      require("smart-splits-backend-ghostty").setup({})
    '';
  };

  keymaps = [
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
  ]
  ++
    lib.mapAttrsToList
      (key: fn: {
        mode = "n";
        inherit key;
        action.__raw = "require('smart-splits').${fn}";
      })
      {
        "<A-h>" = "resize_left";
        "<A-j>" = "resize_down";
        "<A-k>" = "resize_up";
        "<A-l>" = "resize_right";
        "<C-h>" = "move_cursor_left";
        "<C-j>" = "move_cursor_down";
        "<C-k>" = "move_cursor_up";
        "<C-l>" = "move_cursor_right";
        "<leader><leader>h" = "swap_buf_left";
        "<leader><leader>j" = "swap_buf_down";
        "<leader><leader>k" = "swap_buf_up";
        "<leader><leader>l" = "swap_buf_right";
      };
}
