" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
 endif

call plug#begin('~/.config/nvim/autoload/plugged')

  " Theme plugin
  Plug 'morhetz/gruvbox'

  " Autocomplete!
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Key explanation like emacs
  Plug 'liuchengxu/vim-which-key'

  " Start Screen
  Plug 'mhinz/vim-startify'

  " Text Navigation
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'

  " Fancy status line
  Plug 'vim-airline/vim-airline'

  " Multiple cursors like Sublime
  Plug 'terryma/vim-multiple-cursors'

  " Floating terminal tools
  Plug 'voldikss/vim-floaterm'
  
  " Nice file explorer
  " Plug 'preservim/nerdtree'

  " Background colors for hex codes n' stuff
  Plug 'norcalli/nvim-colorizer.lua'

  " Parentheses matching goodness
  Plug 'kien/rainbow_parentheses.vim'

  " Buffers as tabs for visual aids - still a noob
  Plug 'ap/vim-buftabline'

  " Fuzzy finding
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Better syntax highlighting for pretty much every language
  Plug 'sheerun/vim-polyglot'

  " Auto close pairs such as [], (), ``
  Plug 'jiangmiao/auto-pairs'
  " Close HTML tags
  Plug 'alvan/vim-closetag'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

