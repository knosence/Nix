
{ config, pkgs, ... }:
{

  home.packages = with pkgs; ([
     (plasticity.overrideAttrs (oldAttrs: {
       version = "1.4.20";
       src = pkgs.fetchurl {
         url = "https://github.com/nkallen/plasticity/releases/download/v25.2.11/Plasticity-25.2.11-1.x86_64.rpm";
         hash = "sha256-6aa73a083477c81386691afe5635d0ad35d92afafd92acdaa9cbb9cb7d1c9420";
       };
     }))
  ]);

  nixpkgs.config.allowUnfree = true;

  home.file.".local/bin/plasticity-wrapper".text = ''
    #!/bin/sh
    exec ${pkgs.plasticity}/share/applications/Plasticity.desktop --use-gl=egl "$@"
  '';
  home.file.".local/bin/plasticity-wrapper".executable = true;

  xdg.desktopEntries.plasticity = {
    exec = "plasticity-wrapper %U";
    name = "Plasticity";
    type = "Application";
  };

}
