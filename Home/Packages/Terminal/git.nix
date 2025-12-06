{ pkgs, ... }:
{

  programs.git = {
    enable = true;
    settings = {
      user.name = "knosence";
      user.email = "nadario.seays@gmail.com";
      alias = {
      st = "status";
    };
    };
  };
}
