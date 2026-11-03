# Pi itself: installation, telemetry, and what it does outside the TUI.
# Model-facing settings live in agent.nix, TUI settings in ui.nix.
{
  imports = [
    ./agent.nix
    ./ui.nix
  ];

  programs.pi-coding-agent = {
    enable = true;
    settings.enableInstallTelemetry = false;
  };

  # For leaving Pi to work unattended: keep the Mac awake while the agent runs,
  # and send a terminal notification (OSC 777) when it finishes.
  home.file = {
    ".pi/agent/extensions/no-idle-sleep.ts".source = ./extensions/no-idle-sleep.ts;
    ".pi/agent/extensions/notification.ts".source = ./extensions/notification.ts;
  };
}
