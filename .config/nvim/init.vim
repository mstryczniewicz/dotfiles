" junegunn/vim-plug plugin manager section
  " :PlugInstall    install plugins
  " :PlugUpdate     install or update plugins
  " :PlugClean      remove unlisted plugins
  " :PlugUpgrade    upgrade vim-plug itself
  " :PlugStatus     check the status of plugins
  " :PlugDiff       compare pending changes to a previous update

  call plug#begin(stdpath('data') . '/plugged')
  Plug 'tpope/vim-sensible'                 " sensible defaults
  Plug 'tpope/vim-fugitive'                 " plugin for git integration
  Plug 'vim-airline/vim-airline'            " statusline
  Plug 'vim-airline/vim-airline-themes'     " statusline themes
  Plug 'roman/golden-ratio'                 " auto resize windows
  Plug 'mcchrish/nnn.vim'                   " nnn plugin, open with :Np
  call plug#end()

" vim-airline settings:
  " With vim-airline the mode info is no longer necessary:
  set noshowmode

  " Theme
  "let g:airline_theme='powerlineish'
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

source ~/.vimrc
