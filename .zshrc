if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle z

antigen apply

export EDITOR="vim"

# Change it to localhost if the proxy host is on localhost
# Change it to the target IP if the machine is a virtual machine and the proxy on another machine is used
export PROXY_HOST="127.0.0.1"

alias zshconf="$EDITOR ~/.zshrc"
alias i3conf="$EDITOR ~/.config/i3/config"
alias tmuxconf="$EDITOR ~/.tmux.conf"
alias proxify="export HTTP_PROXY=http://$PROXY_HOST:1080 && export HTTPS_PROXY=http://$PROXY_HOST:1080"
alias unproxify="unset HTTP_PROXY HTTPS_PROXY"

function source_if_exists {
	[[ ! -f $1 ]] || source $1
}

source_if_exists /usr/share/nvm/init-nvm.sh

source_if_exists ~/.cargo/env 

source_if_exists ~/.p10k.zsh

export PATH=$PATH:$HOME/.local/bin:$HOME/.emacs.d/bin
export BROWSER="/mnt/c/Program Files (x86)/Microsoft/Edge Dev/Application/msedge.exe"
