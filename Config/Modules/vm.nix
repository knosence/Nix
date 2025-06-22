{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  # If using QEMU/KVM:
  users.groups.libvirtd.members = [ "knosence" ]; # replace with your actual username

  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
    spice-gtk
    dnsmasq # for NAT networking
  ];
}
