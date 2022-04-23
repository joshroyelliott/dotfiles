# ============================================================================
#                                   ██
#                                   ░██
#                     ██████  ██████░██      ██████  █████
#                    ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#                       ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#                      ██    ░░░░░██░██  ░██ ░██   ░██   ██
#                     ██████ ██████ ░██  ░██░███   ░░█████
#                    ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
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
# ALIASES {{{
# ============================================================================

# always prompt and show what's being deleted
alias rm="rm -i"

# # ls: adding colors, verbose listing
# # and humanize the file sizes:
# alias ls="ls --color -l -h"

alias ctags="`brew --prefix`/bin/ctags"

# grep: color and show the line
# number for each match:
alias grep="grep -n --color"

# always show with color
alias tree="tree -C"

alias exa="exa --long --tree"

# Custom cd that also ls's
cs()
{
builtin cd $@ && ls
}

# }}}
# ============================================================================
# CONFIGURATION {{{
# ============================================================================

# ----------------------------------------------------------------------------
# FZF
# ----------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------
#                    |\                          ,,
#                     \\          _              ||   _
#                    / \\ ,._-_  < \,  _-_ \\ \\ ||  < \,
#                   || ||  ||    /-|| ||   || || ||  /-||
#                   || ||  ||   (( || ||   || || || (( ||
#                    \\/   \\,   \/\\ \\,/ \\/\\ \\  \/\\
# ----------------------------------------------------------------------------

# The git segment can be disabled
DRACULA_DISPLAY_GIT=1

# The time segment shows a clock in either a 12 or 24 hour format based on your locale
DRACULA_DISPLAY_TIME=1

# The context segment shows the username, and, if logged in via SSH, the hostname
DRACULA_DISPLAY_CONTEXT=1

# The status segment indicator can be changed by setting the arrow icon
DRACULA_ARROW_ICON="-> "

# The custom segment can be changed by setting the DRACULA_CUSTOM_VARIABLE
# export DRACULA_CUSTOM_VARIABLE=AWS:PROD:EU-WEST-1

# You can display a new line for your commands
# DRACULA_DISPLAY_NEW_LINE=1

# Git Locking 0 or 1
# DRACULA_GIT_NOLOCK=0

# ----------------------------------------------------------------------------
# ZOXIDE
# ----------------------------------------------------------------------------

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

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# }}}
# ============================================================================

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
