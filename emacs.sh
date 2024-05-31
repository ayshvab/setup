#!/usr/bin/env bash

set -e  # Exit on errors

# Install prerequisites
sudo apt-get update
sudo apt-get install -y \
    autoconf \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Install build dependencies for a recent Emacs version (replace 29.3 if desired)
sudo apt-get install -y \
    gcc-14 libgccjit0 libgccjit-14-dev \
    libjansson4 libjansson-dev \
    libsqlite3-dev \
    libgnutls28-dev libtiff5-dev libgif-dev libjpeg-dev libpng-dev libxpm-dev texinfo

# Enable source repositories (if not already enabled)
if ! grep -q 'deb-src' /etc/apt/sources.list; then
  sudo sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list
fi
sudo apt-get update

# Install and compile Tree-sitter with latest tag
git clone --recursive https://github.com/tree-sitter/tree-sitter.git
cd tree-sitter
git checkout $(git describe --abbrev=0 --tags)  # Get latest tag
make
sudo make install
cd ..

# Get Emacs source
wget https://ftp.gnu.org/gnu/emacs/emacs-29.3.tar.xz
tar -xf emacs-29.3.tar.xz

cd emacs-29.3

# Configure build
export CC="gcc-14"
./autogen.sh
./configure \
    --with-mailutils \
    --without-sound \
    --with-tree-sitter \
    --with-native-compilation \
    --without-compress-install \
    --with-json \
    --without-x

# Compile and install (adjust cores for make)
make -j$(nproc)
sudo make install

echo "Emacs compiled and installed with latest Tree-sitter!"

# Optional: Clean up source directories
# rm -rf ../tree-sitter emacs-29.3
