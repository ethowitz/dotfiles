setopt incappendhistory # append history from different open shells
setopt ignore_eof # ignore Ctrl-d
setopt histignoredups # ignore duplicates in command history

export ZSH="$HOME/.oh-my-zsh"
PROMPT=' %b%3~ $(git_prompt_info)%B$%f%b '
ZSH_THEME="afowler"
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# aliases
alias vim='nvim'
alias ls='eza'
alias mv='mv -i'
alias co='git checkout $(git branch --sort=-committerdate | fzf)'

# platform specific stuff
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# set up homebrew
	eval "$(/opt/homebrew/bin/brew shellenv)"

	export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
else
	>&2 echo "unknown OS detected: $OSTYPE"
fi

# source cargo's env
. "$HOME/.cargo/env"

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

export GPG_TTY=$(tty)

# add changes specific to this particular machine
source ~/.zshrc.local
