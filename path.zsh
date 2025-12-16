# Load dotfiles binaries (only if present)
[ -d "$DOTFILES/bin" ] && export PATH="$DOTFILES/bin:$PATH"

# Composer global binaries (support old + new locations)
[ -d "$HOME/.composer/vendor/bin" ] && export PATH="$HOME/.composer/vendor/bin:$PATH"
[ -d "$HOME/.config/composer/vendor/bin" ] && export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Node global binaries (only if present)
[ -d "$HOME/.node/bin" ] && export PATH="$HOME/.node/bin:$PATH"
[ -d "$HOME/.npm-global/bin" ] && export PATH="$HOME/.npm-global/bin:$PATH"

# Prefer project-specific binaries when inside a project
[ -d "./node_modules/.bin" ] && export PATH="$(pwd)/node_modules/.bin:$PATH"
[ -d "./vendor/bin" ] && export PATH="$(pwd)/vendor/bin:$PATH"

# Optional: GNU coreutils (disabled by default)
# if command -v brew >/dev/null 2>&1; then
#   COREUTILS_GNUBIN="$(brew --prefix coreutils)/libexec/gnubin"
#   [ -d "$COREUTILS_GNUBIN" ] && export PATH="$COREUTILS_GNUBIN:$PATH"
# fi
