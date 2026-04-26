# Define an array of emojis
PROMPT_ICONS=("🚀" "🔥" "🍆" "💦" "👽" "👾")

# Pick a random emoji, ensuring a valid index
RANDOM_ICON="${PROMPT_ICONS[RANDOM % ${#PROMPT_ICONS[@]} + 1]}"

# Define the prompt with padding and emoji
PROMPT="%(?:%{$fg_bold[green]%} $RANDOM_ICON :%{$fg_bold[red]%} $RANDOM_ICON ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

# Define right prompt (full path in dim color)
RPS1="%F{242}%~%f"

# Git prompt settings (same as robbyrussell)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

