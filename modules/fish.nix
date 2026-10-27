{ pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting
      set -U fish_key_bindings fish_default_key_bindings

      if not set -q tide_left_prompt_items
        tide configure --auto \
           --style=Lean \
           --prompt_colors='16 colors' \
           --show_time=No \
           --lean_prompt_height='Two lines' \
           --prompt_connection=Disconnected \
           --prompt_spacing=Sparse \
           --icons='Few icons' \
           --transient=Yes
      end
    '';

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };
}
