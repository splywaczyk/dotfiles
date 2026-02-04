#!/bin/bash
# Dotfiles setup script for KUbuntu

set -e

echo "=== Dotfiles Setup (KUbuntu) ==="

# Install packages
echo "=== Installing packages ==="
sudo apt update
sudo apt install -y \
    zsh git curl wget age \
    fzf bat eza ripgrep fd-find \
    zoxide git-delta tldr btop

# Install Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

# Install Gemini
npm install -g @google/gemini-cli

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit /usr/local/bin
rm /tmp/lazygit /tmp/lazygit.tar.gz

# Install Oh My Zsh
echo "=== Installing Oh My Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting

# Install fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip 
unzip JetBrainsMono.zip
fc-cache -fv

# Apply dotfiles
echo "=== Applying dotfiles ==="
chezmoi cd
git remote set-url --push origin git@github.com:splywaczyk/dotfiles.git
chezmoi apply

# Update tldr cache
tldr --update 2>/dev/null || true

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

echo ""
echo "=== Setup complete! ==="
echo "Restart terminal or run: source ~/.zshrc"

