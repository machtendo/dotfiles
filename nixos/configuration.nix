# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      
      # Hardware Configuration Files
      ./hardware-configuration.nix
      
      # Server Configuration Files
      #./servers/forge.nix

      # Endpont Configuration Files
      ./devices/endpoints/dell.nix
      #./devices/endpoints/lenovo-legion-9i.nix
    ];

# Boot - Splash Screen

  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

# System Settings  
  
  # Linux Kernel - Latest
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Declared System Version

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  # Optimization & Garbage Collection

  # Optimize Nix-Store During Rebuilds
    # NOTE: Optimizes during builds - results in slower builds
  nix.settings.auto-optimise-store = true;
  
  # Purge Unused Nix-Store Entries
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

# Networking

  # Enable Networking
  networking.networkmanager.enable = true;

# Localization Settings

  # Set Time Zone
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 Keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Packages

  # Packages - System Profile
  environment.systemPackages = with pkgs; [
   btop               # CLI System Process Monitor
   curl               # CLI File Transfer
   fastfetch          # CLI System Information
   git                # CLI Version Control
   neovim             # CLI Text Editor
   openssl            # SSL & TLS Encryption
   wget               # CLI File Transfer
  ];

# Applications & Modules

  # SUID Wrappers
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

# Services
    
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable Syncthing
  services.syncthing.enable = true;

# End
}
