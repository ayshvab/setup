#!/usr/bin/env bash
set -eu

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install Cosmos"

sudo wget -O /usr/bin/ape https://cosmo.zip/pub/cosmos/bin/ape-$(uname -m).elf
sudo chmod +x /usr/bin/ape

# sudo sh -c "echo -1 > /proc/sys/fs/binfmt_misc/cli"     # remove Ubuntu's MZ interpreter
sudo sh -c "echo -1 > /proc/sys/fs/binfmt_misc/status"  # remove ALL binfmt_misc entries
sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
sudo sh -c "echo ':APE-jart:M::jartsr::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"

mkdir -p ~/.local/bin
wget -O ~/.local/bin/emacs https://cosmo.zip/pub/cosmos/bin/emacs
wget -O ~/.local/bin/emacsclient https://cosmo.zip/pub/cosmos/bin/emacsclient
sudo chmod +x ~/.local/bin/*

title "Cosmos Finished! Please, restart your shell."
