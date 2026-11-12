# Pi coding agent: installation, the model and what it receives, and the TUI.
{
  programs.pi-coding-agent = {
    enable = true;

    settings = {
      # Pi itself
      enableInstallTelemetry = false;

      # Model
      defaultProvider = "anthropic";
      defaultModel = "claude-fable-5-2";
      defaultThinkingLevel = "high";
      enabledModels = [
        "anthropic/claude-fable-5-2:high"
        "anthropic/claude-opus-5-5:medium"
        "xai/grok-4.7:high"
      ];

      # TUI
      theme = "gruvbox-dark-medium";
      quietStartup = "header";
      collapseChangelog = true;
      showCacheMissNotices = true;
      hideThinkingBlock = true;
      showHardwareCursor = true;

      themes = [ ./themes/gruvbox-dark-medium.json ];

      extensions = [
        # For leaving Pi to work unattended: keep the Mac awake while the agent
        # runs, and send a terminal notification (OSC 777) when it finishes.
        ./extensions/no-idle-sleep.ts
        ./extensions/notification.ts

        # Instructions: the system prompt's environment section (OS and shells).
        ./extensions/whereami.ts

        # Tools: web_search and web_fetch (Exa), and view_image.
        ./extensions/exa.ts
        ./extensions/view-image.ts

        # TUI: the footer.
        ./extensions/footer.ts

        # Fixes for `showHardwareCursor`: hide the drawn cursor next to the
        # terminal cursor, and give the settings search input a cursor.
        ./extensions/no-double-cursor.ts
        ./extensions/settings-search-cursor.ts
      ];
    };

    # Instructions appended to the system prompt.
    appendSystem = ./APPEND_SYSTEM.md;

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
}
