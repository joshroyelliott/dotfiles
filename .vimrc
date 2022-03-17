"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" SETTINGS ----------------------------------------------------------------{{{

" Disable compatibility with VI
set nocompatible

" Enable file type detection
filetype on
" Enable plugins for detected file type
filetype plugin on
" Load an indent file for the file type
filetype indent on
" Syntax highlighting on
syntax on

set autoindent
" Add line numbers
set number
" Set shift width to 4 spaces
set shiftwidth=4
" Set tab width to 4 columns
set tabstop=4
" Use space character instead of tabs
set expandtab

" Do not save backup files
set nobackup
" Do not let cursor scroll below or above N lines while scrolling
set scrolloff=10
" Do not wrap lines
set nowrap

" Incrementally highlight characters while searching
set incsearch
" Ignore capital letters during search
set ignorecase
" Override ignorecase specifically for capital letters
set smartcase
" show partial command typed
set showcmd

" show mode on last line
set showmode
" show matching words during search
set showmatch
" highlight when searching
set hlsearch
" Set commands to save in history
set history=1000

" Spellcheck
set spell spelllang=en_us

" Enable autocompletion after pressing tab
set wildmenu
" Make wildmenu behave like Bash completion
set wildmode=list:longest
" Ignore files not to be edited with Vim
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" use folds on triple curly braces
set foldmethod=marker

" }}}

" MAPPINGS ----------------------------------------------------------------{{{

" Set leader key to comma
let mapleader = ","
nnoremap <leader>, ``

" Search results in middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv

" vv visual mode highlight line
nnoremap vv 0v$

" Clear search
nnoremap <C-l> :nohl<CR><C-l>
" Toggle line numbers
nnoremap <C-c> :set norelativenumber!<CR>:set nonumber!<CR>

" }}}

" VIMSCRIPT ---------------------------------------------------------------{{{

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

" More Vimscripts code goes here.

" }}}

" PLUGINS -----------------------------------------------------------------{{{

call plug#begin('~/.vim/plugged')
    
    Plug 'dense-analysis/ale'
    Plug 'preservim/nerdtree'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'junegunn/fzf'
    Plug 'tpope/vim-surround'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-commentary'

call plug#end()

colorscheme dracula
set background=dark    

" }}}

" PLUGIN SETTINGS -----------------------------------------------------------------{{{

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>
" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}

" STATUS LINE -------------------------------------------------------------{{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}
