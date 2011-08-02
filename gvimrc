" disable toolbar
set guioptions -=T

" transparency
if has('kaoriya')
	set transparency=20
endif

set clipboard=unnamed

" http://vim-users.jp/2011/06/hack221/
function! s:relative_tranparency(diff)
  let &transparency = a:diff + &transparency
  let g:transparency = &transparency
endfunction
nnoremap <up> :<C-u>call <SID>relative_tranparency(5)<Cr>
inoremap <up> <C-o>:call <SID>relative_tranparency(5)<Cr>
nnoremap <down> :<C-u>call <SID>relative_tranparency(-5)<Cr>
inoremap <down> <C-o>:call <SID>relative_tranparency(-5)<Cr>
nnoremap <Esc><Esc> :<C-u>let &transparency = g:transparency<Cr><C-l>

