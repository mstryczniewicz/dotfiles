set number            " Show line numbers
set relativenumber    " Enable relative numbering of lines

set list              " Show whitespace
set wrap              " Wrap lines (only changes how text is displayed)
set showbreak=>\      " Wrapped line prefix
set textwidth=80      " Wrap lines at this column when inserting text
set formatoptions-=t  " Do not wrap non-comment lines automatically
" set colorcolumn=+1    " Show a vertical line at column textwidth+1

set incsearch         " Searches for strings incrementally
set hlsearch          " Highlight all search results
set ignorecase        " Search is case-insensitive...
set smartcase         " ...unless at least one upper-case char is typed

" set gdefault          " Substitutions are automatically global
" set shortmess         " Avoid hit-enter propmts and some other messages

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

"" Generated by VimConfig.com

"" Enable powerline plugin (https://github.com/powerline/powerline)
"" set rtp+=/usr/lib/python3.8/site-packages/powerline/bindings/vim/

set laststatus=2    " Always show statusline

if (has("termguicolors"))
  set termguicolors   " Enables 24-bit RGB color
endif
