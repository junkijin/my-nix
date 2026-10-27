{ ... }:

{
  home.file.".pi/agent/extensions".source = ./dotfiles/pi-coding-agent/extensions;

  home.file.".pi/agent/themes".source = ./dotfiles/pi-coding-agent/themes;

  programs.pi-coding-agent = {
    enable = true;
    appendSystem = ./dotfiles/pi-coding-agent/APPEND_SYSTEM.md;
    settings = {
      defaultModel = "claude-opus-5-5";
      defaultProvider = "anthropic";
      defaultThinkingLevel = "medium";
      quietStartup = "header";
      enableInstallTelemetry = false;
      collapseChangelog = true;
      showCacheMissNotices = true;
      hideThinkingBlock = true;
      showHardwareCursor = true;
      theme = "gruvbox-dark-medium";
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
      "app.model.cycleForward" = [
        "ctrl+alt+p"
      ];
      "app.models.toggleProvider" = [
        "ctrl+shift+p"
      ];
    };
  };
}
