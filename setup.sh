#!/bin/bash

DOTFILES_DIR=$(pwd)
SCRIPT_NAME=$(basename "$0")

if [[ ! -e $SCRIPT_NAME ]]; then
  echo >&2 "Please cd into the cloned git repository before running $SCRIPT_NAME"
  exit 1
fi

# make sure that the script was executed with sudo?
#if [[ $(id -u) -eq 0 ]]
#then
#  echo "has sudo"
#else
#  echo "no sudo"
#fi

# enclose commands that need to be run without sudo in a function
# func(){
#     echo "Username: $USER"
#     echo "    EUID: $EUID"
# }
# 
# export -f func
# 
# func
# su "$SUDO_USER" -c 'func'

#do a full system upgrade
sudo pacman -Syyu --noconfirm

# install required software (will config files be created? need to remove before
# creating symlinks, or install software after)
sudo pacman -S --noconfirm --needed base base-devel wget man-db git bspwm sxhkd picom arandr nitrogen rofi polybar zsh kitty neovim mpv keepassxc thunderbird go
# install picom-git with yay instead of picom from community repo?

# install yay
YAY_DIR=$HOME/github/yay
if [[ ! -d "$YAY_DIR" ]]
then
  git clone https://aur.archlinux.org/yay.git $YAY_DIR
  cd $YAY_DIR
  makepkg -si --noconfirm --needed
  cd -
fi

# create symlinks to config files
mkdir -p $HOME/.config
ln -s -t $HOME/.config $DOTFILES_DIR/.config/*

# install and setup zsh
ln -s -t $HOME $DOTFILES_DIR/.zshrc
ln -s -t $HOME $DOTFILES_DIR/.zsh_aliases
ln -s -t $HOME $DOTFILES_DIR/.p10k.zsh

if [[ ! -d "$HOME/.oh-my-zsh" ]]
then
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  sh install.sh --unattended --keep-zshrc
  rm install.sh
  # alternative aproach:
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

OMZ_CUSTOM_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [[ ! -d "$OMZ_CUSTOM_DIR/plugins/zsh-syntax-highlighting" ]]
then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ_CUSTOM_DIR/plugins/zsh-syntax-highlighting
fi

if [[ ! -d "$OMZ_CUSTOM_DIR/plugins/zsh-autosuggestions" ]]
then
  git clone https://github.com/zsh-users/zsh-autosuggestions $OMZ_CUSTOM_DIR/plugins/zsh-autosuggestions
fi

if [[ ! -d "$OMZ_CUSTOM_DIR/themes/powerlevel10k" ]]
then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $OMZ_CUSTOM_DIR/themes/powerlevel10k
fi

# check if $SHELL is set as zsh before changing it
#chsh --shell /bin/zsh $USER

# install fonts

# install ly
LY_DIR=$HOME/github/ly
if [[ ! -d $LY_DIR ]]
then
  git clone --recurse-submodules https://github.com/nullgemm/ly.git $LY_DIR
  cd $LY_DIR
  make
  sudo make install
  sudo systemctl enable ly.service
  cd -
fi
