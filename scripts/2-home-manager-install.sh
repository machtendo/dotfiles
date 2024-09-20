#! /bin/bash

# Add Home Manager Channel
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Update Channels
sudo nix-channel --update

# Install Home Manager
nix-shell '<home-manager>' -A install