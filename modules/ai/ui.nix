# What you see and press in the TUI: theme, footer, display settings, cursor,
# and keybindings.
{
  programs.pi-coding-agent = {
    settings = {
      theme = "gruvbox-dark-medium";
      quietStartup = "header";
      collapseChangelog = true;
      showCacheMissNotices = true;
      hideThinkingBlock = true;
      showHardwareCursor = true;
    };

    keybindings = {
      "tui.select.up" = [
        "up"
        "ctrl+p"
      ];
      "tui.select.down" = [
        "down"
        "ctrl+n"
      ];
      # Both default to ctrl+p, which tui.select.up now takes.
      "app.model.cycleForward" = [
        "ctrl+alt+p"
      ];
      "app.models.toggleProvider" = [
        "ctrl+shift+p"
      ];
    };
  };

  home.file = {
    ".pi/agent/themes/gruvbox-dark-medium.json".source = ./themes/gruvbox-dark-medium.json;

    ".pi/agent/extensions/footer.ts".source = ./extensions/footer.ts;

    # Fixes for `showHardwareCursor`: hide the drawn cursor next to the terminal
    # cursor, and give the settings search input a cursor.
    ".pi/agent/extensions/no-double-cursor.ts".source = ./extensions/no-double-cursor.ts;
    ".pi/agent/extensions/settings-search-cursor.ts".source = ./extensions/settings-search-cursor.ts;
  };
}
