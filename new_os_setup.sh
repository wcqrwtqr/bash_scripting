#!/usr/bin/env bash

# setting up a new raspberrypi
sudo apt update && sudo apt upgrade
echo "update and upgrade done"
sleep 2
# installing
sudo apt install vim tmux emacs zsh

# installing oh my zsh
echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Add the following line to the zsh plugin"
echo "zsh-autosuggestions"
