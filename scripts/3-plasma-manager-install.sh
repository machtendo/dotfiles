#! /bin/bash

# Add Home Manager Channel
sudo nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager

# Update Channels
sudo nix-channel --update plasma-manager

# Install Home Manager
nix-shell '<home-manager>' -A install