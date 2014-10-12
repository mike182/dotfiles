#
# OPTIONS
#

setopt hist_ignore_all_dups 	# older command is removed from the list
setopt hist_reduce_blanks       # remove superfluous blanks
setopt append_history           # zsh sessions will append their history list to the history file
setopt inc_append_history       # new lines are added to the $HISTFILE as soon as they are entered
setopt extended_history         # Save each command’s beginning timestamp and the duration
setopt prompt_subst             # allows variable substitution to take place in the prompt
setopt share_history

#
# ENV
#

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LANG=en_US
export SHELL=zsh
# export LC_CTYPE=en_US.UTF-8 	# this setting is for the new UTF-8 terminal support
# export LC_ALL=en_US.UTF-8	# this setting is for the new UTF-8 terminal support
export LC_ALL=C
export TERM=xterm-256color      # should be set by the application that is acting as your terminal.
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE=${HOME}/.zsh_history

# source "$(dirname $(readlink ~/.zshrc))/base16-shell/base16-default.dark.sh"
REPORTTIME=10                   # print elapsed time if more than 10s
export GIT_EDITOR==vim          # use the right vim in git

#
# ALIASES
#

if ls --color > /dev/null 2>&1; then
	colorflag="--color" # GNU
else
	colorflag="-G" # OS X
fi

alias a='apropos'
alias h='history'
alias j='jobs'
alias v='vim'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias tmux='tmux -2'
alias ls='ls -hG ${colorflag}'
alias ll='ls -l ${colorflag}'
alias grep='grep --color=auto'
alias reload='source ${HOME}/.zshrc'
# alias treload='tmux source-file ${HOME}/.tmux.conf'
# alias soxplay='sox -r 8000 -b 8 -c 1 -t raw -e signed-integer - -d'

# show/hide hidden files in the finder
alias AppleShowAllFiles_TRUE='defaults write com.apple.finder AppleShowAllFiles TRUE'
alias AppleShowAllFiles_FALSE='defaults write com.apple.finder AppleShowAllFiles FALSE'

#
# BINDS
#

bindkey -e # emacs binds
bindkey "\e[3~" delete-char # delete

# {alt,ESC}-BS to delete last part from directory name
slash-backward-kill-word() {
        local WORDCHARS="${WORDCHARS:s@/@}"
        zle backward-kill-word
}
zle -N slash-backward-kill-word
bindkey '\e^?' slash-backward-kill-word

# {alt,ESC}-e to edit command-line in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^xe' edit-command-line
# bindkey '\ee' edit-command-line

#
# PROMPT
#

autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

S=%{$reset_color%}
if [[ $UID != 0  ]]; then
	C=%{$fg[blue]%} # user
else
	C=%{$fg[green]%} # root
fi

PSYMB="%(!.${C}# ${S}.${C}$ ${S})"
PROMPT="${PSYMB}"
JPROMPT="${C}(${S}%B%?%b|%j${C})${S}"
PPROMPT="${C}[${S}%~${C}]${S}"
RPROMPT="${JPROMPT}${PPROMPT}"

#
# COMPLETION
#

autoload -Uz compinit
compinit -i

# red dots displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:approximate:*' max-errors par 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:processes' command 'ps -au$USER' # kill completion
zstyle ':completion:*:warnings' format 'No matches for: %d' # testing
