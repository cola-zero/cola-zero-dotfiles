set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'hakobe/unite-script'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'tpope/vim-fugitive'
" Bundle 'VimOrganizer'
Bundle 'davidoc/taskpaper.vim'
Bundle 'jceb/vim-orgmode'

filetype plugin indent on " required!

"rsense
if has('mac')
  let g:rsenseHome = "/Users/masahirokoga/opt/rsense-0.3"
endif

" IM
if has('mac')
  set noimdisableactivate
endif

source ~/.vim/config/neocomplcacherc.vim
source ~/.vim/config/maprc.vim

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
