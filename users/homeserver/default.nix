{ config, pkgs, lib, ... }: {

  nix.settings.trusted-users = [ "homeserver" ];

  users = {
    users = {
      homeserver = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" "users" "podman" ];
        group = "homeserver";
      };
    };
    groups = {
      homeserver = {
        gid = 1000;
      };
    };
  };

  programs.zsh.enable = true;






}
