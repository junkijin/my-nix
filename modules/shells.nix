{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initContent = ''
      # Only auto-switch the initial login zsh to fish.
      # This keeps an explicitly started interactive `zsh` as zsh.
      if [[ -o interactive && -o login ]]; then
        exec fish
      fi
    '';
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      set -g fish_key_bindings fish_default_key_bindings
    '';

    interactiveShellInit = ''
      set fish_greeting
    '';

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };
}
