source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle vi-mode
antigen bundle z

antigen apply

export EDITOR="vim"

# Change it to localhost if the proxy host is on localhost
# Change it to the target IP if the machine is a virtual machine and the proxy on another machine is used
export PROXY_HOST="host.docker.internal"
export PROXY_PORT="1080"

PROXY_URL="http://$PROXY_HOST:$PROXY_PORT"

alias zshconf="$EDITOR ~/.zshrc"
alias i3conf="$EDITOR ~/.config/i3/config"
alias tmuxconf="$EDITOR ~/.tmux.conf"
alias proxify="export HTTP_PROXY=$PROXY_URL && export HTTPS_PROXY=$PROXY_URL && export http_proxy=$PROXY_URL && export https_proxy=$PROXY_URL"
alias unproxify="unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy"

[[ ! -f ~/.cargo/env ]] || source ~/.cargo/env 

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
