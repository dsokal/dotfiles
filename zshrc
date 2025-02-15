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

plugins=(brew git history zsh-navigation-tools zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

if [[ "$machine" = "Mac" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$machine" = "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

alias open_ports='lsof -i -P | grep -i "listen"'
alias show_path='echo "$PATH" | tr ":" "\n" | nl'
alias cgrep="grep --color=always"

export VOLTA_HOME="$HOME/.volta"
if [ -d "$VOLTA_HOME" ]; then
  path_prepend $VOLTA_HOME/bin
else
  echo "Run ./install to install volta"
fi

HOMEDIR_BIN="$HOME/bin"
if [ -d "$HOMEDIR_BIN" ]; then
  path_append $HOMEDIR_BIN
fi

if [[ "$machine" = "Linux" ]]; then
  source ~/.dotfiles/zshrc_linux
fi

# !!! Keep as last command in file !!!
[[ -f ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local || true
