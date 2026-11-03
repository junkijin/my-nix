# What the model receives: which model runs, the instructions in its system
# prompt, and the tools it can call.
{
  programs.pi-coding-agent = {
    settings = {
      defaultProvider = "anthropic";
      defaultModel = "claude-opus-5-5";
      defaultThinkingLevel = "medium";
    };

    appendSystem = ./APPEND_SYSTEM.md;
  };

  home.file = {
    # Instructions: the system prompt's environment section (OS and shells).
    ".pi/agent/extensions/whereami.ts".source = ./extensions/whereami.ts;

    # Tools: web_search and web_fetch (Exa), and view_image.
    ".pi/agent/extensions/exa.ts".source = ./extensions/exa.ts;
    ".pi/agent/extensions/view-image.ts".source = ./extensions/view-image.ts;
  };
}
