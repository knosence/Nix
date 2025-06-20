{ config, pkgs, lib, ... }:
{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General utilities
    epson-escpr
    epson-escpr2

    # CLI applications
    git
    gnumake
    mesa
    glxinfo
    curl
    wget

    # Development tools
    helix
    gcc

    # GUI applications
    libreoffice
    firefox
    vlc
    thunderbird
    kdenlive
    gwenview
    okular
    kcalc
    spectacle
  ];

  programs.firefox.enable = true;

fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerdfonts);
}