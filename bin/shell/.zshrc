#!/usr/bin/sh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# MacVim as Default editor
export EDITOR=vim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pongstr"

# Aliases
alias zshconfig="vi $HOME/.zshrc"
alias ohmyzsh="cd $HOME/.oh-my-zsh"

# Home Folders
# ---------------------------------------------------------------------------

alias home="$HOME && clear"
alias apps="/Applications"
alias music="$HOME/Music/"
alias movies="$HOME/Movies/"
alias dropbox="/Volumes/Pongstr/Dropbox/"
alias pictures="$HOME/Pictures/"
alias documents="$HOME/Documents"

# Projects Directory
# ---------------------------------------------------------------------------

PROJECTS="$HOME/Projects"

alias github="$PROJECTS/github"
alias sandbox="$PROJECTS/sandbox"
alias projects="$PROJECTS"

# Dev Stuff
# ---------------------------------------------------------------------------

# Jekyll: must be in the same working directory
alias jekyllstart="jekyll serve --watch --baseurl=/"
alias pywebstart="python -m SimpleHTTPServer"

# MongoDB
alias mongostart="mongod --dbpath $HOME/.mongodb-data"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=10

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby terminalapp)

source $ZSH/oh-my-zsh.sh


# Configs
# -----------------------------------------------------------------------------

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Android SDK
export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_SDK="$(brew --prefix android-sdk)"
export JAVA_PATH="${PATH}/Applications/Android\ Studio.app/sdk/platform-tools:/Applications/Android\ Studio.app/sdk/tools"
export JAVA_PATH="${JAVA_HOME}/bin:$JAVA_PATH"
export JAVA_PATH="/usr/local/bin:$JAVA_PATH"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Thanks for the awesome idea batasrki
function gemdir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    rvm "$1"
    cd $(rvm gemdir)
    pwd
  fi
}

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
