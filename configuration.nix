{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
    ./src/common
    ./src/system
    ./src/shell
    ./src/editor
    ./src/beets
    ./src/transmission
    ./src/slskd
    ./src/storage
    ./src/media-tools
  ];

  common.username = lib.mkDefault "raf";
  common.email = lib.mkDefault "rraf@tuta.io";
  common.home.stateVersion = lib.mkDefault "26.05";

  services.printing.enable = lib.mkForce false;
  services.libinput.enable = lib.mkForce false;
  services.pipewire.enable = lib.mkForce false;

  services.beets.enable = true;
  services.transmissionClient.enable = true;
  services.slskdClient.enable = true;
  services.storage.enable = true;
  services.mediaTools.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "SRVR";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    nixfmt
    btop
    hyperfine
    unixtools.netstat
  ];

  system.stateVersion = "26.05";
}
