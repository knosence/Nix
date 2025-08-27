{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([
    # User-specific packages
    brave
    telegram-desktop
    orca-slicer
    waveterm
  ]);

  programs = {
    home-manager.enable = true;

  };

}
