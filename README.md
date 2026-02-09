# Dotfiles

Personal dotfiles for macOS development environment.

## Symlinked Files

The `fresh.sh` script creates symlinks from your home directory to the dotfiles repository:

| Symlink Location | Points To | Purpose |
|-----------------|-----------|---------|
| `~/.zshrc` | `~/dotfiles/.zshrc` | Main Zsh configuration |
| `~/.vimrc` | `~/dotfiles/.vimrc` | Vim configuration |
| `~/.config/ghostty/config` | `~/dotfiles/.ghostty/config` | Ghostty terminal config |
| `~/.oh-my-zsh/themes/cprz.zsh-theme` | `~/dotfiles/cprz.zsh-theme` | Custom Oh My Zsh theme |
| `~/.claude` | `~/dotfiles/config/claude` | Claude Code skills directory |

## Agent Skills

Available skills for Claude Code and OpenCode:

### context7-auto-research

Automatically fetches up-to-date documentation from Context7 when you ask about libraries, frameworks, or APIs.

**Requirements:**
- Context7 API key (get one at [context7.com/dashboard](https://context7.com/dashboard))

**Setup:**
```bash
# Create .env file in the skill directory
cp ~/.claude/skills/context7-auto-research/.env.example ~/.claude/skills/context7-auto-research/.env
```
