" ============================================================================
"
"                  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"                  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"                  ██║   ██║██║██╔████╔██║██████╔╝██║
"                  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                   ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                    ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
" ============================================================================
" .VIMRC {{{
" ============================================================================

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

" Disable compatibility with VI
set nocompatible

" Set leader to Space
let mapleader      = ' '
let maplocalleader = ' '

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin()

" Themes
    Plug 'dracula/vim', { 'as': 'dracula' }

" Status
    Plug 'vim-airline/vim-airline'

" Lint
    Plug 'dense-analysis/ale'

" Completion
    Plug 'ycm-core/YouCompleteMe'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

" Edit
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

" Git
    Plug 'tpope/vim-fugitive'

" Session
    Plug 'tpope/vim-obsession'

" Tmux Integration
    Plug 'christoomey/vim-tmux-navigator'

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" Enable 256 colors in vim
set t_Co=256

set lazyredraw                   " Stops refresh during complex operations
set foldmethod=marker            " Markers used to specify folds
set autoindent                   " Copy indent from current line on new line
set smartindent                  " Smart autoindent on new line
set number                       " Add line numbers
" set shiftwidth=4                 " Set shift width to 4 spaces
" set tabstop=4                    " Set tab width to 4 columns
" set expandtab                    " Use space character instead of tabs
set nobackup                     " Do not save backup files
set scrolloff=50                 " Do not let cursor scroll past N lines
set nowrap                       " Do not wrap lines
set incsearch                    " Incrementally highlight search characters
set ignorecase                   " Ignore capital letters during search
set smartcase                    " Override ignorecase for capital letters
set showcmd                      " show partial command typed
set noshowmode                   " remove mode from last line
set showmatch                    " show matching words during search
set hlsearch                     " highlight when searching
set history=10000                " Set commands to save in history
set colorcolumn=80               " Show colorcolumn
set cursorline                   " Show cursorline

set list                         " display unprintable characters
set listchars=tab:▸\ ,eol:¬      " Use textmate-style whitespace characters

set switchbuf=useopen            " Use open buffer if one exists
set autoread                     " Reload files when they change on disk

" Enable file type detection
filetype on
" Enable plugins for detected file type
filetype plugin on
" Load an indent file for the file type
filetype indent on
" Syntax highlighting on
syntax on
" Omnicomplete (Inellisense) on
set omnifunc=syntaxcomplete#Complete
" Spellcheck
set spell spelllang=en_us
" Enable autocompletion after pressing tab
set wildmenu
" Make wildmenu behave like Bash completion
set wildmode=list:longest
" Ignore files not to be edited with Vim
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Netrw interface
let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'
" open at startup if no argument specified
" autocmd VimEnter * if !argc() | Explore | endif
" open if specified argument is a directory
autocmd VimEnter * if isdirectory(expand('<afile>')) | Explore | endif

" ctags
set tags=./tags;/

" mouse
silent! set ttymouse=xterm2
set mouse=a

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

" Make Y behave like other capitals
nnoremap Y y$

" Search results in middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv

" vv visual mode highlight line
nnoremap vv 0v$

" Clear search
nnoremap <leader>c :nohl<CR>
" Toggle line numbers
nnoremap <C-n> :set norelativenumber!<CR>:set nonumber!<CR>

