#! /bin/bash
mkdir -p ~/dotfiles

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