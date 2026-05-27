# perryescape

Personal bootstrap repo — clone on any Mac, run the setup, everything's ready.

```
git clone git@github.com:cgchiraggupta/perryescape.git && cd perryescape && ./install.sh
```

## What's inside

| What | Where | Why |
|------|-------|-----|
| 🚀 **Install** | `install.sh` | Master bootstrap — brew, dotfiles, tools, all at once |
| 🍺 **Brew** | `Brewfile` | Every brew/cask/mas package in one file |
| ⚙️ **Dotfiles** | `dotfiles/` | zsh, git, ssh template — symlinked into place |
| 🛠️ **Scripts** | `scripts/` | Handy utilities (caffeinate, git helpers, system info) |
| 📝 **Configs** | `config/` | Neovim, gitignore, tool configs |

## Quick start

```bash
# Fresh machine — everything at once
./install.sh

# Or just the dotfiles
./install.sh --dotfiles

# Or just brew stuff
./install.sh --brew

# Or just scripts into PATH
./install.sh --scripts
```

## Project structure

```
perryescape/
├── install.sh          # Master installer (idempotent)
├── Brewfile            # Homebrew bundle
├── dotfiles/
│   ├── zshrc           # Shell config → ~/.zshrc
│   ├── gitconfig       # Git config → ~/.gitconfig
│   ├── gitignore       # Global gitignore
│   └── ssh-config      # SSH config template
├── scripts/            # CLI utilities added to PATH
│   ├── caf             # Caffeinate toggle
│   ├── uncaf           # Un-caffeinate
│   ├── cafstatus       # Caffeinate status
│   ├── git-daily       # Daily git summary
│   └── ...             # More tools
└── config/
    └── nvim/           # Neovim config (if any)
```
