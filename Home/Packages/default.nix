{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([
    # User-specific packages
    brave
    telegram-desktop
    orca-slicer
    waveterm
    blender
    freecad
  ]);

  imports = [
    ./../Packages/vm.nix
    ./../Packages/Emacs
    ./../Packages/Terminal/bat.nix
    ./../Packages/Terminal/zsh.nix
    ./../Packages/Terminal/git.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;
    brave.enable = true;
  };

  home.file."/.config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
