{ pkgs, ... }:

{
  home.username = "junkijin";
  home.homeDirectory = "/Users/junkijin";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.man = {
    enable = true;
    package = pkgs.man;
  };
}
