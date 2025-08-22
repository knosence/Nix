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
    neofetch
    btop
    bat
    ripgrep
    fd
    tree
    fzf
    wl-clipboard
    xclip



    # Development tools
    helix
    gcc

    # GUI applications
    onlyoffice-bin_latest
    firefox
    vlc
    thunderbird
    kdenlive
    gwenview
    okular
    kcalc
    spectacle
    waveterm
    gimp
    inkscape
    emacs

  ];

fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerdfonts);
}
