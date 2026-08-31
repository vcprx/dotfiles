function commit() {
  local commitMessage="$*"

  git add .

  if [ "$commitMessage" = "" ]; then
     diff_input=$(echo "=== Summary ===" && git diff --cached --stat && echo -e "\n=== Diff (truncated if large) ===" && git diff --cached | head -c 50000)

     local spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
     local i=0
     (while true; do
       printf "\r${spinner[$((i % ${#spinner[@]} + 1))]} Generating commit message..." >&2
       i=$((i + 1))
       sleep 0.1
     done) &
     local spinner_pid=$!

     commitMessage=$(opencode run --format json "Write a single-line commit message for this diff. Output ONLY the message, no quotes, no explanation, no markdown.

$diff_input" | jq -r 'select(.type == "text") | .part.text' | tr -d '\n')

     kill $spinner_pid 2>/dev/null
     printf "\r\033[K" >&2

     git commit -m "$commitMessage"
     return
  fi

  eval "git commit -a -m '${commitMessage}'"
}

# Open PhpStorm without attaching the IDE to the current shell
function phpstorm() {
  open -a PhpStorm "${@:-.}"
}
