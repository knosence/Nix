{ config, pkgs, lib, ... }:

let
  doomDir = "${config.home.homeDirectory}/.config/doom";
  doomEmacsDir = "${config.home.homeDirectory}/.emacs.d";
in {
  # Enable Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # Your Doom config files (you can symlink your real ones here)
  home.file.".config/doom/init.el".source = ./init.el;
  home.file.".config/doom/config.el".source = ./config.el;
  home.file.".config/doom/packages.el".source = ./packages.el;

  # Add supporting packages
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    coreutils
    clang
  ];

  # Define what runs *after* Home Manager switch
  home.activation.installOrSyncDoom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${doomEmacsDir}" ]; then
      echo "[doom] Installing Doom Emacs..."
      git clone --depth 1 https://github.com/doomemacs/doomemacs ${doomEmacsDir}
      ${doomEmacsDir}/bin/doom install --force
    else
      echo "[doom] Syncing Doom Emacs..."
      ${doomEmacsDir}/bin/doom sync
    fi
  '';
}
