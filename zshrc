source ~/.zprezto/runcoms/zshrc

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh

alias open_ports='netstat -lnptu'

[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local
