# Host configuration for framework13
#
# This file defines host-specific settings, including user accounts, hardware, and packages.
#
# Usage: Imported by flake.nix under nixosConfigurations.framework13
#
# See also: ../Modules/ for hardware, package, and (optionally) user modules

{ config, lib, pkgs, release, ... }:
let
    userName = "knosence";
    userDesc = "NaDario Seays Sr.";
    userGroups = [ "networkmanager" "wheel" "dialout" ];
  
in {
  imports =
    [ # Include the results of the hardware scan.
      ./../Modules/boot.nix
      ./../Modules/networking.nix
      ./../Modules/security.nix
      ./../Modules/services.nix
      ./../Modules/Hardware/framework13.nix
      ./../Packages
    ];
    users.users.${userName} = {
      isNormalUser = true;
      description = userDesc;
      extraGroups = userGroups;
      packages = with pkgs; [ 

      ]; # User-specific packages can go here
    };

    nixpkgs = {
    config = {
      allowUnfree = true;
    };
    };

  system.stateVersion = release; # Did you read the comment?

   nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
