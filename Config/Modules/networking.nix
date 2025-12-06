{pkgs, lib, ...}:
{
 # Enable networking
  networking = {
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;

    networkmanager.wifi.backend = "wpa_supplicant";

    useDHCP = lib.mkDefault false;

    hostName = "framework13"; # Define your hostname.
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    wpa_supplicant
  ];


}
