set number            " Show line numbers
set relativenumber    " Enable relative numbering of lines

set list              " Show whitespace
set wrap              " Wrap lines (only changes how text is displayed)
set showbreak=>\      " Wrapped line prefix
set textwidth=80      " Wrap lines at this column when inserting text
set formatoptions-=t  " ...but do not wrap non-comment lines automatically
" set colorcolumn=+1    " Show a vertical line at column textwidth+1

set incsearch         " Searches for strings incrementally
set hlsearch          " Highlight all search results
set ignorecase        " Search is case-insensitive...
set smartcase         " ...unless at least one upper-case char is typed

set autoindent        " Auto-indent new lines
set shiftwidth=2      " Number of auto-indent spaces
set smartindent       " Enable smart-indent
set tabstop=2         " Number of spaces that <Tab> counts for
set smarttab          " Enable smart-tabs
set softtabstop=-1    " Number of spaces per tab (-1 to use the value of shiftwidth)
set expandtab         " Replace tabs with spaces

set ruler             " Show row and column ruler information
set showmatch         " Highlight matching brace
set undolevels=1000             " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour
set laststatus=2      " Always show statusline

" Splits
set splitbelow        " Open a horizontal split below the current one
set splitright        " Open a verticat split to the right of the current one

" Remap splits navigation to CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map split resizing to CTRL + arrows
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Change splits from horizontal to vertical and vice versa
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Remove pipes that act as separators between vertical splits
" set fillchars+=vert:\

if !exists("g:syntax_on")
  syntax enable       " Enable syntax highlighting if not already on
endif

if (has("termguicolors"))
  set termguicolors   " Enable 24-bit RGB color if supported
endif

" set gdefault          " Substitutions are automatically global
" set shortmess         " Avoid hit-enter prompts and some other messages

" Associate Jenkinsfiles with Groovy syntax highlighter
augroup set_jenkins_groovy
  au!
  au BufNewFile,BufRead *.jenkinsfile,Jenkinsfile setf groovy
augroup END

" junegunn/vim-plug plugin manager section
  " :PlugInstall    install plugins
  " :PlugUpdate     install or update plugins
  " :PlugClean      remove unlisted plugins
  " :PlugUpgrade    upgrade vim-plug itself
  " :PlugStatus     check the status of plugins
  " :PlugDiff       compare pending changes to a previous update

  call plug#begin(stdpath('data') . '/plugged')
  Plug 'tpope/vim-sensible'                 " sensible defaults
  Plug 'tpope/vim-surround'                 " improved quoting/parenthesizing
  Plug 'tpope/vim-fugitive'                 " git integration
  Plug 'vim-scripts/ReplaceWithRegister'    " replace text with contents of register
  Plug 'roman/golden-ratio'                 " auto resize windows
  Plug 'mcchrish/nnn.vim'                   " nnn plugin, open with :Np
  Plug 'vim-airline/vim-airline'            " statusline
  Plug 'vim-airline/vim-airline-themes'     " statusline themes
  Plug 'haishanh/night-owl.vim'             " night-owl color theme
  call plug#end()

" vim-airline settings:
  " With vim-airline the mode info is no longer necessary:
  set noshowmode

  " Theme
  let g:airline_theme='night_owl'

  " Automatically display all buffers when there is only one tab open
  let g:airline#extensions#tabline#enabled = 1

  " Path formatter - affects how file paths are displayed
  let g:airline#extensions#tabline#formatter = 'default'

  " Automatically populate g:airline_symbols dictionary with powerline
  " symbols (not sure if this does anything)
  let g:airline_powerline_fonts = 1

" nnn.vim settings:
  " Floating window
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug', 'border': 'sharp' } }

" night-owl.vim enable theme (do not throw an error if theme not found):
  silent! colorscheme night-owl
