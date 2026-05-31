{ ... }:

{
  imports = [
    ./modules/base.nix
    ./modules/packages.nix
    ./modules/version-control.nix
    ./modules/shells.nix
    ./modules/programs/kitty
    ./modules/programs/tmux
    ./modules/programs/nvim
    ./modules/programs/pi
  ];
}
