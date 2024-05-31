#!/usr/bin/env bash
set -eu

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install pip and Ansible"
sudo apt install python3-pip
sudo apt install pipx
pipx ensurepath
pipx install --include-deps ansible

title "Install build-essential"
sudo apt install build-essential git curl wget libedit-dev htop libxcb-cursor0 net-tools -y

title "Setup Git"
git config --global user.name $NAME && git config --global user.email $EMAIL

title "Setup fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

title "Install JetBrainsMono"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# title "Install Chromium and Insomnia"
# sudo snap install chromium
# sudo snap install insomnia

title "Install Codium and extensions"
sudo snap install codium --classic && ./codium-extensions.sh

sudo apt install ripgrep

title "Finished! Please, restart your shell."
