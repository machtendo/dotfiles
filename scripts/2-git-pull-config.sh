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

# Rebuild
sudo nixos-rebuild switch --upgrade

# End
