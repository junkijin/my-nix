{ ... }:

{
  home.file = {
    ".pi/agent/models.json".source = ./config/agent/models.json;
    ".pi/agent/keybindings.json".source = ./config/agent/keybindings.json;
    ".pi/agent/APPEND_SYSTEM.md".source = ./config/agent/APPEND_SYSTEM.md;

    ".pi/agent/extensions" = {
      source = ./config/agent/extensions;
      recursive = true;
    };

    ".pi/agent/prompts" = {
      source = ./config/agent/prompts;
      recursive = true;
    };

    ".pi/agent/skills" = {
      source = ./config/agent/skills;
      recursive = true;
    };

    ".pi/agent/themes" = {
      source = ./config/agent/themes;
      recursive = true;
    };
  };
}
