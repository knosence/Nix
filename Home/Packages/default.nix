{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([  
    # User-specific packages
    brave
  ]);
  
  programs = {
    home-manager.enable = true;
 
  };
  

}