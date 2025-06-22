{ pkgs, ... }:
{

  programs.git = {
    enable = true;
    userName = "knosence";
    userEmail = "nadario.seays@gmail.com";
    aliases = {
      st = "status";
    };
  };
}
