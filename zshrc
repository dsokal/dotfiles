source ~/.zprezto/runcoms/zshrc

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

[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -z "$DOTFILES_DONT_LOAD_NVM" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh

alias open_ports='lsof -i -P | grep -i "listen"'
alias cat='ccat'
alias show_path='echo "$PATH" | tr ":" "\n" | nl'
alias cgrep="grep --color=always"
