# Things outside the current buffer: files, project-wide search, quickfix,
# and git.
{
  opts = {
    grepprg = "rg --vimgrep";
    grepformat = "%f:%l:%c:%m";
  };

  # Files
  plugins.oil = {
    enable = true;
    settings.keymaps = {
      "<C-h>" = false;
      "<C-l>" = false;
      "`" = false;
      "~" = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>Oil<cr>";
    }
  ];
}
