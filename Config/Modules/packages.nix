# System packages module for NixOS hosts
#
# Add packages to environment.systemPackages here to make them available system-wide.
#
# Usage: Imported by host configs (e.g., framework13.nix)

{ pkgs, ... }:
{
  # Define extra packages for this host
  environment.systemPackages = with pkgs; [
    # Add more packages here
  ];
}
