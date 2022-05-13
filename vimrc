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
    Plug 'morhetz/gruvbox'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tomasr/molokai'
    Plug 'arcticicestudio/nord-vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
        let g:dracula_italic = 0
        let g:dracula_full_special_attrs_support = 1
        let g:dracula_colorterm = 0

" Status
    Plug 'vim-airline/vim-airline'
        let g:airline_extensions = ['fzf', 'ale', 'ycm', 'tagbar', 'branch',
          \ 'fugitiveline', 'obsession']

" Lint
    Plug 'dense-analysis/ale'
        let g:ale_linters = {'javascript': ['eslint'], 'python': ['pylint'],
          \ 'HTML': ['prettier']}
        let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
          \ 'HTML': ['prettier'], 'javascript': ['prettier', 'eslint'],
          \ 'python': ['autoflake', 'autopep8', 'autoimport']}

        let g:ale_fix_on_save = 1
        nmap ]a <Plug>(ale_next_wrap)
        nmap [a <Plug>(ale_previous_wrap)
        nmap gd :ALEGoToDefinition<CR>
        nmap gr :ALEFindReferences<CR>

" Completion
    Plug 'ycm-core/YouCompleteMe'
        let g:ycm_filepath_completion_use_working_dir = 1
        let g:ycm_use_ultisnips_completer = 1
        let g:ycm_key_list_select_completion = ['<C-j>']
        let g:ycm_key_list_previous_completion = ['<C-k>']

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        let g:UltiSnipsExpandTrigger = "<C-l>"
        let g:UltiSnipsJumpForwardTrigger = "<C-j>"
        let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" Search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
        let $FZF_DEFAULT_COMMAND = 'rg -l ""' " use ripgrep to search
        map <C-p> :Files<CR>
        map <C-b> :Buffers<CR>
        map <Leader><Leader> :Commands<CR>
        map <Leader>h :Helptags<CR>
        map <Leader>/ :execute 'Rg ' . input('Rg/')<CR>
        map <Leader>l :BLines<CR>
        map <Leader>gf :GF?<CR>
        command! -bang -nargs=* RgExact       " Search for word under cursor
          \ call fzf#vim#grep(
          \   'rg -F --column --line-number --no-heading --color=always --smart-case
          \   -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
        nmap <Leader>G :execute 'RgExact ' . expand('<cword>') <Cr>

" Tags
    Plug 'preservim/tagbar'
        nmap <F8> :TagbarToggle<CR>

" Focus
    Plug 'junegunn/goyo.vim'
        function! s:goyo_enter()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status off
                silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            endif
            set noshowmode
            set noshowcmd
            set scrolloff=999
            Limelight
        endfunction

        function! s:goyo_leave()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status on
                silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            endif
            set showmode
            set showcmd
            set scrolloff=5
            Limelight!
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()

    Plug 'junegunn/limelight.vim'
        let g:limelight_conceal_ctermfg = 240

" Edit
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

" Git
    Plug 'tpope/vim-fugitive'

" Gutter
    Plug 'airblade/vim-gitgutter'
    Plug 'kshenoy/vim-signature'

" Session
    Plug 'tpope/vim-obsession'

" Tmux Integration
    Plug 'christoomey/vim-tmux-navigator'
        let g:tmux_navigator_save_on_switch = 2
        let g:tmux_navigator_preserve_zoom = 1
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent>  <C-H>  :TmuxNavigateLeft<cr>
        nnoremap <silent>  <C-J>  :TmuxNavigateDown<cr>
        nnoremap <silent>  <C-K>  :TmuxNavigateUp<cr>
        nnoremap <silent>  <C-L>  :TmuxNavigateRight<cr>
        nnoremap <silent>  <C-\>  :TmuxNavigatePrevious<cr>

" Wiki
    Plug 'vimwiki/vimwiki'

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set background=dark
colorscheme dracula

" Enable 256 colors in vim
set t_Co=256

set lazyredraw                   " Stops refresh during complex operations
set foldmethod=marker            " Markers used to specify folds
set autoindent                   " Copy indent from current line on new line
set smartindent                  " Smart autoindent on new line
set number                       " Add line numbers
set shiftwidth=4                 " Set shift width to 4 spaces
set tabstop=4                    " Set tab width to 4 columns
set expandtab                    " Use space character instead of tabs
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
set switchbuf=useopen            " Use open buffer if one exists
set autoread                     " Reload files when they change on disk

filetype on                      " Enable file type detection
filetype plugin on               " Enable plugins for detected file type
filetype indent on               " Load an indent file for the file type
syntax on                        " Syntax highlighting on
set spell spelllang=en_us        " Spellcheck
set wildmenu                     " Enable autocompletion after pressing tab
set wildmode=list:longest        " Make wildmenu behave like Bash completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set omnifunc=syntaxcomplete#Complete

" Netrw interface
let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'
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

" Relative numbers in normal mode, Absolute in insert
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
" autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
" autocmd Filetype javascript setlocal sw=4 expandtab

" This allows you to undo changes even after saving
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
