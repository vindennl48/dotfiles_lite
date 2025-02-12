#!/bin/sh

echo "--> Installing Dotfiles Lite.."

echo "    For this to work you need to install the following:"
echo "    neovim gcc xclip tmux"
echo "    As well as zsh and changing the shell: chsh \$(which zsh)"
echo "    "
echo "    For Arch and Pyenv.. Make sure you install Make and run the pyenv"
echo "    installer."
echo "    \$ sudo pacman -Syu make"
echo "    \$ curl -fsSL https://pyenv.run | bash"
echo "    "

echo "--> Would you like to continue? [y/n]"
read -r response
if [ "$response" != "y" ]; then
  exit 0
fi

echo "--> Adding Zsh"
if [ -d "$HOME/.zshrc" ]; then
  echo "    Found an existing .zshrc file.."
  echo "    Do you want to move .zshrc to .zshrc.bak? [y/n]"
  read -r response
  if [ "$response" = "y" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
  else
    echo "    Skipping"
  fi
fi
cp "zsh/zshrc" "$HOME/.zshrc"
echo "    Done"

echo "--> Adding Neovim"
if [ -d "$HOME/.config/nvim" ]; then
  echo "    Found an existing .config/nvim directory.."
  echo "    Do you want to move .config/nvim to .config/nvim.bak? [y/n]"
  read -r response
  if [ "$response" = "y" ]; then
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
  else
    echo "    Skipping"
  fi
fi
mkdir -p "$HOME/.config"
cp -a "nvim" "$HOME/.config/nvim"
echo "    Done"

echo "--> Adding Tmux"
if [ -d "$HOME/.tmux.conf" ]; then
  echo "    Found an existing .tmux.conf file.."
  echo "    Do you want to move .tmux.conf to .tmux.conf.bak? [y/n]"
  read -r response
  if [ "$response" = "y" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
  else
    echo "    Skipping"
  fi
fi
cp "tmux/tmux.conf" "$HOME/.tmux.conf"
echo "    Done"

echo "--> Adding Git Settings"
if [ -d "$HOME/.gitconfig" ]; then
  echo "    Found an existing .gitconfig file.."
  echo "    Do you want to move .gitconfig to .gitconfig.bak? [y/n]"
  read -r response
  if [ "$response" = "y" ]; then
    mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
  else
    echo "    Skipping"
  fi
fi
cp "git/gitconfig" "$HOME/.gitconfig"
echo "    Done"

echo "--> Finished installing Dotfiles Lite!"

