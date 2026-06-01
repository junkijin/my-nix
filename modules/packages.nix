{ pkgs, ... }:

{
  home.packages = [
    pkgs.pi-coding-agent
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
