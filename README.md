# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup on New Machine

### Create config for chezmoi

```bash
mkdir -p ~/.config/chezmoi
# Copy key.txt from backup to ~/.config/chezmoi/key.txt
chmod 600 ~/.config/chezmoi/key.txt
```

### Install chezmoi

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
chezmoi cd
chezmoi init https://github.com/splywaczyk/dotfiles
cp ~/.local/share/chezmoi/.chezmoi.toml ~/.config/chezmoi/
```

### Run setup and apply dotfiles

```bash
cd ~/.local/share/chezmoi/
./setup.sh
```

### VS Code Setup

To fully provision VS Code with the required extensions for C++, Bazel, Python, and Systems Engineering, run this one-liner in your terminal:

```bash
for ext in alefragnani.bookmarks anthropic.claude-code bazelbuild.vscode-bazel christian-kohler.path-intellisense davidanson.vscode-markdownlint editorconfig.editorconfig fanaticpythoner.better-todo-tree jdinhlife.gruvbox llvm-vs-code-extensions.vscode-clangd mechatroner.rainbow-csv ms-azuretools.vscode-containers ms-azuretools.vscode-docker ms-python.debugpy ms-python.python ms-python.vscode-pylance ms-python.vscode-python-envs ms-vscode-remote.remote-containers ms-vscode-remote.remote-ssh ms-vscode-remote.remote-ssh-edit ms-vscode-remote.remote-wsl ms-vscode-remote.vscode-remote-extensionpack ms-vscode.remote-explorer ms-vscode.remote-server redhat.vscode-yaml streetsidesoftware.code-spell-checker usernamehw.errorlens vadimcn.vscode-lldb yzhang.markdown-all-in-one ; do code --install-extension $ext ; done
```

### Chezmoi Cheat Sheet

You only need to remember these 4 commands for daily operations:

```bash
chezmoi edit ~/.bashrc          # Safely edit a tracked file
chezmoi diff                    # Check what changed before applying
chezmoi apply                   # Apply changes to your system
chezmoi cd                      # Enter the local repository to run 'git commit' & 'git push'
```

## Tools

| Tool | Alias | Description |
|------|-------|-------------|
| eza | `ls`, `ll`, `lt` | Better ls with icons |
| bat | `cat` | Syntax highlighting |
| fd | `fd` | Better find |
| ripgrep | `rg` | Better grep |
| zoxide | `cd`, `cdi` | Smart cd |
| fzf | `Ctrl+T/R`, `Alt+C` | Fuzzy finder |
| delta | - | Better git diffs |
| lazygit | `lg` | Git TUI |
| btop | `btop` | System monitor |

