function git_branch {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) && echo " • $branch"
}

export PS1="\W$(git_branch) \\$ "

# history
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000

# aliases
alias vim='nvim'
alias ls='exa -F'
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
alias clip='xclip -selection clipboard -i'
alias scrot='scrot ~/pictures/screenshots/%Y-%m-%d_%I:%M:%S%P.png'

del() {
    for var in "$@"
    do
      mv "$var" ~/.trash
    done
}

# PATH
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# env
export ARCHFLAGS="-arch x86_64"
export BSPWM_EXTERNALMONITOR="DP1"
export BSPWM_INTERNALMONITOR="eDP1"
export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export SUDO_EDITOR="rvim"

