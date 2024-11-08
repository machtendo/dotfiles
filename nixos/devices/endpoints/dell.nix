# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    ];

# System Settings

  # Enable the X11 windowing system.
  # Required for SDDM - You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  
  # Enable 32-Bit Support
  hardware.graphics.enable32Bit = true;

  # Touchpad Support
  services.libinput.enable = true;

# Networking
  
  networking.hostName = "nixtest"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Firewall
    # Firewall Status
    # networking.firewall.enable = false;
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];

# Desktop Environment

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      vlc                 # GUI Video Player
      parsec-bin          # GUI Low-latency Remote Access Client
      heroic              # Video Game Platform
      chiaki              # GUI PS Remote Play Client
      godot_4             # GUI 2D/3D Game Engine
      qbittorrent         # GUI Torrent Client
      gimp                # GNU Image Manipulation Program
      libreoffice         # GUI Productivity Suite
      discord             # GUI Discord Chat Client
      betterdiscordctl    # Discord Modifications
      github-desktop      # GUI GitHub Client
      proton-pass         # GUI Proton Pass Desktop
      protonvpn-gui       # GUI Proton VPN
      protonup-qt         # GUI Manage Proton Compatibility
      starship            # Customizable Shell Prompt
      qemu                # Virtual Machines
    ];
  };

# Packages

  # Packages - System Profile
  environment.systemPackages = with pkgs; [

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
   kdePackages.okular                   # GUI Document Viewer
   kdePackages.gwenview                 # GUI Image Viewer
   kdePackages.kgpg                     # GUI Encryption Utility
   syncthingtray                        # GUI Syncthing KDE Plasma Integration
  ];

# Applications & Modules

  # Steam
  programs.steam.enable = true;

  # direnv
  programs.direnv.enable = true;

  # SUID Wrappers
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

# Services

  # Enable Virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

# End
}
