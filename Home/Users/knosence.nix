# Home Manager configuration for user knosence
# This file sets up the user's home environment and imports package modules.
#
# To add more user-specific modules, import them in the list below.
#
# Usage: Managed by flake.nix under homeConfigurations.knosence
#
# See also: ../Packages/ for package definitions
#           ../Modules/ for reusable user modules (if any)

{config, lib, pkgs, ...}:
let 
  userName = "knosence";
  userDirectory = "/home/${userName}";

in{
  import = [
    ./../Packages 
    #./../Packages/doom-emacs.nix
    
    #./../Modules/
  ];

  home = {
    username = userName;
    homeDirectory = userDirectory;
    stateVersion = "24.11";
  };
}