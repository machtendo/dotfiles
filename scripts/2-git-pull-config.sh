#! /bin/bash

nix-shell -p git
git clone https://github.com/machtendo/dotfiles.git
mv ~/dotfiles ~/.dotfiles

# Create Links

    # NixOS Configuration Files
    echo "Setting NixOS Soft Links..."

    sudo ln -sf $HOME/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
    sudo ln -sf $HOME/.dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix


# End
