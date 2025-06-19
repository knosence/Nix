{
 # Enable networking
  networking.networkmanager.enable = true;
  
  networking.hostName = ; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
