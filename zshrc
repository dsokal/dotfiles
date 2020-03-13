source ~/.zprezto/runcoms/zshrc

[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local

if [[ -z "$DOTFILES_DONT_LOAD_NVM" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh

alias open_ports='lsof -i -P | grep -i "listen"'
alias cat='ccat'
