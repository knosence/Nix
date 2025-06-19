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
    make
    python3
    # Add more packages as needed
  ];
}