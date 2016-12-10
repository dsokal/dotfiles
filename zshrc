source ~/.zprezto/runcoms/zshrc

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -s ~/.dotfiles/zshrc_local ]] && source ~/.dotfiles/zshrc_local

alias open_ports='netstat -lnptu'
alias open_ports_mac='lsof -i -P | grep -i "listen"'
alias cat=ccat

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm install
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
