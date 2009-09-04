"tab関係
set showtabline=2
set tabstop=2
set softtabstop=2

"status line
set statusline='%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]'

"for vim-latex
filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
" compile with platex
let g:Tex_CompileRule_dvi = 'platex --interactuion=nonstopmode $*'
" view dvi file 
let g:Tex_ViewRule_dvi = 'dviout'
" make pdf file
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
let g:Tex_DefaultTargetFormat='dvi'
let g:Tex_ViewRule_pdf='AcroRd32'

"set swap file directory
:set dir=~/temp

augroup LatexSuite
				au LatexSuite User LatexSuiteFileType
																\ imap <silent> <buffer> -- <Plug>Tex_FastEnvironmentInsert
augroup END

" skk.vim
let skk_large_jisyo = "/usr/share/skk/SKK-JISYO.L"
let skk_keep_state = 1
let skk_kutouten_type = "en"

"clopboard
set clipboard=unnamed

" 文字コードの自動認識{{{
if &encoding !=# 'utf-8'
				set encoding=japan
				set fileencoding=japan
endif
if has('iconv')
				let s:enc_euc = 'euc-jp'
				let s:enc_jis = 'iso-2022-jp'
				" iconvがeucJP-msに対応しているかをチェック
				if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
								let s:enc_euc = 'eucjp-ms'
								let s:enc_jis = 'iso-2022-jp-3'
								" iconvがJISX0213に対応しているかをチェック
				elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
								let s:enc_euc = 'euc-jisx0213'
								let s:enc_jis = 'iso-2022-jp-3'
				endif
				" fileencodingsを構築
				if &encoding ==# 'utf-8'
								let s:fileencodings_default = &fileencodings
								let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
								let &fileencodings = &fileencodings .','. s:fileencodings_default
								unlet s:fileencodings_default
				else
								let &fileencodings = &fileencodings .','. s:enc_jis
								set fileencodings+=utf-8,ucs-2le,ucs-2
								if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
												set fileencodings+=cp932
												set fileencodings-=euc-jp
												set fileencodings-=euc-jisx0213
												set fileencodings-=eucjp-ms
												let &encoding = s:enc_euc
												let &fileencoding = s:enc_euc
								else
												let &fileencodings = &fileencodings .','. s:enc_euc
								endif
				endif
				" 定数を処分
				unlet s:enc_euc
				unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
				function! AU_ReCheck_FENC()
								if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
												let &fileencoding=&encoding
								endif
				endfunction
				autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 文字コードの自動認識}}}

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
				set ambiwidth=double
endif


