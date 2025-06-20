{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([  
    # User-specific packages

  ]);
  
  programs = {
    home-manager.enable = true;
  };
}