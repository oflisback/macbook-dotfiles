brew install exa
brew install alacritty

brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew install neovim
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font

brew install ripgrep
brew install zoxide
brew install --cask discord
brew install --cask google-chrome
brew install --cask firefox
brew install --cask 1password
brew install --cask spotify
brew install --cask docker
brew install --cask rectangle
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install pyenv

brew install --cask alfred

brew install python

brew install mas
# Flow (Pomodoro Timer)
# mas install 1423210932


brew cleanup

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
