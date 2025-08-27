{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([
    # User-specific packages
    brave
    telegram-desktop
<<<<<<< HEAD
    orca-slicer
    waveterm
=======
>>>>>>> 130a998 (fixes error with emacs config files)
  ]);

  programs = {
    home-manager.enable = true;

  };

}
