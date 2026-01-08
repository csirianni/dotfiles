# Environment variables
export EDITOR="nvim"
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Aliases
alias gs="git status"
alias gl="git log"
alias gb="git --no-pager branch -v"
alias vim="nvim"
alias e="nvim"

# Source Nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
fi

# Yazi function
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

check() {
  echo "Running symbol-checker build..."
  bazel build --config=symbol-checker //src/... || return 1
  
  echo "\nChecking CODEOWNERS errors..."
  bazel run codeowners
  
  echo "\nChecking format..."
  if ! bazel run format; then
    echo "\nFormat check failed, running Starlark formatter..."
    bazel run //bazel/format:rules_lint_format_Starlark_with_buildifier || return 1
  fi
  
  echo "\n✓ All checks passed!"
}

ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || true
