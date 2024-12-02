# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    ];

# Kernel / Boot
  
  # Install OVMF for UEFI support in Virtual Machines
  #boot.loader.efi.canTouchEfiVariables = true;

  # Enable IOMMU for GPU passthrough
  #boot.kernelParams = [ "iommu=pt" "amd_iommu=on" "intel_iommu=on" ];

  # Load the vfio kernel modules and bind GPU devices
  #boot.extraModulePackages = [ pkgs.vfio ];

  # Specify which devices to bind to vfio-pci
  #boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

  # Match devices to vfio-pci driver (replace with your GPU’s PCI addresses)
  # You can get these with `lspci | grep VGA` for GPU and `lspci | grep Audio` for its audio device.
  #hardware.pci = {
    # Example PCI IDs, replace with actual GPU and GPU Audio IDs
  #  ids = [ "0000:01:00.0" "0000:01:00.1" ];      # GPU and GPU audio
  #  modules = [ "vfio-pci" ];
  #};

# Drivers

  # nVidia - https://nixos.wiki/wiki/Nvidia

  # GPU Passthrough - https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # nVidia Prime - 
  hardware.nvidia.prime = {
    #sync.enable = true;            # Note: Cannot enable Sync and Offload modes simultaneously
    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:1:0:0";     # nVidia GPU
    intelBusId = "PCI:0:2:0";      # Intel GPU (Integrated)
    #amdgpuBusId = "PCI:54:0:0";   # AMD GPU
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };

# System Settings

  # Enable the X11 windowing system.
  # Required for SDDM - You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  
  # Enable 32-Bit Support
  hardware.graphics.enable32Bit = true;

  # Touchpad Support
  services.libinput.enable = true;

# Networking
  
  networking.hostName = "legion"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Firewall
    # Firewall Status
    networking.firewall.enable = true;
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
      brave               # GUI Web Browser
      parsec-bin          # GUI Low-latency Remote Access Client
      gimp                # GNU Image Manipulation Program
      lenovo-legion       # Power, Fan, RGB Control for Lenovo Legion - https://github.com/johnfanv2/LenovoLegionLinux
      libreoffice         # GUI Productivity Suite
      github-desktop      # GUI GitHub Client
      proton-pass         # GUI Proton Pass Desktop
      protonvpn-gui       # GUI Proton VPN
      starship            # Customizable Shell Prompt
      qemu                # Virtual Machines
    ];
  };

# Packages

  # Packages - System Profile
  environment.systemPackages = with pkgs; [

  # Lenovo Legion - Power Management, Fan Control, RGB, etc.
  linuxKernel.packages.linux_latest_libre.lenovo-legion-module

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

  # SUID Wrappers
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

# Services

# Enable virtualization with KVM
#virtualisation.libvirtd = {
#  enable = true;
#  qemuPackage = pkgs.qemu_kvm;  # Ensure you use the KVM-enabled QEMU

  # Enable OVMF for UEFI support in Virtual Machines
#  qemuOvmf.enable = true; # Add this line to enable OVMF

  # Find the path needed here with this command: nix-store -q --outputs $(nix-instantiate '<nixpkgs>' -A ovmf)
  #extraConfig = ''
   #nvram = "/nix/store/<path-to-ovmf>/OVMF_CODE.fd:/nix/store/<path-to-ovmf>/OVMF_VARS.fd";
   #'';

  # Specify VM configurations
  #  qemuOptions = ''
    #<domain>
    #  <disk type='block' device='disk'>
    #    <driver name='qemu' type='raw'/>
    #    <source device='/dev/nvme1n1'/>  # Replace with your actual SSD device path
    #    <target dev='vda' bus='virtio'/>
    #    <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    #  </disk>
    #</domain>
  #'';
 #};

#  programs.virt-manager.enable = true;
  
  # OpenRGB
  services.hardware.openrgb.enable = true;

  # Power Management for Intel CPUs
  services.thermald.enable = true;       # Thermal management to prevent overheating
  services.tlp.enable = true;            # Advanced power management for battery life

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

# End
}
