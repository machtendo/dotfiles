#! /bin/bash

    # NixOS Home Manager Configuration Files
    echo "Setting Home Manager Soft Links..."

    ln -sf $HOME/.dotfiles/nixos/home.nix $HOME/.config/home-manager/home.nix
    ln -sf $HOME/.dotfiles/nixos/flake.nix $HOME/.config/home-manager/flake.nix
    ln -sf $HOME/.dotfiles/nixos/flake.lock $HOME/.config/home-manager/flake.lock
