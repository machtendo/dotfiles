# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# System Settings  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Enable 32-Bit Support
  hardware.graphics.enable32Bit = true;

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Touchpad Support
  services.xserver.libinput.enable = true;

  # Declared System Version

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

# Networking

  # Enable Networking
  networking.networkmanager.enable = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Firewall
    # Firewall Status
    # networking.firewall.enable = false;
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];

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

# Desktop Environment

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Printing (CUPS)
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Enable JACK Applications
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

# Users

  # Define User Account
  users.users.jas = {
    isNormalUser = true;
    description = "Jason";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vlc                 # GUI Video Player
      brave               # GUI Web Browser
      parsec-bin          # GUI Low-latency Remote Access Client
      lutris              # Video Game Platform
      chiaki              # GUI PS Remote Play Client
      godot_4             # GUI 2D/3D Game Engine
      vscode              # GUI Visual Studio Code, IDE
      vscodium            # GUI Visual Studio Code, IDE, sans Microsoft
      qbittorrent         # GUI Torrent Client
      gimp                # GNU Image Manipulation Program
      obsidian            # GUI Note Taking, Knowledge Base Application
      libreoffice         # GUI Productivity Suite
      betterdiscordctl    # GUI Discord Client
      github-desktop      # GUI GitHub Client
      proton-pass         # GUI Proton Pass Desktop
      protonvpn-gui       # GUI Proton VPN
      stow                # CLI Dotfiles Manager
      protonup-qt         # GUI Manage Proton Compatibility
    ];
  };

# Packages

  # Packages - System Profile
  environment.systemPackages = with pkgs; [
   neovim          # CLI Text Editor
   fastfetch       # CLI System Information
   wget            # CLI File Transfer
   curl            # CLI File Transfer
   kitty           # GUI Terminal Application
   git             # CLI Version Control
   syncthing       # File Synchronization

  # Desktop Environment: KDE Plasma
   kdePackages.kate                     # GUI Text Editor, IDE
   kdePackages.filelight                # GUI Disk Usage
   kdePackages.kdeconnect-kde           # GUI Phone Sync
   kdePackages.plasma-systemmonitor     # GUI System Monitor
   kdePackages.ark                      # GUI Archiving Tool
   kdePackages.spectacle                # GUI Screenshot Capture
   kdePackages.kcalc                    # GUI Calculator
   kdePackages.kfind                    # GUI File/Folder Search
   kdePackages.ksystemlog               # GUI System Log Viewer
   kdePackages.krdc                     # GUI Remote Desktop Client
   kdePackages.kleopatra                # GUI Certificate Manager
   kdePackages.audiotube                # GUI YouTube Music Client
   kdePackages.plasmatube               # GUI YouTube Client
   kdePackages.okular                   # GUI Document Viewer
   kdePackages.gwenview                 # GUI Image Viewer
   kdePackages.kgpg                     # GUI Encryption Utility
   syncthingtray                        # GUI Syncthing KDE Plasma Integration
  ];

# Applications & Modules

  # Steam
  programs.steam.enable = true;

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

# End
}
