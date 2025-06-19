{  config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # General utilities
    vim
    git
    curl
    wget
    # Development tools
    gcc

    # Add more packages as needed
  ];
}