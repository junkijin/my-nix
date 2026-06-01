{ pkgs, profile, ... }:

{
  home.username = profile.username;
  home.homeDirectory = profile.homeDirectory;

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.man = {
    enable = true;
    package = pkgs.man;
  };
}
