# Neovim itself: settings that don't belong to any one feature.
{ lib, ... }:

{
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  luaLoader.enable = true;

  performance.byteCompileLua = {
    enable = true;
    plugins = true;
  };

  # Must precede every `<leader>` mapping, including the ones plugins define.
  globals.mapleader = " ";

  clipboard.register = "unnamedplus";

  opts = {
    scrolloff = 3;
    visualbell = true;

    # Files
    swapfile = false;
    writebackup = false;
    updatetime = 256;
  };

  # Plain Lua script with no plugin dependency, sourced from runtimepath `plugin/`.
  extraFiles."plugin/restore-cursor.lua".source = ./plugin/restore-cursor.lua;

  # Capitalized :w/:q variants.
  keymaps =
    map
      (key: {
        mode = "ca";
        inherit key;
        action = lib.toLower key;
      })
      [
        "W"
        "Q"
        "Wq"
        "wQ"
        "WQ"
        "Wa"
        "wA"
        "WA"
        "Qa"
        "qA"
        "QA"
      ];
}
