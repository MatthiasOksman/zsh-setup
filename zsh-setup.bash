#!/bin/bash

# Download MesloLGS NF from https://github.com/romkatv/dotfiles-public/tree/master/.local/share/fonts/NerdFonts, install it and set it as the default font in your terminal

# Change to script directory
cd $(dirname "$0")

# Install ZSH
apt-get update
apt-get install -y curl git zsh

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh)

# Clone Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone Powerlevel 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Import Powerlevel Config
cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

# Activate Plugins
perl -pi -e 's/(?<=^plugins=\()[^\)]*(?=\))/git zsh-autosuggestions ubuntu kubectl docker colorize/g' ~/.zshrc

# Change Theme
perl -pi -e 's/(?<=^ZSH_THEME=")[^"]*(?=")/powerlevel10k\/powerlevel10k/g' ~/.zshrc