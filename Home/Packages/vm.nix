{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    virt-manager
  ];

  # Optional: Add useful VM-related utilities
  # like qemu, spice-gtk, etc.

}
