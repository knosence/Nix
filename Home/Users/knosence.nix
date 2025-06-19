{config, lib, pkgs, ...}:
let 
  userName = "knosence";
  userDirectory = "/home/${userName}";

in{
  import = [
    ./../Packages 
    ./../Packages/doom-emacs.nix
    
    #./../Modules/
  ];

  home = {
    username = userName;
    homeDirectory = userDirectory;
    stateVersion = "24.11";
  };
}