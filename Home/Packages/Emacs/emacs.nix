{ config, pkgs, ... }:

let
  doomDir = "${config.home.homeDirectory}/.config/doom";
  doomEmacsDir = "${config.home.homeDirectory}/.emacs.d";
in {
  # Enable Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  # Your Doom config files (you can symlink your real ones here)
  home.file.".Home/Packages/Emacs/init.el".source = ./doom/init.el;
  home.file.".Home/Packages/Emacs/config.el".source = ./doom/config.el;
  home.file.".Home/Packages/Emacs/packages.el".source = ./doom/packages.el;

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
