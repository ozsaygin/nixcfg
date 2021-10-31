{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;

  time.timeZone = "Europe/Amsterdam";

  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    ripgrep
    alacritty
    nixfmt
    discord
    vim
    emacs
    tmux
    spotify
    git
    wget
    firefox
    vscode
    home-manager
  ];

  # users
  users.extraUsers.oguz = {
    isNormalUser = true;
    home = "/home/oguz";
    extraGroups = [ "wheel" ];
  };

  # services
  services = {

    printing = { enable = true; };

    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

  };

  # TODO: Specify development ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "21.05";

}

