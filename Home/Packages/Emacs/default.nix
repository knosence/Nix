{
  config,
  pkgs,
  lib,
  ...
}:

let
  doomDir = "${config.home.homeDirectory}/.config/doom";
  doomEmacsDir = "${config.home.homeDirectory}/.emacs.d";
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # or pkgs.emacs-pgtk on Wayland
  };

  # Optional, but nice to have:
  programs.git.enable = true;

  home.file.".config/doom/init.el".source = ./init.el;
  home.file.".config/doom/config.el".source = ./config.el;
  home.file.".config/doom/packages.el".source = ./packages.el;

  home.packages = with pkgs; [
    git
    ripgrep
    fd
    coreutils
    clang
    cmake
    libtool
texliveFull
  ];

  home.activation.installOrSyncDoom = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    set -euo pipefail

    # Hard-pin binaries (don’t rely on PATH during activation)
    GIT=${pkgs.git}/bin/git
    EMACS=${pkgs.emacs}/bin/emacs
    DOOM_BIN="${doomEmacsDir}/bin/doom"

    # Give Doom/straight a sane PATH for its subprocesses (git, tar, sed, grep…)
    export PATH="${pkgs.git}/bin:${pkgs.ripgrep}/bin:${pkgs.fd}/bin:${pkgs.coreutils}/bin:${pkgs.findutils}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin:${pkgs.gawk}/bin:${pkgs.gnutar}/bin:${pkgs.gzip}/bin:$PATH"

    ${pkgs.coreutils}/bin/mkdir -p "${doomEmacsDir}"

    if [ ! -d "${doomEmacsDir}/.git" ]; then
      echo "[doom] Installing Doom Emacs..."
      "$GIT" clone --depth 1 https://github.com/doomemacs/doomemacs "${doomEmacsDir}"
      EMACS="$EMACS" "$DOOM_BIN" install --force
    else
      echo "[doom] Syncing Doom Emacs..."
      EMACS="$EMACS" "$DOOM_BIN" sync
    fi
  '';
}
