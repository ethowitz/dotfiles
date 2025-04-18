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
source ~/.fzf/completion.zsh
source ~/.fzf/key-bindings.zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# aliases
alias co='git checkout $(git branch --sort=-committerdate | fzf)'
alias g!='f() { git "$@" --no-verify };f'
alias git!='f() { git "$@" --no-verify };f'
alias mv='mv -i'
alias pp='cd `git rev-parse --show-toplevel`'
alias tf='terraform'
alias vim='nvim'

function pc() {
	git_root="$(git rev-parse --show-toplevel 2> /dev/null)" || "$(echo ~/dev)"
        new_dir="$(fd -H -I -t f -t s -t d \
		--exclude 'node_modules' \
		--exclude 'bazel-*' \
		--exclude '.git' \
		--follow \
		--strip-cwd-prefix \
		--base-directory ${git_root} \
		.projectroot \
		-x dirname {} \
		| uniq \
		| fzf)"

	if [ ! -z "${new_dir}" ]; then
		cd "$git_root/$new_dir"
	fi

}

function pp() {
        git_root="$(git rev-parse --show-toplevel 2> /dev/null)"

	if [ ! -z "${git_root}" ]; then
		cd "$git_root"
	fi
}

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
