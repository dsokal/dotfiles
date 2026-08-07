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
when_did_i_start() {
  local today start elapsed
  today=$(date +%Y-%m-%d)
  start=$(pmset -g log | grep "Display is turned on" | grep "^$today" | head -1 | cut -d' ' -f1,2)
  if [ -z "$start" ]; then
    echo "No display wake logged today ($today)"
    return 1
  fi
  elapsed=$(( $(date +%s) - $(date -j -f "%Y-%m-%d %H:%M:%S" "$start" +%s) ))
  printf 'Started: %s\nElapsed: %dh %02dm\n' "${start#* }" $((elapsed / 3600)) $((elapsed % 3600 / 60))
}

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

# for claude
HOMEDIR_LOCAL_BIN="$HOME/.local/bin"
if [ -d "$HOMEDIR_LOCAL_BIN" ]; then
  path_append $HOMEDIR_LOCAL_BIN
fi


if [[ "$machine" = "Linux" ]]; then
  source ~/.dotfiles/zshrc_linux
fi

# for vscode integrated terminal
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3D' backward-word

# !!! Keep as last command in file !!!
[[ -f ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local || true