" This will use relative hybrid numbers in normal mode.
" Absolute numbers in insert or when not in focus.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
" autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
" autocmd Filetype javascript setlocal sw=4 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Quickly edit dotfiles
map <silent> <leader>so :source ~/.vimrc<CR>
map <leader>ev :edit ~/.config/dotfiles/vimrc<CR>
map <leader>et :edit ~/.config/dotfiles/tmux.conf<CR>
map <leader>ez :edit ~/.config/dotfiles/zshrc<CR>
map <leader>df :edit ~/.config/dotfiles/<CR>

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" }}}
" ============================================================================
" PLUGIN SPECIFIC SETTINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" AIRLINE {{{
" ----------------------------------------------------------------------------
"                  _                       _      _ _
"           __   _(_)_ __ ___         __ _(_)_ __| (_)_ __   ___
"           \ \ / / | '_ ` _ \ _____ / _` | | '__| | | '_ \ / _ \
"            \ V /| | | | | | |_____| (_| | | |  | | | | | |  __/
"             \_/ |_|_| |_| |_|      \__,_|_|_|  |_|_|_| |_|\___|
"
" ----------------------------------------------------------------------------

let g:airline_theme='dracula'

" empty list disables all
let g:airline_extensions = ['fzf', 'ale', 'ycm', 'branch', 'fugitiveline', 'obsession']

let airline#extensions#ale#error_symbol = 'AE:'       " ale error_symbol
let airline#extensions#ale#warning_symbol = 'AW:'     " ale warning
let airline#extensions#ale#show_line_numbers = 1      " ale show_line_numbers

let g:airline#extensions#ycm#error_symbol = 'YE:'
let g:airline#extensions#ycm#warning_symbol = 'YW:'

let g:airline#extensions#branch#vcs_priority = ["git"] "need svn integration

" set marked window indicator string
let g:airline#extensions#obsession#indicator_text = '$'

" }}}
" ----------------------------------------------------------------------------
" DRACULA {{{
" ----------------------------------------------------------------------------
"                    |\                          ,,
"                     \\          _              ||   _
"                    / \\ ,._-_  < \,  _-_ \\ \\ ||  < \,
"                   || ||  ||    /-|| ||   || || ||  /-||
"                   || ||  ||   (( || ||   || || || (( ||
"                    \\/   \\,   \/\\ \\,/ \\/\\ \\  \/\\
" ----------------------------------------------------------------------------

set background=dark
let g:dracula_bold = 1
let g:dracula_italic = 0
let g:dracula_underline = 1
let g:dracula_undercurl = 1
let g:dracula_full_special_attrs_support = 1
let g:dracula_inverse = 0
let g:dracula_colorterm = 0
augroup dracula_customization
      au!
      autocmd Colorscheme dracula hi CursorLine cterm=underline term=underline
augroup END
colorscheme dracula
" }}}
" ----------------------------------------------------------------------------
" FZF {{{
" ----------------------------------------------------------------------------

" use ripgrep to search for files
let $FZF_DEFAULT_COMMAND = 'rg -l ""'

" fzf files in the cwd
map <C-p> :Files<CR>
" fzf open buffers
map <C-b> :Buffers<CR>
" fzf available cmds
map <Leader><Leader> :Commands<CR>
" fzf text in cwd
map <Leader>/ :execute 'Rg ' . input('Rg/')<CR>
" fzf lines in file
map <Leader>l :BLines<CR>
" fzf for files commited
map <Leader>gf :GF?<CR>
" Search for word under cursor
command! -bang -nargs=* RgExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case
  \   -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
nmap <Leader>G :execute 'RgExact ' . expand('<cword>') <Cr>

" }}}
" ----------------------------------------------------------------------------
" ALE {{{
" ----------------------------------------------------------------------------

" Enable completion where available.
" This setting must be set before ALE is loaded.
" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc

let g:ale_linters = {'javascript': ['eslint'], 'python': ['pylint'], 'HTML': ['prettier']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'HTML':
       \['prettier'], 'javascript': ['prettier', 'eslint'], 'python': ['autoflake',
       \'autopep8', 'autoimport']
       \}

let g:ale_fix_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lsp_suggestions = 1
let g:ale_set_highlights = 1
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>

" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

" }}}
" ----------------------------------------------------------------------------
" YOUCOMPLETEME {{{
" ----------------------------------------------------------------------------

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_max_num_candidates = 20
let g:ycm_auto_trigger = 1
let g:ycm_filetype_whitelist = {'*': 1}
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>>'
let g:ycm_always_populate_location_list = 0
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_use_ultisnips_completer = 1

" Avoid conflict with UltiSnips - Complete with tab
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']

" }}}
" ----------------------------------------------------------------------------
" ULTISNIPS {{{
" ----------------------------------------------------------------------------

" Avoid conflict with YCM - Complete with C-l
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" }}}
" ----------------------------------------------------------------------------
" VIM TMUX NAVIGATOR {{{
" ----------------------------------------------------------------------------

" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
" If the tmux window is zoomed, keep it zoomed when moving from Vim
let g:tmux_navigator_preserve_zoom = 1

" Remap to Caps to reduce collisions
let g:tmux_navigator_no_mappings = 1
nnoremap <silent>  <C-H>  :TmuxNavigateLeft<cr>
nnoremap <silent>  <C-J>  :TmuxNavigateDown<cr>
nnoremap <silent>  <C-K>  :TmuxNavigateUp<cr>
nnoremap <silent>  <C-L>  :TmuxNavigateRight<cr>
nnoremap <silent>  <C-\>  :TmuxNavigatePrevious<cr>

" }}}
" ----------------------------------------------------------------------------
" }}}
" ===========================================================================
