{ inputs, config, pkgs, lib, ... }:
{
  # load module config to top-level configuration

  system.stateVersion = "22.11";

  #garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  #auto update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
    ];
    dates = "06:00";
    randomizedDelaySec = "45min";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  users.users = {
    root = {
      #initialHashedPassword = config.age.secrets.hashedUserPassword.path;
      #openssh.authorizedKeys.keys = [ "sshKey_placeholder" ];
    };
  };

  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      LoginGraceTime = 0;
      PermitRootLogin = "no";
    };
    ports = [ 69 ];
    #  hostKeys = [
    #   {
    #     path = "/persist/ssh/ssh_host_ed25519_key";
    #    type = "ed25519";
    # }
    # {
    #   path = "/persist/ssh/ssh_host_rsa_key";
    #  type = "rsa";
    #  bits = 4096;
    #}
    #];
  };

  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

  programs.git.enable = true;
  programs.mosh.enable = true;
  programs.htop.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  security = {
    doas.enable = lib.mkDefault false;
    sudo = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault false;
    };
  };
  environment.systemPackages = with pkgs; [
    wget
    iperf3
    eza
    neofetch
    (python310.withPackages (ps: with ps; [ pip ]))
    tmux
    rsync
    iotop
    ncdu
    nmap
    jq
    ripgrep
    sqlite
    inputs.agenix.packages."${system}".default
    lm_sensors
    jc
    moreutils
    lsof
    fatrace
    git-crypt
    bfg-repo-cleaner
  ];

}
