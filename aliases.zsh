# Shortcuts
alias copyssh="pbcopy < ${HOME}/.ssh/id_ed25519.pub 2>/dev/null || echo 'No ~/.ssh/id_ed25519.pub found'"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll='command -v gls >/dev/null && gls -AhlFo --color --group-directories-first || ls -AhlFo'
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel (Lando-first)
alias a="lando artisan"
alias fresh="lando artisan migrate:fresh --seed"
alias seed="lando artisan db:seed"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Project helpers
alias spin="~/.dotfiles/spin-new-laravel.sh"
alias spinclone="~/.dotfiles/spin-clone-laravel.sh"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force-with-lease"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
