#!/bin/bash
# Dotfiles setup script

set -e

echo "=== Dotfiles Setup ==="

echo "=== Installing packages ==="
sudo apt update
sudo apt install -y \
    zsh git curl wget age unzip \
    fzf bat eza ripgrep fd-find \
    zoxide git-delta tldr btop \
    clang clangd clang-format build-essential \
    pipx

echo "=== Configuring bat alias ==="
mkdir -p ~/.local/bin
if [ ! -L ~/.local/bin/bat ]; then
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# Install Node
echo "=== Installing Node.js & NPM tools ==="
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

npm install -g @google/gemini-cli
npm install -g @bazel/bazelisk

# Install Buildifier
echo "=== Installing Buildifier ==="
curl -Lo ~/.local/bin/buildifier https://github.com/bazelbuild/buildtools/releases/latest/download/buildifier-linux-amd64
chmod +x ~/.local/bin/buildifier

echo "=== Installing Python global tools (pre-commit) ==="
pipx install pre-commit
pipx ensurepath

# Install lazygit
echo "=== Installing lazygit ==="
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz lazygit

# Install Oh My Zsh
echo "=== Installing Oh My Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Clone Zsh plugins (only if they don't exist yet)
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Install fonts
echo "=== Installing Nerd Fonts ==="
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip 
unzip -o JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
cd -

# Apply dotfiles
echo "=== Applying dotfiles ==="
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

