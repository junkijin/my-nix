{ profile, ... }:

let
  versionControlUser = profile.git;
in
{
  programs.git = {
    enable = true;

    ignores = [
      ".DS_Store"
    ];

    lfs.enable = true;

    settings = {
      user = versionControlUser;

      core = {
        pager = "delta";
      };

      init.defaultBranch = "master";
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      diff = {
        mnemonicPrefix = true;
        renames = true;
      };

      merge.conflictstyle = "zdiff3";

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      pull = {
        rebase = true;
        ff = "only";
      };

      commit.verbose = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;

    options = {
      dark = true;
      "syntax-theme" = "gruvbox-dark";
      tabs = 4;
      "hunk-header-style" = "omit";
      "file-style" = "bold #fabd2f";
      "file-added-label" = "[A]";
      "file-copied-label" = "[C]";
      "file-modified-label" = "[M]";
      "file-removed-label" = "[D]";
      "file-renamed-label" = "[R]";
      "file-decoration-style" = "dim ul overline";
      "line-numbers" = true;
      "line-numbers-left-style" = "syntax #32302f";
      "line-numbers-left-format" = " {nm:>3} ";
      "line-numbers-right-style" = "syntax #32302f";
      "line-numbers-right-format" = " {np:>3} ";
      "line-numbers-zero-style" = "#928374 #32302f";
      "line-numbers-minus-style" = "red #32302f";
      "line-numbers-plus-style" = "green #32302f";
      "zero-style" = "syntax";
      "minus-style" = "syntax #402120";
      "minus-emph-style" = "syntax #600300";
      "plus-style" = "syntax #34381b";
      "plus-emph-style" = "syntax #485300";
    };
  };

  programs.jujutsu = {
    enable = true;

    settings.user = versionControlUser;
  };
}
