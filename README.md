# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup on New Machine

### Install chezmoi

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
chezmoi init https://github.com/splywaczyk/dotfiles
```

### Create config for chezmoi

```bash
mkdir -p ~/.config/chezmoi
# Copy key.txt from backup to ~/.config/chezmoi/key.txt
chmod 600 ~/.config/chezmoi/key.txt
# Copy config file
cp ~/.local/share/chezmoi/.chezmoi.toml ~/.config/chezmoi/
```

### Run setup and apply dotfiles

```bash
cd ~/.local/share/chezmoi/
./setup.sh
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

