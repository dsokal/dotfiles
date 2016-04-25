source ~/.zprezto/runcoms/zshrc

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local

alias open_ports='netstat -lnptu'
alias cat=ccat
