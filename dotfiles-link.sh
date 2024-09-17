#! /bin/bash

# Create 'dotfiles' directory
echo "Creating dotfiles Folder in $HOME..."
mkdir -p $HOME/.dotfiles/nixos

# Move Configuration Files to 'dotfiles'

    # NixOS Configuration Files
    echo "Moving NixOS Configuration Files..."

    sudo mv /etc/nixos/configuration.nix $HOME/dotfiles/nixos/
    sudo mv /etc/nixos/hardware-configuration.nix $HOME/dotfiles/nixos/

    # NixOS Home Manager Configuration Files
    echo "Moving Home Manager Configuration Files..."

    mv $HOME/.config/home-manager/home.nix
    mv $HOME/.config/home-manager/flake.nix
    mv $HOME/.config/home-manager/flake.lock

# Create Links

    # NixOS Configuration Files
    echo "Setting NixOS Soft Links..."

    sudo ln -sf $HOME/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
    sudo ln -sf $HOME/.dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

    # NixOS Home Manager Configuration Files
    echo "Setting Home Manager Soft Links..."

    ln -sf $HOME/.dotfiles/nixos/home.nix $HOME/.config/home-manager/home.nix
    ln -sf $HOME/.dotfiles/nixos/flake.nix $HOME/.config/home-manager/flake.nix
    ln -sf $HOME/.dotfiles/nixos/flake.lock $HOME/.config/home-manager/flake.lock

# End

echo "Configuration Files moved to $HOME/.dotfiles and linked to their original location"
