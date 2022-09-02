" OLD vim script file, now I use a init.lua file

" Dangerously execute vimrc in a project
" set exrc
" set secure
"let &t_ut=''

set number
set relativenumber

" Disable highlight in search
set nohlsearch
" Allow to recovery the file easily once you closed vim
set hidden
" Obvious
set noerrorbells

" Tab config
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Keeping history, work with undo tree plugin
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Highligh as you search
set incsearch

set scrolloff=8

" Add left margin column to allow git integration
set signcolumn=yes

filetype plugin indent on

" To find files
"set path+=**
set wildmenu

" To be able to more easily copy into system clipboard
" See https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
noremap Y "+y

map <C-p> <cmd>Telescope find_files<cr>

let mapleader = " " " map leader to comma

nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>

let g:at_custom_alternates = {'===': '!==', 'yes':'no'}
noremap <leader>ta :ToggleAlternate<CR>


nnoremap <Leader>g 

" Hide search result
map <Leader>h :noh<CR>

"map <C-n> :NERDTreeToggle<CR>
map <leader>t :NERDTreeToggle<CR>

" Prevent vim to clear the system clipboard on leave
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cnoremap w!! execute 'silent! write !SUDO_ASKPASS=`which ssh-askpass` sudo tee % >/dev/null' <bar> edit!

" Go back to the last viewed buffer
nmap <leader>bb <c-^><cr>

" Go to the first non-whitespace char of a line : use ^

" Plugin management with vim plug
call plug#begin()
    " Theme
    "Plug 'gruvbox-community/gruvbox'    
    "Plug 'chriskempson/base16-vim'
    "Plug 'sainnhe/everforest'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'bling/vim-airline'
    Plug 'mattn/emmet-vim'
	Plug 'preservim/nerdtree'

    " Tree sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " languages
	Plug 'lervag/vimtex'

	" telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " tools
    " align texts by a value
    " note: would be much nicer if that would understand language specific rule
	Plug 'godlygeek/tabular'

    " auto completion for parenthesis, quotes...
	Plug 'Raimondi/delimitMate'

    Plug 'tomtom/tcomment_vim'

    " plugin to toggle boolean values
    Plug 'rmagatti/alternate-toggler'

    " plugin to implement the editorconfig specification (format rules for each project)
    Plug 'editorconfig/editorconfig-vim'

    " for git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " formatting
    " Plug 'sbdchd/neoformat'
    Plug 'vim-autoformat/vim-autoformat'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'lumiliet/vim-twig'
call plug#end()

if has('termguicolors')
    set termguicolors
endif
set background=dark
"let g:everforest_background = 'hard'
"let g:everforest_better_performance = 1
colorscheme moonfly

"let base16colorspace=256
"set termguicolors
"highlight Normal guibg=None


