{ config, pkgs, ... }:

{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariable = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };
}
