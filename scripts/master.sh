#! /bin/bash


# NixOS Unstable Channel

    echo "Switching to NixOS Unstable Channel..."

    # Add NixOS Unstable Channel
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

    # Update Channels
    sudo nix-channel --update

    # Rebuild & Upgrade
    sudo nixos-rebuild switch --upgrade

# Home Manager Standalone

    echo "Installing Home Manager Standalone..."

    # Add Home Manager Channel
    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

    # Update Channels
    sudo nix-channel --update

    # Install Home Manager
    nix-shell '<home-manager>' -A install

# Download Dotfiles from Github
    #    # Create Temporary Shell Using Git
    #    nix-shell -p git
    #    # Ensure Home Directory
    #    cd ~
    #    # Clone Dotfiles Repository
    #    git clone https://github.com/machtendo/dotfiles.git
    #    # Exit nix-shell
    #    exit
    #    # Ensure Home Directory
    #    cd ~
    #    # Hide Dotfiles Folder
    #    mv ~/dotfiles ~/.dotfiles

# Link Dotfiles

    # Create Links - NixOS Configuration Files
    echo "Setting NixOS Soft Links..."
    sudo ln -sf ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix

    # Copy & Link hardware-configuration.nix
    sudo mv /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix
    sudo ln -sf ~/.dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

    # NixOS Home Manager Configuration Files
    echo "Setting Home Manager Soft Links..."

    ln -sf ~/.dotfiles/nixos/home.nix ~/.config/home-manager/home.nix
    ln -sf ~/.dotfiles/nixos/flake.nix ~/.config/home-manager/flake.nix
    ln -sf ~/.dotfiles/nixos/flake.lock ~/.config/home-manager/flake.lock
