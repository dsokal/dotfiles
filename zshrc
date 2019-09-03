source ~/.zprezto/runcoms/zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local

alias open_ports='lsof -i -P | grep -i "listen"'
alias cat='ccat'
