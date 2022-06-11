#!/usr/bin/env bash
# This file:
#
#  - Configures a fresh arch installation
#
# Usage:
#
#  ./setup.sh
#
# Based on a template by BASH3 Boilerplate v2.4.1
# http://bash3boilerplate.sh/#authors
#
# The MIT License (MIT)
# Copyright (c) 2013 Kevin van Zonneveld and contributors
# You are not obligated to bundle the LICENSE file with your b3bp projects as long
# as you leave these references intact in the header comments of your source files.

# bash best practices
# https://kvz.io/bash-best-practices.html

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
set -o xtrace

# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

# if [[ ! -e "${__file}" ]]; then
#   echo >&2 "Please cd into the cloned git repository before running ${__file}"
#   exit 1
# fi

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
sudo pacman -S --noconfirm --needed base base-devel linux linux-firmware linux-headers grub sudo man-db xorg xf86-video-amdgpu pulseaudio pavucontrol networkmanager network-manager-applet wireless_tools wpa_supplicant os-prober mtools dosfstools dialog xdg-user-dirs wget git bspwm sxhkd picom arandr nitrogen rofi polybar zsh kitty neovim mpv keepassxc thunderbird go
# install picom-git with yay instead of picom from community repo?
# install pipewire instead of pulseaudio?
# enable networkmanager?
# sudo systemctl enable NetworkManager

# install yay
__yay_dir="$HOME/github/yay"
if [[ ! -d "${__yay_dir}" ]]
then
  git clone "https://aur.archlinux.org/yay.git" "${__yay_dir}"
  cd "${__yay_dir}"
  makepkg -si --noconfirm --needed
  cd -
fi

# create symlinks to config files
mkdir --parents "$HOME/.config"
ln --symbolic --target-directory="$HOME/.config" "${__dir}"/.config/* || true

# install and setup zsh
ln --symbolic --target-directory="$HOME" "${__dir}/.zshrc" || true
ln --symbolic --target-directory="$HOME" "${__dir}/.zsh_aliases" || true
ln --symbolic --target-directory="$HOME" "${__dir}/.p10k.zsh" || true

__omz_main_dir="${ZSH:-$HOME/.oh-my-zsh}"
if [[ ! -d "${__omz_main_dir}" ]]
then
  wget "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
  sh install.sh --unattended --keep-zshrc
  rm install.sh
  # alternative aproach:
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

__omz_custom_dir="${ZSH_CUSTOM:-${__omz_main_dir}/custom}"

if [[ ! -d "${__omz_custom_dir}/plugins/zsh-syntax-highlighting" ]]
then
  git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${__omz_custom_dir}/plugins/zsh-syntax-highlighting"
fi

if [[ ! -d "${__omz_custom_dir}/plugins/zsh-autosuggestions" ]]
then
  git clone "https://github.com/zsh-users/zsh-autosuggestions" "${__omz_custom_dir}/plugins/zsh-autosuggestions"
fi

if [[ ! -d "${__omz_custom_dir}/themes/powerlevel10k" ]]
then
  git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${__omz_custom_dir}/themes/powerlevel10k"
fi

# check if $SHELL is set as zsh before changing it (unnecessary?)
#chsh --shell /bin/zsh $USER

# install fonts

# install ly
__ly_dir="$HOME/github/ly"
if [[ ! -d "${__ly_dir}" ]]
then
  git clone --recurse-submodules "https://github.com/nullgemm/ly.git" "${__ly_dir}"
  cd "${__ly_dir}"
  make
  sudo make install
  sudo systemctl enable ly.service
  cd -
fi

# copy bspwm and sxhkd template config files to .config

