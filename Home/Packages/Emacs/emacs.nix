{ pkgs, ... }:

{
  home.packages = with pkgs; [
    doom-emacs    # pulls in the “doom” CLI and its core
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;    # optional: your vanilla Emacs build
  };

  # Run `doom sync` automatically after switching
  home.activation.doom-sync = lib.hm.doomEmacsActivation {
    emacsPackage = pkgs.emacs;
    doomPackage  = pkgs.doom-emacs;
    doomDir      = config.home.homeDirectory + "/.doom.d";
  };
}