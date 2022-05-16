# ============================================================================
#                                   ██
#                                   ░██
#                     ██████  ██████░██      ██████  █████
#                    ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#                       ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#                      ██    ░░░░░██░██  ░██ ░██   ░██   ██
#                     ██████ ██████ ░██  ░██░███   ░░█████
#                    ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
# ============================================================================
# PLUGINS {{{
# ============================================================================

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

# }}}
# ============================================================================
# CONFIG {{{
# ============================================================================

export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Options to fzf command
export FZF_COMPLETION_OPTS='--info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Dracula themed FZF (Misbehaves in Terminal.app)
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

DRACULA_DISPLAY_GIT=1
DRACULA_DISPLAY_TIME=1
DRACULA_DISPLAY_CONTEXT=1
DRACULA_ARROW_ICON="-> "

eval "$(zoxide init zsh)"

# }}}
# ============================================================================
# OH MY ZSH {{{
# ============================================================================
#                    __                                     __
#             ____  / /_     ____ ___  __  __   ____  _____/ /_
#            / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
#           / /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
#           \____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
#                                /____/
# ============================================================================

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dracula"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# }}}
# ============================================================================
# ALIASES {{{
# ============================================================================

if command -v most > /dev/null 2>&1; then
    export PAGER="most"
fi

if command -v vim > /dev/null 2>&1; then
    export EDITOR=vim
fi

alias v="vim"
# always prompt and show what's being deleted
alias rm="rm -i"
# use exuberant ctags
alias ctags="`brew --prefix`/bin/ctags"

# exa
alias ls="exa"                          # replace ls
alias ll="exa -alh"                     # nicely formatted list
alias tree="exa --tree"                 # replace tree with exa tree

# bat
if command -v bat > /dev/null 2>&1; then
    alias cat="bat"                     # replace cat
fi

# zoxide
alias cd="z"                            # replace cd
alias zz="z -"                          # zz to previous directory

# }}}
# ============================================================================

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
