" taskpaper.vim
" map carriage return to create new todo entry
autocmd filetype taskpaper :nnoremap <buffer> <C-m> o- 
autocmd filetype taskpaper :inoremap <buffer> <C-m> <ESC>o- 

nmap <Space>b :ls<CR>:buffer
nmap <Space>f :edit .<CR>
nmap <Space>v :vsplit<CR><C-w><C-w>:ls<CR>:buffer
nmap <Space>V :Vexplore!<CR><CR>  

map tt :tabnew<Space>
map tn :tabnext<CR>
map tp :tabprevious<CR>
map tc :tabclose<CR>
map tb :tabnew<CR>:ls<CR>:buffer

"nmap <unique> <silent> <Leader>ub \
"  :<C-u>Unite \
"    script:perl:~/.vim/bundle/unite-script/examples/bookmarks.pl<CR>
"nmap <unique> <silent> <Leader>it \
"  :<C-u>Unite \
"    script:perl:~/.vim/bundle/unite-script/examples/itunes.pl<CR>
