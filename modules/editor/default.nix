# Home Manager glue for nixvim. Every file imported below is a nixvim module:
# `pkgs`, `lib`, and `config` there come from nixvim's own evaluation and
# Nixpkgs instance; nothing here uses the host `pkgs`.
{ inputs, ... }:

{
  programs.nixvim = {
    enable = true;

    # nixvim modules don't receive Home Manager's `extraSpecialArgs`.
    _module.args = { inherit inputs; };

    imports = [
      ./core.nix
      ./ui.nix
      ./editing.nix
      ./project.nix
      ./windows.nix
      ./languages.nix
    ];
  };
}
