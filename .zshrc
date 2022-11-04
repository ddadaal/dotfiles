if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle git
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle z
antigen bundle command-not-found

antigen apply

export EDITOR="vim"

# Change it to localhost if the proxy host is on localhost
# Change it to the target IP if the machine is a virtual machine and the proxy on another machine is used
# export PROXY_HOST="127.0.0.1"
export PROXY_HOST="$(hostname).local"
export PROXY_PORT=1080

alias zshconf="$EDITOR ~/.zshrc"
alias i3conf="$EDITOR ~/.config/i3/config"
alias tmuxconf="$EDITOR ~/.tmux.conf"
alias proxify="export HTTP_PROXY=http://$PROXY_HOST:$PROXY_PORT && export HTTPS_PROXY=$HTTP_PROXY && export http_proxy=$HTTP_PROXY && export https_proxy=$HTTP_PROXY"
alias unproxify="unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy"

function source_if_exists {
	[[ ! -f $1 ]] || source $1
}

source_if_exists /usr/share/nvm/init-nvm.sh

source_if_exists ~/.cargo/env 

source_if_exists ~/.p10k.zsh

export PATH=$PATH:$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/.cargo/bin
export BROWSER="/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
export DISPLAY="$PROXY_HOST:0.0"
export XDG_RUNTIME_DIR=/tmp/xdg_runtime_dir
export RUNLEVEL=3

# eval "$(mcfly init zsh)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/home/ddadaal/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
alias dc="docker compose"
