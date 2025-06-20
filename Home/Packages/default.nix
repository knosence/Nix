{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([  
    # User-specific packages
    brave
    firefox
  ]);
  
  programs = {
    home-manager.enable = true;
    firefox.enable = false; 
  };

  

}