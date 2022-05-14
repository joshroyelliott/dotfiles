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

# Dracula themed FZF (Misbehaves in Terminal.app)
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
DRACULA_DISPLAY_GIT=1
DRACULA_DISPLAY_TIME=1
DRACULA_DISPLAY_CONTEXT=1
DRACULA_ARROW_ICON="-> "

# ----------------------------------------------------------------------------
# ZSH SYNTAX HIGHLIGHTING (DRACULA)
# ----------------------------------------------------------------------------

#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
#typeset -gA ZSH_HIGHLIGHT_STYLES

### General
#### Diffs
#### Markup
### Classes
### Comments
#ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4'
### Constants
### Entitites
### Functions/methods
#ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B'
#ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#50FA7B'
#ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#50FA7B'
#ZSH_HIGHLIGHT_STYLES[function]='fg=#50FA7B'
#ZSH_HIGHLIGHT_STYLES[command]='fg=#50FA7B'
#ZSH_HIGHLIGHT_STYLES[precommand]='fg=#50FA7B,italic'
#ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#FFB86C,italic'
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FFB86C'
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#FFB86C'
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
### Keywords
### Built ins
#ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD'
#ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#8BE9FD'
#ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#8BE9FD'
### Punctuation
#ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FF79C6'
#ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#FF79C6'
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#FF79C6'
#ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#FF79C6'
### Serializable / Configuration Languages
### Storage
### Strings
#ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#F1FA8C'
#ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#F1FA8C'
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#F1FA8C'
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#FF5555'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#F1FA8C'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#FF5555'
#ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#F1FA8C'
### Variables
#ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#FF5555'
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[assign]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#F8F8F2'
### No category relevant in spec
#ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#FF79C6'
#ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#FF79C6'
#ZSH_HIGHLIGHT_STYLES[globbing]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#BD93F9'
##ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
##ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
##ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
##ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#FF5555'
#ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[arg0]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[default]='fg=#F8F8F2'
#ZSH_HIGHLIGHT_STYLES[cursor]='standout'

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
# ZSH_THEME="agnoster"

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
# ALIASES {{{
# ============================================================================

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
if command -v bat > /dev/null; then
    alias cat="bat"                     # replace cat
fi

# zoxide
alias cd="z"                            # replace cd
alias zz="z -"                          # zz to previous directory

# }}}
# ============================================================================

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
