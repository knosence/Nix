{ pkgs, ... }:
{

  programs.git = {
    enable = true;
    userName = "knosence";
    userEmail = "nadario.seays@gmail.com";
    aliases = {
      st = "status";
      ad = "add";
      cm = "commit -m";
      co = "checkout";
      br = "branch";
      df = "diff";
      lg = "log --oneline --graph --decorate";
      pl = "pull";
      ps = "push";
      rh = "reset --hard";
      rb = "rebase";
      cp = "cherry-pick";
      mt = "merge";
      ft = "fetch";
      tb = "tag";
      cp = "clone";
      stg = "stash";
      stp = "stash pop";
      stl = "stash list";
      stc = "stash clear";
      rmt = "remote";
      rml = "remote -v";
      rmp = "remote prune";
      rmtg = "remote add";
      rmtu = "remote update";
    };
  };
}
