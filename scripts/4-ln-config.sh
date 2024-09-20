#! /bin/bash

# nix-shell -p git
# cd ~
# git clone https://github.com/machtendo/dotfiles.git
# mv ~/dotfiles ~/.dotfiles

# Create Links

    # NixOS Configuration Files
    echo "Setting NixOS Soft Links..."

    sudo ln -sf ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
    sudo ln -sf ~/.dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

    # NixOS Home Manager Configuration Files
    echo "Setting Home Manager Soft Links..."

    ln -sf ~/.dotfiles/nixos/home.nix ~/.config/home-manager/home.nix
    ln -sf ~/.dotfiles/nixos/flake.nix ~/.config/home-manager/flake.nix
    ln -sf ~/.dotfiles/nixos/flake.lock ~/.config/home-manager/flake.lock

# Rebuild
sudo nixos-rebuild switch

# End
