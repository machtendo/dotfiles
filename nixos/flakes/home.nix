{ config, pkgs, ... }:

{
  home.username = "jas";
  home.homeDirectory = "/home/jas";

  imports = [
    # Uncomment to enable Plasma Manager, if needed
    # <plasma-manager/modules>
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "machtendo";
    userEmail = "machtendo@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  # Home Manager state version
  home.stateVersion = "24.05";

  # Packages to install
  home.packages = [
    # Core utilities, add others as needed
    pkgs.neovim
    pkgs.git
  ];

  # Dotfiles and configuration file links
  home.file = {
    ".dotfiles/nixos/configuration.nix".source = "/etc/nixos/configuration.nix";
    ".dotfiles/nixos/hardware-configuration.nix".source = "/etc/nixos/hardware-configuration.nix";

    # Add Home Manager configurations if needed
    ".config/home-manager/home.nix".source = ./home.nix;
    ".config/home-manager/flake.nix".source = ./flake.nix;
    ".config/home-manager/flake.lock".source = ./flake.lock;
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim"; # Set your preferred editor here
  };

  # Enable Home Manager management of itself
  programs.home-manager.enable = true;

  # Plasma Manager setup, if needed
  # programs.plasma-manager.enable = true;
}