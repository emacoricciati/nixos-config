{ inputs, lib, config, pkgs, ... }:
{

  programs.git = {
    enable = true;
    userName = "Emanuele Coricciati";
    userEmail = "emanuelecoricciati@libero.it";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
