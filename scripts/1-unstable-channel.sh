#! /bin/bash

# Add NixOS Unstable Channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

# Update Channels
sudo nix-channel --update

# Rebuild & Upgrade
sudo nixos-rebuild switch --upgrade