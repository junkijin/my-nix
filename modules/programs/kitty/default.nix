{ pkgs, ... }:

let
  kittyTmux = pkgs.writeShellScript "kitty-tmux" ''
    if [ -n "$TMUX" ]; then
      exec "$SHELL" -l
    fi

    exec ${pkgs.tmux}/bin/tmux new-session -A -s main
  '';

  kittyTmuxNewSession = pkgs.writeShellScript "kitty-tmux-new-session" ''
    unset TMUX TMUX_PANE
    exec ${pkgs.tmux}/bin/tmux new-session
  '';

  tmuxSessionPicker = pkgs.writeTextFile {
    name = "tmux-session-picker.zsh";
    executable = true;
    text = ''
      #!${pkgs.zsh}/bin/zsh
      set -euo pipefail

      TMUX_BIN="${pkgs.tmux}/bin/tmux"
      FZF_BIN="${pkgs.fzf}/bin/fzf"
      TAIL_BIN="${pkgs.coreutils}/bin/tail"

      if [[ ! -x "$TMUX_BIN" ]]; then
        print -u2 "tmux not found: $TMUX_BIN"
        exit 1
      fi

      if [[ ! -x "$FZF_BIN" ]]; then
        print -u2 "fzf not found: $FZF_BIN"
        exit 1
      fi

      sessions="$($TMUX_BIN list-sessions -F '#{session_name}' 2>/dev/null || true)"

      if [[ -z "$sessions" ]]; then
        print -u2 "No tmux sessions found."
        exit 0
      fi

      selected="$(printf '%s\n' "$sessions" | "$FZF_BIN" \
        --ansi \
        --prompt='tmux session> ' \
        --preview="$TMUX_BIN list-windows -t {} -F '#{window_index}:#{window_name}#{?window_active,*, } #{window_panes} panes'; echo; $TMUX_BIN capture-pane -p -e -t {} -S -2000 -E - | $TAIL_BIN -n 40" \
        --preview-window='right:70%:wrap')"

      if [[ -z "$selected" ]]; then
        exit 0
      fi

      exec "$TMUX_BIN" attach-session -t "$selected"
    '';
  };
in
{
  programs.kitty = {
    enable = true;
    package = null;

    font = {
      name = "family='JetBrainsMono Nerd Font Mono' style=Regular";
      size = 14.0;
    };

    shellIntegration.mode = null;

    settings = {
      shell = "${kittyTmux}";

      allow_cloning = "no";
      remember_window_size = "no";
      initial_window_width = "120c";
      initial_window_height = "30c";
      placement_strategy = "center";
      window_padding_width = 1;
      resize_in_steps = "yes";
      disable_ligatures = "always";
      clear_all_shortcuts = "yes";

      macos_titlebar_color = "dark";
      macos_option_as_alt = "both";
      macos_colorspace = "displayp3";

      bold_font = "family='JetBrainsMono Nerd Font Mono' style=Bold";
      italic_font = "family='JetBrainsMono Nerd Font Mono' style='Italic'";
      bold_italic_font = "family='JetBrainsMono Nerd Font Mono' style='Bold Italic'";
      symbol_map = "U+E000-U+F8FF,U+F0000-U+FFFFF,U+100000-U+10ffff JetBrainsMonoNL Nerd Font";

      scrollback_lines = 10000;
      scrollbar = "never";
      tab_bar_style = "hidden";

      selection_foreground = "#ebdbb2";
      selection_background = "#d65d0e";
      background = "#282828";
      foreground = "#ebdbb2";
      color0 = "#3c3836";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#d79921";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#689d6a";
      color7 = "#a89984";
      color8 = "#928374";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#fbf1c7";
      cursor = "#bdae93";
      cursor_text_color = "#665c54";
      url_color = "#458588";
      active_tab_foreground = "#eeeeee";
      active_tab_background = "#d65d0e";
      inactive_tab_foreground = "#ebdbb2";
      inactive_tab_background = "#202020";
    };

    keybindings = {
      "cmd+q" = "quit";
      "cmd+c" = "copy_or_noop";
      "cmd+v" = "paste_from_clipboard";
      "cmd+n" = "launch --type=os-window --cwd=current ${kittyTmuxNewSession}";
      "shift+enter" = "send_text all \\x1b[13;2u";
      "cmd+'" = "send_text all \\x11w";
      "cmd+o" = "send_text all \\x11[";
      "cmd+t" = "send_text all \\x11c";
      "cmd+d" = "send_text all \\x11%";
      "shift+cmd+d" = "send_text all \\x11\"";
      "cmd+w" = "send_text all \\x11x";
      "shift+cmd+w" = "send_text all \\x11&";
      "cmd+1" = "send_text all \\x111";
      "cmd+2" = "send_text all \\x112";
      "cmd+3" = "send_text all \\x113";
      "cmd+4" = "send_text all \\x114";
      "cmd+5" = "send_text all \\x115";
      "cmd+6" = "send_text all \\x116";
      "cmd+7" = "send_text all \\x117";
      "cmd+8" = "send_text all \\x118";
      "cmd+9" = "send_text all \\x119";
      "shift+cmd+[" = "send_text all \\x11p";
      "alt+cmd+[" = "send_text all \\x11P";
      "shift+cmd+]" = "send_text all \\x11n";
      "alt+cmd+]" = "send_text all \\x11N";
    };

    extraConfig = ''
      modify_font cell_height 114%
      modify_font cell_width 94%
      modify_font baseline 95%
    '';
  };

  xdg.configFile = {
    "kitty/tmux-session-picker.zsh" = {
      source = tmuxSessionPicker;
    };
  };
}
