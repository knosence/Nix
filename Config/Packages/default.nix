{ config, pkgs, lib, ... }:
{
   environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gnumake
    epson-escpr
    epson-escpr2
    virt-manager-qt
    virt-manager
    mesa
    glxinfo
git
 wget
    firefox
 
  ];

fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerdfonts);
}