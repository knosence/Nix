{  config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # General utilities
    gnumake
    helix
    git
    curl
    wget
    # Development tools
    gcc
    

    # Add more packages as needed
  ];
}