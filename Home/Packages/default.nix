{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([
    # User-specific packages
    brave
    telegram-desktop
    orca-slicer
    waveterm
    blender
  ]);


  imports = [
    ./../Packages/vm.nix
    ./../Packages/Emacs
    ./../Packages/Terminal/bat.nix
    ./../Packages/Terminal/zsh.nix
    ./../Packages/Terminal/git.nix
    ];

  programs = {
    home-manager.enable = true;
    brave.enable = true;
  };

}
