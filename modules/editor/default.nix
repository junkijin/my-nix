# Home Manager glue for nixvim. Every file imported below is a nixvim module:
# `pkgs`, `lib`, and `config` there come from nixvim's own evaluation and
# Nixpkgs instance; nothing here uses the host `pkgs`.
{
  programs.nixvim = {
    enable = true;

    imports = [
      ./core.nix
      ./ui.nix
      ./editing.nix
      ./project.nix
      ./windows.nix
    ];
  };
}
