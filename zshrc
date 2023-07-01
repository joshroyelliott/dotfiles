# ============================================================================
#
#                  ███████╗███████╗██╗  ██╗██████╗  ██████╗
#                  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#                    ███╔╝ ███████╗███████║██████╔╝██║
#                   ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#                  ███████╗███████║██║  ██║██║  ██║╚██████╗
#                  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
# ============================================================================
# PLUGINS {{{
# ============================================================================

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
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

eval "$(zoxide init zsh)"

# }}}
# ============================================================================
# OH MY ZSH {{{
# ============================================================================

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

source $ZSH/oh-my-zsh.sh

# }}}
# ============================================================================
# ALIASES {{{
# ============================================================================

# Uncomment to use custom prompt
# export STARSHIP_CONFIG=~/.config/starship/starship.toml

export EDITOR='nvim'
export VISUAL='nvim'

# Nvim config selector
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

function nvims() {
    items=("Default" "AstroNvim" "NvChad" "LazyVim")
    config=$(printf '%s\n' "${items[@]}" | fzf --prompt="Select nvim config: " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z "$config" ]]; then
        echo "No config selected"
        return 0
    elif [[ "$config" == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME="$config" nvim $@
}

bindkey -s ^n "nvims\n"
alias v="nvim-astro"

# Quick access to dotfiles
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'
alias vimrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.vimrc'
alias tmuxconf='${=EDITOR} ${ZDOTDIR:-$HOME}/.tmux.conf'

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# exa
if command -v exa > /dev/null 2>&1; then
    alias ll="exa -alh"                     # nicely formatted list
    alias tree="exa --tree"                 # replace tree with exa tree
fi

# bat
if command -v bat > /dev/null 2>&1; then
    alias cat="bat"                     # replace cat
fi

# zoxide
if command -v zoxide > /dev/null 2>&1; then
    alias cd="z"                            # replace cd
    alias zz="z -"                          # zz to previous directory
fi

# zk notebook
export ZK_NOTEBOOK_DIR="$HOME/notes"

export PATH="$PATH:/usr/local/share/npm/bin"
# This loads nvm bash_completion

export PATH="/usr/local/opt/llvm/bin:$PATH"

# }}}
# ============================================================================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
