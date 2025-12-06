{ config, pkgs, lib, ... }:
{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # General utilities
    epson-escpr
    epson-escpr2

    # CLI applications
    git
    gnumake
    mesa
    mesa-demos
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
    onlyoffice-desktopeditors
    firefox
    vlc
    thunderbird
    kdePackages.gwenview
    kdePackages.kdenlive
    kdePackages.okular
    kdePackages.kcalc
    kdePackages.spectacle
    waveterm
    gimp
    inkscape
    emacs

  ];

fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
