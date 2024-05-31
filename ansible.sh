#!/usr/bin/env bash
set -eu

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install Ansible roles"
roles=(
    # 'geerlingguy.git'
    'geerlingguy.docker'
    # 'githubixx.kubectl'
    # 'geerlingguy.helm'
    # 'gantsign.minikube'
    # 'staticdev.pyenv'
)

for role in ${roles[*]}
do
    ansible-galaxy role install  $role
done
ansible-playbook --ask-become-pass playbook.yml

./docker-without-sudo.sh