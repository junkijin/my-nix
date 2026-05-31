{ pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.pi-coding-agent
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
