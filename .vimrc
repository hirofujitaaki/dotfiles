filetype off

""""""plug-ins""""""""
" dein settings {{{
if &compatible
  set nocompatible
endif
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " installing plugins for markdowns
  call dein#add('kannokanno/previm')
  call dein#add('tyru/open-browser.vim')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('derekwyatt/vim-scala')

  " uninstalling plugins
  " call map(dein#check_clean(), "delete(v:val, 'rf')")

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" Required:
filetype plugin indent on


"""""""""Options"""""""""""""
" "0"で始まる数値を、8進数として扱わないようにする
set nrformats-=octal
" 文脈によって解釈が異なる全角文字の幅を、2に固定する
set ambiwidth=double
" 可視化した空白文字の表示形式
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" スワップファイルは使わない
set noswapfile
" カーソルの位置表示
set ruler
" コマンドラインに使われる画面上の行数
set cmdheight=2
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ステータス行に表示させる情報の指定
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P\ %{ObsessionStatus()}\ %{fugitive#statusline()}
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" タブ入力を複数の空白入力に置き換える
set expandtab
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=4
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" Colorscheme
set background=light
silent! colorscheme default
" 構文毎に文字色を変化させる
syntax on
"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang+=cjk
set nospell
" 行番号の色
highlight LineNr ctermfg=grey
" default appearance for netrw
let g:netrw_liststyle=3
"backspaceの正常化
set backspace=indent,eol,start
"クリップボードの正常化
set clipboard=unnamed
set clipboard+=autoselect
" autocomplete list
set complete=.,w,b,u,t,i
" include '-' as a word
set isk+=-
" ctrl + p (history)
set history=1000
" コマンドライン自動補完
set wildmode=longest:full,full
" Maxium numbers to yank
set viminfo='100,<500,s100,h
" supported extensions by gf command
set suffixesadd+=.html
" disable lighliting parentheses
" let g:loaded_matchparen= 1
" set default path for :find command
set path+=$PWD/app/**
" set types of increase and decrease
:set nrformats+=alpha,octal
" set encoding
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set fileformats=unix,dos,mac

"""""""Key Mappings"""""""""
" edit  ~/.vimrc
nnoremap <leader>vm :e $MYVIMRC<cr>
" read ~/.vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Yank file name/path
nmap cp :let @+ = expand("%")
" Command Line History
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" :hlsearch off
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Excute ruby/python/scala files from vim
autocmd BufNewFile,BufRead *.rb nnoremap <C-e> :!ruby %
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %
autocmd BufNewFile,BufRead *.scala nnoremap <C-e> :!scala %
autocmd BufNewFile,BufRead *.js nnoremap <C-e> :!node %
" for open-browser
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
command! OpenBrowserCurrent execute "OpenBrowser" expand("%:p")
" avoiding real lines when moving the cursor
noremap j gj
noremap k gk
" delete an extra space in insert mode
imap <C-d> <C-[>ldf<space>i
" UltiSnips Trogger Configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"""""""""""""""""""""""""""""""
"Settings
"""""""""""""""""""""""""""""""
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

" コメントアウトの自動挿入オフ
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Avoid auto remove of indents
autocmd FileType python :inoremap # X#

" syntastic
let g:syntastic_mode_map = {
  \ "mode" : "active",
  \ "active_filetypes" : ["ruby", "python", "scala", "html", "scss", "css", "javascript", "json", "sh"],
  \}

let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_javascript_checker = ['jshint']
let g:syntastic_json_checker = ['jsonlint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_scala_checkers = ['fsc']
" linter for html disabled
let g:syntastic_html_checkers = ['']

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Django
autocmd FileType html set filetype=htmldjango.html

" ignore certain file types in netrw
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'

" set the background color of mkview OFF
hi Folded ctermbg=NONE

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"""""""""""""""""""""""""""""
" automate the process of mkview and loadview.
"""""""""""""""""""""""""""""
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


"""""""""""""""""""""""""""""
" JUMP_TO_NAVIGATE
""""""""""""""""""""""""""""
" \zs as delimiter to split string into indivisual characters
" need to use g:C_LETTERS, othrwise can't be restored.
let alphabet = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890', '\zs')
for first_key in alphabet
    for second_key in alphabet
        let g:PAIR = first_key . second_key
        execute "nnoremap ," . g:PAIR . " :<C-u>let " . g:PAIR . " = expand('%')<CR>"
        execute "nnoremap <leader>" . g:PAIR . " :execute 'edit '" . g:PAIR . "<cr>"
    endfor
endfor

""""""""""""""""""""""""
filetype on
