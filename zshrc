export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export ZSH_THEME=""

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export BAT_CONFIG_PATH=$HOME/.batrc

export TERM="xterm-256color"
setopt RM_STAR_WAIT
setopt interactivecomments
setopt CORRECT
# vi mode
bindkey -v
# history
bindkey "^R" history-incremental-search-backward
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# antigen
# source /usr/local/share/antigen/antigen.zsh
source $HOME/bin/antigen.zsh
antigen use oh-my-zsh

antigen bundle chrissicool/zsh-256color
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle web-search
# pure propmpt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
# vim mode
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle sharat87/zsh-vim-mode
antigen apply

autoload -Uz compinit && compinit 
autoload -Uz promptinit && promptinit

if [ -f ~/.zsh/aliases ]; then
    source ~/.zsh/aliases
fi
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_R_OPTS="--height 40% --layout reverse --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"
