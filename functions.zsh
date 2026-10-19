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

# Run tests with Pest, falling back to PHPUnit
function p() {
  if [ -f vendor/bin/pest ]; then
    vendor/bin/pest "$@"
  else
    vendor/bin/phpunit "$@"
  fi
}

# Create a directory (and parents) and cd into it
function mkd() {
  mkdir -p "$@" && cd "$_"
}

# Run Laravel tests in parallel
function pp() {
  php artisan test --parallel "$@"
}

# Clone a GitHub repo using owner/repo shorthand
function clone() {
  gh repo clone "$1" "${@:2}"
}

# Show common DNS records for a domain
function digga() {
  for type in A AAAA CNAME MX NS TXT SOA; do
    dig +noall +answer +multiline "$1" "$type"
  done
}
