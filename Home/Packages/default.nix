{ config, pkgs, ... }:
{
  imports = [

  ];


  home.packages = with pkgs; ([  

  ]);
  
  programs = {
    home-manager.enable = true;
  };
}