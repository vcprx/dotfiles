# Laravel
alias a="php artisan"
alias mfs="php artisan migrate:fresh --seed"

# Git
alias nah="git reset --hard;git clean -df"
alias push="git push"
alias pull="git pull"
alias gpo="git push origin"
alias uncommit="git reset --soft HEAD~1"

# Claude
alias c="claude"

# Composer
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cda="composer dump-autoload -o"

# eza
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias l="eza -la --icons --group-directories-first --hyperlink"
  alias lt="eza --icons --tree --level=2"
fi
