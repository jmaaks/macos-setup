#!/bin/sh

# Welcome to the jmaaks macos-setup script!
# Be prepared to turn your OSX box into
# a development beast.
#
# This script bootstraps our OSX laptop to a point where we can run
# Ansible on localhost. It;
#  1. Installs
#    - xcode
#    - homebrew
#    - pip
#    - ansible (via pip) from http://binarynature.blogspot.co.uk/2016/01/install-ansible-on-os-x-el-capitan_30.html
#    - a few ansible galaxy playbooks (zsh, homebrew, cask etc)
#  2. Kicks off the ansible playbook
#    - main.yml
#
#  Run this:
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/jmaaks/macos-setup/master/install.sh)"
#
# It will ask you for your sudo password

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Boostrapping ..."

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Ensure Apple's command line tools are installed
if ! command -v cc >/dev/null; then
  fancy_echo "Installing xcode ..."
  xcode-select --install
else
  fancy_echo "Xcode already installed. Skipping."
fi

# Install Homebrew
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
else
  fancy_echo "Homebrew already installed. Skipping."
fi

# Install PiP via easy_install
if ! command -v pip >/dev/null; then
  fancy_echo "Installing Pip..."
  easy_install --user pip </dev/null
  printf 'if [ -f ~/.bashrc ]; then\n  source ~/.bashrc\nfi\n' >> $HOME/.profile
  printf 'export PATH=$PATH:$HOME/Library/Python/2.7/bin\n' >> $HOME/.bashrc
  source $HOME/.profile
else
  fancy_echo "PiP already installed. Skipping."
fi

# [Install Ansible](http://docs.ansible.com/intro_installation.html).
if ! command -v ansible >/dev/null; then
  fancy_echo "Installing Ansible ..."
  pip install --user --upgrade ansible
  sudo mkdir /etc/ansible
  sudo curl -L https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg -o /etc/ansible/ansible.cfg
else
  fancy_echo "Ansible already installed. Skipping."
fi

# Clone the repository to your local drive.
if [ -d "./macos-setup" ]; then
  fancy_echo "Laptop repo dir exists. Removing ..."
  rm -rf ./macos-setup/
fi
fancy_echo "Cloning laptop repo ..."
git clone https://github.com/jmaaks/macos-setup.git

fancy_echo "Changing to laptop repo dir ..."
cd macos-setup

# Run this from the same directory as this README file.
fancy_echo "Running ansible playbook ..."
# ansible-playbook playbook.yml -i hosts -K
