{ inputs
, lib
, config
, pkgs
, ...
}:
let
  home = {
    username = "homeserver";
    homeDirectory = "/home/homeserver";
    stateVersion = "23.11";
  };
in
{
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = home;

  imports = [
    ../../dots/zsh/default.nix
    ../../dots/nvim/default.nix
    ../../dots/neofetch/default.nix
    ../../dots/tmux/default.nix
    ../../dots/kitty/default.nix
    ./gitconfig.nix
  ];

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
