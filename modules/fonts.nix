{ pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
