# Working with text inside a buffer: extensions to Vim's grammar (operators,
# motions, text objects), search, indentation, and completion.
{
  opts = {
    # Indentation
    tabstop = 4;
    shiftwidth = 4;

    # Search
    ignorecase = true;
    smartcase = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<ESC>";
      action = "<Cmd>noh<CR>";
    }
  ];
}
