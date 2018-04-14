# MacOS-Setup

MacOS-Setup is a playbook to set up an OS X laptop.

It installs and configures most of the software I (jmaaks) use on my Mac.

The script follows this website:
http://binarynature.blogspot.co.uk/2016/01/install-ansible-on-os-x-el-capitan_30.html

* Install Command Line Developer Tools
* Install 'pip'
* Add Python 2.7 user bin directory to the PATH variable
* Install/Upgrade 'ansible' via 'pip'
* Create the system-wide Ansible directory
* Copy the default Ansible configuration file to the system-wide Ansible directory

Ansible can then install Homebrew, Homebrew Cask

mas from Homebrew will install Mac App Store apps

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.


## Requirements

I've tested it on;

* OS X Yosemite (10.13)


## Installation

### Fast Install

If you'd like to start with my default list of tools and apps (see Included Apps/Config below), then simply install with;

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/jmaaks/macos-setup/master/install.sh)"


You can always customize the install after-the-fact (see below), and re-run the playbook. It will skip over any installed apps.

### Custom Install

If you want to add/remove to the list of apps/utils installed, its pretty straightforward.

As above, download and bootstrap the script. But stop it before it starts ansible, and edit the playbook as desired, before re-running ansible.

1. Grab and start the bootstrap script. Let it install the prereqs and clone the full `jmaaks/macos-setup` repo locally...

      sh -c "$(curl -fsSL https://raw.githubusercontent.com/jmaaks/macos-setup/master/install.sh)"


1. Stop the script (Ctrl+C) when ansible asks for the a 'sudo' password.

        ```
        Changing to laptop repo dir ...

        Running ansible playbook ...
        SUDO password:  ^c

        ```

1. Change into the cloned repo dir

        cd laptop

1. Edit playbook.yml and add/remove the apps/utils you want.

        nano playbook.yml

1. Kick off ansible manually

        ansible-playbook playbook.yml -i hosts --ask-sudo-pass -vvvv

You can do this as many times as you like and re-run the `ansible-playbook` command. Ansible is smart enough to skip installed apps, so subsequent runs are super fast.


## Included Applications / Configuration

### Applications

Apps installed with Homebrew Cask:

  -

There are several more common cask apps listed in the playbook.yml - simply uncomment them to include them in your install.


### Packages/Utilities

Things installed with Homebrew:

  - autoconf

There are several more utils listed in the playbook.yml - simply uncomment them to include them in your install.


### System Settings

It also installs a few useful system preferences/settings/tweaks with a toned-down verson of Matt Mueller's [OSX-for Hackers script](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716).

It does some reasonably gnarly stuff e.g.

  - hide spotlight icon
  - disable app Gate Keeper
  - change stand-by delay from 1hr to 12hrs.
  - Set trackpad tracking rate.
  - Set mouse tracking rate.
  - and lots more...

so you need read it very carefully first. (see scripts/system_settings.sh)

TODO: moar sick settings with https://github.com/ryanmaclean/OSX-Post-Install-Script


### User Preferences

It then syncs your user prefs with dotfiles+rcm

It grabs the [thoughttbot/dotfiles](https://github.com/thoughtbot/dotfiles) repo, saves it in `~/src/thoughtbot/dotfiles` and symlinks it to ~/dotfiles.

It then grabs [glennr/dotfiles](https://github.com/glennr/dotfiles) repo, saves it in `~/src/glennr/dotfiles` and symlinks it to ~/dotfiles-local

You probably want to change the `dotfile_repo_username` variable to match your github username :-)

It then runs rcup to initialize your dotfiles.



### MacStore Apps (WIP)

These apps only available via the App Store. (sigh)

TODO: Port bork : https://github.com/mattly/bork/blob/master/types/macstore.sh and do this automagically!

  - Monosnap
  - Pages
  - Keynote
  - Numbers
  - etc



### Application Settings (WIP)

Keep your application settings in sync.

TODO: Add Mackup task


### Other

- install fonts like a boss : http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

- TODO: Install [Sublime Package Manager](http://sublime.wbond.net/installation).
- ZSH tab/auto completion
- Powerline in tmux
- zsh-autosuggestions plugin
- zsh-history-substring-search plugin
- zsh-notify plugin



## Development

You shouldn't wipe your entire workstation and start from scratch just to test changes to the playbook.

Instead, you can follow theses instructions for [how to build a Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm), on which you can continually run and re-run this playbook to test changes and make sure things work correctly.

### Approach

We've tested it using an OSX 10.10 Vagrant/Virtualbox VM for developing & testing the Ansible scripts.

Simply spin up the Yosemite box in a VM, and have vagrant kick off the laptop setup.

### Whats included?

Nada. Well not much. The whole point is to test the process of getting our OSX dev machines from zero to hero.

The Vagrant box we use is a [clean-ish install of OSX](https://github.com/timsutton/osx-vm-templates). However the setup notes above uses Packer, which installs Xcode CLI tools. This can't be automated in an actual test run, and needs user intervention to install.


### Test Setup

1. Get [Homebrew Cask](http://caskroom.io/)

        brew install caskroom/cask/brew-cask

1. Install [Vagrant](https://www.vagrantup.com/downloads)

        brew cask install --appdir="/Applications" vagrant

1. Install VirtualBox;

        brew cask install --appdir="/Applications" virtualbox

1. cd into this project directory;

1. Run

        vagrant init http://files.dryga.com/boxes/osx-yosemite-10.10.3.0.box;

1. The Vagrantfile should be ready as soon as Vagrant downloads the box;

1. Start VM

        vagrant up

### Notes

* VirtualBox doesn't have Guest additions for Mac OS X, so you can't have shared folders. Instead you can use normal network shared folders.

* If you are rolling your own box with [the OSX VM template](https://github.com/timsutton/osx-vm-templates), this is the Packer config;

      ```
      packer build \
        -var iso_checksum=aaaabbbbbbcccccccdddddddddd \
        -var iso_url=../out/OSX_InstallESD_10.10.4_14E46.dmg \
        -var update_system=0 \
        -var autologin=true \
        template.json
      ```

## Author

[Jeff Maaks](http://github.com/jmaaks), 2018.


## Credits

This project is based off the work of the following folks;

* Gallian's [macos-setup](https://github.com/galliangg/macos-setup)
* Eduardo de Oliveira Hernandes' [ansible-macbook](https://github.com/eduardodeoh/ansible-macbook)
* Jeff Geerlings' [Mac Dev Ansible Playbook](https://github.com/geerlingguy/mac-dev-playbook)
* [Thoughtbot/laptop](https://github.com/thoughtbot/laptop) (boostrapping, dev tools)
* [OSX for Hackers](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716) (awesome osx tweaks)
* [Mackup](https://github.com/lra/mackup)  (backup/restore App settings)

*See also*:

  - [Battleschool](http://spencer.gibb.us/blog/2014/02/03/introducing-battleschool) is a more general solution than what I've built here. (It may be a better option if you don't want to fork this repo and hack it for your own workstation...).
  - [osxc](https://github.com/osxc) is another more general solution, set up so you can fork the [xc-custom](https://github.com/osxc/xc-custom) repo and get your own local environment bootstrapped quickly.
  - [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks) was the original inspiration for this repository, but this project has since been completely rewritten.
