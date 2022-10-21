" ============================================================================
"
"                  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"                  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"                  ██║   ██║██║██╔████╔██║██████╔╝██║
"                  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                   ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                    ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
" ============================================================================
" VIM {{{
" ============================================================================

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim
" Disable compatibility with VI
set nocompatible

let mapleader      = ' '
let maplocalleader = ' '

silent! set ttymouse=xterm2
set mouse=a

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin()

" Themes
    Plug 'altercation/vim-colors-solarized'
        let g:solarized_termcolors=256
    Plug 'noahfrederick/vim-noctu'
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
        let g:dracula_inverse = 0
        let g:dracula_italic = 0
        let g:dracula_full_special_attrs_support = 1
        let g:dracula_colorterm = 0

" LSP
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        let g:UltiSnipsExpandTrigger = "<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<C-j>"
        let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" Status
    Plug 'vim-airline/vim-airline'
        let g:airline_extensions = ['fzf', 'tagbar', 'branch',
          \ 'fugitiveline', 'obsession']

" Browsing
    Plug 'preservim/tagbar' | Plug 'preservim/nerdtree'
        nmap <F8> :TagbarToggle<CR>
        nmap <F7> :NERDTreeToggle<CR>

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |  Plug 'junegunn/fzf.vim'
        let $FZF_DEFAULT_COMMAND = 'rg -l ""' " use ripgrep to search
        map <C-p> :Files<CR>
        map <Leader><Leader> :Commands<CR>
        map <Leader>b :Buffers<CR>
        map <Leader>h :Helptags<CR>
        map <Leader>/ :execute 'Rg ' . input('Rg/')<CR>
        map <Leader>l :BLines<CR>
        map <Leader>gf :GF?<CR>
        command! -bang -nargs=* RgExact
          \ call fzf#vim#grep(
          \   'rg -F --column --line-number --no-heading --color=always --smart-case
          \   -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
        nmap <Leader>G :execute 'RgExact ' . expand('<cword>') <Cr>

" Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
        nmap <F5> <Plug>MarkdownPreviewToggle
        let g:mkdp_theme = 'light'


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
        nmap <F6> :Goyo<CR>

    Plug 'junegunn/limelight.vim'
        let g:limelight_conceal_ctermfg = 240

" Edit
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

" Session
    Plug 'tpope/vim-obsession'

" Git
    Plug 'tpope/vim-fugitive'

" Gutter
    Plug 'airblade/vim-gitgutter' | Plug 'kshenoy/vim-signature'

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

call plug#end()
endif

" }}}
" ============================================================================
" LUA CONFIG {{{
" ============================================================================

lua <<EOF
-- your lua configs here, e.g.
  require'lspconfig'.pyright.setup{}

-- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

  -- Setup nvim-treesitter.
  require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "markdown", "python", "vim", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set background=dark
colorscheme dracula

filetype on                           " Enable file type detection
filetype plugin on                    " Enable plugins for detected file type
filetype indent on                    " Load an indent file for the file type
syntax on                             " Syntax highlighting on

set spell spelllang=en_us             " Spellcheck
set t_Co=256                          " Enable 256 colors in vim
set lazyredraw                        " Stops refresh during complex operations
set foldmethod=marker                 " Markers used to specify folds
set autoindent                        " Copy indent from current line on new
set smartindent                       " Smart autoindent on new line
set number                            " Add line numbers
set shiftwidth=4                      " Set shift width to 4 spaces
set tabstop=4                         " Set tab width to 4 columns
set expandtab                         " Use space character instead of tabs
set nobackup                          " Do not save backup files
set scrolloff=50                      " Do not let cursor scroll past N lines
set nowrap                            " Do not wrap lines
set incsearch                         " Incrementally highlight search
set ignorecase                        " Ignore capital letters during search
set smartcase                         " Override ignorecase for capital letters
set showcmd                           " Show partial command typed
set noshowmode                        " Remove mode from last line
set showmatch                         " Show matching words during search
set hlsearch                          " Highlight when searching
set history=10000                     " Set commands to save in history
set colorcolumn=80                    " Show colorcolumn
set cursorline                        " Show cursorline
set switchbuf=useopen                 " Use open buffer if one exists
set autoread                          " Reload files when they change on disk
set omnifunc=syntaxcomplete#Complete  " Autocomplete
set completeopt=menu,menuone,noselect

" Wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Netrw
let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'

" Open Explore if specified argument is a directory
autocmd VimEnter * if isdirectory(expand('<afile>')) | Explore | endif

" Ctags
set tags=./tags;/

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
nnoremap <silent> <leader>c :let @/=""<CR>
" Toggle line numbers
nnoremap <C-n> :set norelativenumber!<CR>:set nonumber!<CR>
" Relative numbers in normal mode, Absolute in insert
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
" This allows you to undo changes even after saving
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif
" Quickly edit dotfiles
map <silent> <leader>so :source $MYVIMRC<CR>
map <leader>ev :edit ~/.config/dotfiles/vimrc<CR>
map <leader>et :edit ~/.config/dotfiles/tmux.conf<CR>
map <leader>ez :edit ~/.config/dotfiles/zshrc<CR>
map <leader>df :edit ~/.config/dotfiles/<CR>
map <leader>en :edit ~/.config/nvim/init.vim<CR>

" Quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
" Tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Show syntax under cursor
nmap <C-m> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" File specific abbreviations (snippets)
:autocmd FileType python     :iabbrev <buffer> iff if:<left>
:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

" }}}
" ============================================================================
