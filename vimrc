" ============================================================================
"
"                  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"                  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"                  ██║   ██║██║██╔████╔██║██████╔╝██║
"                  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                   ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                    ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
" ============================================================================

" ============================================================================
" .VIMRC {{{
" ============================================================================

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

" Disable compatibility with VI
set nocompatible

augroup vimrc
    autocmd!
augroup END

let s:darwin = has('mac')
let mapleader      = ' '
let maplocalleader = ' '

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin()
" call plug#begin('~/.vim/plugged')

    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'vim-airline/vim-airline'
    Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" Enable 256 colors in vim
set t_Co=256

set foldmethod=marker  " Markers used to specify folds
set autoindent         " Copy indent from current line on new line
set number             " Add line numbers
set shiftwidth=4       " Set shift width to 4 spaces
set tabstop=4          " Set tab width to 4 columns
set expandtab          " Use space character instead of tabs
set nobackup           " Do not save backup files
set scrolloff=50       " Do not let cursor scroll below or above N lines
set nowrap             " Do not wrap lines
set incsearch          " Incrementally highlight characters while searching
set ignorecase         " Ignore capital letters during search
set smartcase          " Override ignorecase specifically for capital letters
set showcmd            " show partial command typed
" set showmode           " show mode on last line
set noshowmode         " remove mode from last line
set showmatch          " show matching words during search
set hlsearch           " highlight when searching
set history=10000      " Set commands to save in history
set colorcolumn=80     " Show colorcolumn
set cursorline         " Show cursorline

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
autocmd VimEnter * if !argc() | Explore | endif
" open if specified argument is a directory
autocmd VimEnter * if isdirectory(expand('<afile>')) | Explore | endif

" ctags
set tags=./tags;/

" mouse
silent! set ttymouse=xterm2
set mouse=a

" ----------------------------------------------------------------------------
" STATUS LINE
" ----------------------------------------------------------------------------

" " Clear status line when vimrc is reloaded.
" set statusline=
" " Status line left side.
" set statusline+=\ %F\ %M\ %Y\ %R
" " Use a divider to separate the left from the right side.
" set statusline+=%=
" " Status line right side.
" set statusline+=\ %{LinterStatus()}\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" " set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" " Show the status on the second to last line.
" set laststatus=2

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
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

" Search results in middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv

" vv visual mode highlight line
nnoremap vv 0v$

" Clear search
nnoremap <C-l> :nohl<CR><C-l>
" Toggle line numbers
nnoremap <C-c> :set norelativenumber!<CR>:set nonumber!<CR>

" Open file under cursor in a new tab
nnoremap <leader>t :tabe **/<cfile><CR> :tabp<CR>

" This will use relative hybrid numbers in normal mode.
" Absolute numbers in insert or when not in focus.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript setlocal sw=4 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

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

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" }}}
" ============================================================================
" PLUGIN SPECIFIC SETTINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
"                    |\                          ,,
"                     \\          _              ||   _
"                    / \\ ,._-_  < \,  _-_ \\ \\ ||  < \,
"                   || ||  ||    /-|| ||   || || ||  /-||
"                   || ||  ||   (( || ||   || || || (( ||
"                    \\/   \\,   \/\\ \\,/ \\/\\ \\  \/\\
" ----------------------------------------------------------------------------

let g:airline_theme='dracula'
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

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

let g:ale_linters = {'javascript': ['eslint'], 'python': ['pylint'], 'HTML': ['prettier']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'HTML':
       \['prettier'], 'javascript': ['prettier', 'eslint'], 'python': ['autoflake',
       \'autopep8', 'autoimport']
       \}
" Lint status on status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

let g:ale_fix_on_save = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lsp_suggestions = 1
let g:ale_set_highlights = 1
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" }}}
" ============================================================================