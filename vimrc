set nocompatible
filetype off

nnoremap <Space>s.
      \  :<C-u>source $MYVIMRC<CR>

set runtimepath& runtimepath+=~/.vim/bundle/vundle/
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
" Bundle 'motemen/git-vim' 
Bundle 'tyru/open-browser.vim.git'
Bundle 'basyura/unite-hiki'

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

" git-vim
let g:git_no_map_default = 1
let g:git_command_edit = 'rightbelow vnew'
nnoremap <Space>gd :<C-u>GitDiff --cached<Enter>
nnoremap <Space>gD :<C-u>GitDiff<Enter>
nnoremap <Space>gs :<C-u>GitStatus<Enter>
nnoremap <Space>gl :<C-u>GitLog<Enter>
nnoremap <Space>gL :<C-u>GitLog -u \| head -10000<Enter>
nnoremap <Space>ga :<C-u>GitAdd<Enter>
nnoremap <Space>gA :<C-u>GitAdd <cfile><Enter>
nnoremap <Space>gc :<C-u>GitCommit<Enter>
nnoremap <Space>gC :<C-u>GitCommit --amend<Enter>
nnoremap <Space>gp :<C-u>Git push

""" unite.vim
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
augroup UniteAu
  autocmd!
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
  autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
augroup END

"unite-hiki
let g:unite_hiki_user     = 'koga'
let g:unite_hiki_password = 'cb400sf'
let g:unite_hiki_server   = 'http://whale/'

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

if (winwidth(0) < 130)
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %t%=%{fugitive#statusline()}\ \ %1l/%L,%c%V\ \ %P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%{fugitive#statusline()}\ \ %1l/%L,%c%V\ \ %P
end

if has('gui')
  source ~/.gvimrc
end
