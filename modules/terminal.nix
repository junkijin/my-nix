{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    enableFishIntegration = true;
    settings = {
      command = "${pkgs.fish}/bin/fish";
      font-family = [
        "JetBrainsMono Nerd Font"
        "Apple SD Gothic Neo"
      ];
      font-size = 14;
      font-thicken = true;

      adjust-cell-height = "14%";
      adjust-cell-width = "-4%";
      adjust-font-baseline = "-4%";

      theme = "Gruvbox Dark";

      window-colorspace = "display-p3";
      window-padding-balance = true;

      cursor-style = "block";
      shell-integration-features = "no-cursor";

      macos-option-as-alt = true;

      keybind = [
        "clear"

        "cmd+n=new_window"
        "cmd+q=quit"
        "cmd+c=copy_to_clipboard"
        "cmd+v=paste_from_clipboard"

        "cmd+d=new_split:right"
        "cmd+shift+d=new_split:down"

        "cmd+b=scroll_page_fractional:-0.5"
        "cmd+f=scroll_page_fractional:0.5"

        "cmd+t=new_tab"
        "cmd+shift+[=previous_tab"
        "cmd+shift+]=next_tab"
        "cmd+1=goto_tab:1"
        "cmd+2=goto_tab:2"
        "cmd+3=goto_tab:3"
        "cmd+4=goto_tab:4"
        "cmd+5=goto_tab:5"
        "cmd+6=goto_tab:6"
        "cmd+7=goto_tab:7"
        "cmd+8=goto_tab:8"
        "cmd+9=goto_tab:9"
        "cmd+0=goto_tab:0"

        # smart-splits.nvim (backend-ghostty)
        # Outside Neovim
        "performable:ctrl+h=goto_split:left"
        "performable:ctrl+j=goto_split:down"
        "performable:ctrl+k=goto_split:up"
        "performable:ctrl+l=goto_split:right"
        "performable:alt+h=resize_split:left,30"
        "performable:alt+j=resize_split:down,30"
        "performable:alt+k=resize_split:up,30"
        "performable:alt+l=resize_split:right,30"

        # Inside Neovim (key table claimed by backend-ghostty)
        "nvim/"
        "nvim/ctrl+h=text:\\x08"
        "nvim/ctrl+j=text:\\x0a"
        "nvim/ctrl+k=text:\\x0b"
        "nvim/ctrl+l=text:\\x0c"
        "nvim/alt+h=esc:h"
        "nvim/alt+j=esc:j"
        "nvim/alt+k=esc:k"
        "nvim/alt+l=esc:l"
      ];
    };
  };
}
