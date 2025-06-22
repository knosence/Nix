# Home Manager configuration for user knosence
# This file sets up the user's home environment and imports package modules.
#
# To add more user-specific modules, import them in the list below.
#
# Usage: Managed by flake.nix under homeConfigurations.knosence
#
# See also: ../Packages/ for package definitions
#           ../Modules/ for reusable user modules (if any)

{config, lib, pkgs, release, ...}:
let 
  userName = "knosence";
  userDirectory = "/home/${userName}";

in{

  imports = [
    ./../Packages 
    ./../Packages/vm.nix
    ./../Packages/Emacs
    
    #./../Modules/
  ];

  home = {
    username = userName;
    homeDirectory = userDirectory;
    stateVersion = release;
  };
}