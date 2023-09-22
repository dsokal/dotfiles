# source ~/.zprezto/runcoms/zshrc

path_append() {
  ARG="$1"
  if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
    export PATH="${PATH:+"$PATH:"}$ARG"
  fi
}

path_prepend() {
  ARG="$1"
  if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
    export PATH="$ARG${PATH:+":$PATH"}"
  fi
}

unsetopt nomatch

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

# zsh-completions zsh-syntax-highlighting
plugins=(brew git history)
source $ZSH/oh-my-zsh.sh

if [[ "$machine" = "Mac" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

alias open_ports='lsof -i -P | grep -i "listen"'
alias cat='pygmentize -g'
alias show_path='echo "$PATH" | tr ":" "\n" | nl'
alias cgrep="grep --color=always"

export VOLTA_HOME="$HOME/.volta"
path_prepend "$VOLTA_HOME/bin:$PATH"

# Keep as last command in file
[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local
