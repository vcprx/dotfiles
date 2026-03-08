#!/bin/sh

echo "Setting up your Mac..."

# Optional hostname argument
if [ -n "$1" ]; then
  export CUSTOM_HOSTNAME="$1"
fi

# Check for Oh My Zsh and install if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

# Check for Homebrew and install if not present
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Removes ~/.zshrc if it exists and symlinks the new one from the current directory (dotfiles)
rm -f "$HOME/.zshrc"
ln -s "$(PWD)/.zshrc" "$HOME/.zshrc"

# Removes ~/.config/ghostty/config if it exists and symlinks the new one from the current directory (dotfiles)
rm -rf "$HOME/.config/ghostty"

[ ! -d "$HOME/.config" ] && mkdir "$HOME/.config"
[ ! -d "$HOME/.config/ghostty" ] && mkdir "$HOME/.config/ghostty"
ln -s "$(PWD)/.ghostty/config" "$HOME/.config/ghostty/config"

# Removes ~/.vimrc if it exists and symlinks the new one from the current directory (dotfiles)
rm -f "$HOME/.vimrc"
ln -s "$(PWD)/.vimrc" "$HOME/.vimrc"

rm -f "$HOME/.oh-my-zsh/themes/cprz.zsh-theme" 
ln -s "$(PWD)/cprz.zsh-theme" "$HOME/.oh-my-zsh/themes/cprz.zsh-theme"

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew bundle --file ./Brewfile --verbose

# Check if directories exist, and create them if they don't
[ ! -d "$HOME/Code" ] && mkdir "$HOME/Code"
[ ! -d "$HOME/Code/projects" ] && mkdir "$HOME/Code/projects"
[ ! -d "$HOME/Code/work" ] && mkdir "$HOME/Code/work"

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
