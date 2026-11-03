# Splits, tabs, and Ghostty panes.
{
  opts.splitright = true;

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action = "<Cmd>tabn<CR>";
    }
    {
      mode = "n";
      key = "[t";
      action = "<Cmd>tabp<CR>";
    }
  ];
}
