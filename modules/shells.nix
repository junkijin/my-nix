{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initContent = ''
      if [[ -o interactive ]]; then
        if [[ -n "$ZSH_NO_AUTO_FISH" ]]; then
          unset ZSH_NO_AUTO_FISH
        else
          exec fish
        fi
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
