"-------基本設定--------
"タイトルをバッファ名に変更しない
set notitle
set shortmess+=I
"スワップファイル
set noswapfile

"ターミナル接続を高速にする
set ttyfast

"ターミナルで256色表示を使う
set t_Co=256

if has ("viminfo")
"フォールド設定(未使用)
"set foldmethod=indent
set foldmethod=manual
"set foldopen=all
"set foldclose=all
endif

"VIM互換にしない
set nocompatible

"複数ファイルの編集を可能にする
set hidden

"内容が変更されたら自動的に再読み込み
set autoread

"Swapを作るまでの時間m秒
set updatetime=0

"Unicodeで行末が変になる問題を解決
set ambiwidth=double

"行間をでシームレスに移動する
"set whichwrap+=h,l,<,>,[,],b,s

"カーソルを常に画面の中央に表示させる
"set scrolloff=999

"バックスペースキーで行頭を削除する
set backspace=indent,eol,start

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline

"C-X,C-Aを強制的に10進数認識させる
set nrformats=
"set nrformats=alpha

"titleを変更しない
set notitle

"コマンドラインでTABで補完できるようにする
set wildchar=<C-Z>

"改行後に「Backspace」キーを押すと上行末尾の文字を1文字消す
set backspace=2

"C-vの矩形選択で行末より後ろもカーソルを置ける
set virtualedit=block

"コマンド、検索パターンを50まで保存
set history=50

"履歴に保存する各種設定
set viminfo='100,/50,%,<1000,f50,s100,:100,c,h,!

"バックアップを作成しない
set nobackup

"-------Search--------
"インクリメンタルサーチを有効にする
set incsearch

"大文字小文字を区別しない
set ignorecase

"大文字で検索されたら対象を大文字限定にする
set smartcase

"行末まで検索したら行頭に戻る
set wrapscan

"-------Format--------
"自動インデントを有効化する
set smartindent
set autoindent

"フォーマット揃えをコメント以外有効にする
set formatoptions-=c

"括弧の対応をハイライト
set showmatch

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"ターミナル上からの張り付けを許可
"set paste

"http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
set tabstop=4
set shiftwidth=4
set softtabstop=0
"set expandtab

"-------Look&Feel-----
"TAB,EOFなどを可視化する
set list
"set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:>-,extends:<,trail:-

"検索結果をハイライトする
set hlsearch

"ルーラー,行番号を表示
set ruler
set number

"コマンドラインの高さ
set cmdheight=1

"マクロなどの途中経過を描写しない
set lazyredraw

"カーソルラインを表示する
"set cursorline

"ウインドウタイトルを設定する
set title

"modelineを有効にする
set modeline

"自動文字数カウント
augroup WordCount
    autocmd!
    autocmd BufWinEnter,InsertLeave,CursorHold * call WordCount('char')
augroup END
let s:WordCountStr = ''
let s:WordCountDict = {'word': 2, 'char': 3, 'byte': 4}
function! WordCount(...)
    if a:0 == 0
        return s:WordCountStr
    endif
    let cidx = 3
    silent! let cidx = s:WordCountDict[a:1]
    let s:WordCountStr = ''
    let s:saved_status = v:statusmsg
    exec "silent normal! g\<c-g>"
    if v:statusmsg !~ '^--'
        let str = ''
        silent! let str = split(v:statusmsg, ';')[cidx]
        let cur = str2nr(matchstr(str, '\d\+'))
        let end = str2nr(matchstr(str, '\d\+\s*$'))
        if a:1 == 'char'
            " ここで(改行コード数*改行コードサイズ)を'g<C-g>'の文字数から引く
            let cr = &ff == 'dos' ? 2 : 1
            let cur -= cr * (line('.') - 1)
            let end -= cr * line('$')
        endif
        let s:WordCountStr = printf('%d/%d', cur, end)
    endif
    let v:statusmsg = s:saved_status
    return s:WordCountStr
endfunction

"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
"ここからツールバー右側
set statusline+=%=
"skk.vimの状態
"set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
"文字バイト数/カラム番号
set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
"現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]
"現在文字行/全体行表示
set statusline+=[L=%l/%L]
"現在のファイルの文字数をカウント
set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
"現在行が全体行の何%か表示
set statusline+=[%p%%]
"レジスタの中身を表示
"set statusline+=[RG=\"%{getreg()}\"]

"-------エンコード------
"エンコード設定
if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencoding=utf-8
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
    set termencoding=
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencoding=utf-8
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=
endif

"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"-------キー設定-------
"矢印キーでは表示行単位で行移動する
nmap <UP> gk
nmap <DOWN> gj
vmap <UP> gk
vmap <DOWN> gj

"他のvimにviminfoを送る
"http://nanasi.jp/articles/howto/editing/rviminfo.html
nmap ,vw :vw<CR>
nmap ,vr :vr<CR>

"ZZは強制的に書き込む
map ZZ :wq!<CR>

"C-Lでawkを呼び出す
nmap <C-C><C-L> :w !awk 'BEGIN{n=0}{n+=$1}END{print n}'

"C-P,C-Nでバッファ移動,C-Dでバッファ消去
nmap <C-P> :bp<CR>
nmap <C-N> :bn<CR>
nmap <C-D> :bd<CR>

"C-Nで新しいバッファを開く
nmap <C-C><C-N> :new<CR>

"C-L,C-Lでバッファリスト
nmap <C-L><C-L> :ls<CR>
"C-L,C-Rでレジスタリスト
nmap <C-L><C-R> :dis<CR>
"C-L,C-Kでキーマップリスト
nmap <C-L><C-K> :map<CR>
"C-L,C-Mでマークリスト
nmap <C-L><C-M> :marks<CR>
"C-L,C-Jでジャンプリスト
nmap <C-L><C-J> :jumps<CR>
"C-L,C-Hでコマンドヒストリ
nmap <C-L><C-H> :his<CR>
"C-L,C-Uでアンドゥヒストリ
nmap <C-L><C-U> :undolist<CR>

"C-W,sで横分割
nmap <C-W>s :sp<CR>
"C-W,vで縦分割
nmap <C-W>v :vsp<CR>

"C-W,oでファイルを指定して横分割、オープン
nmap <C-W>o :sp
"C-W,Oでファイルを指定して縦分割、オープン
nmap <C-W>O :vp

"C-W,好みの方向キーで新しくバッファを開く
nmap <C-W><C-h> :vne<cr>
nmap <c-w><c-j> :bel new<cr>
nmap <c-w><c-k> :new<cr>
nmap <c-w><c-l> :rightb vnew<cr>

"C-W,eでファイルブラウザを横分割起動
nmap <C-W>e :vsp<CR>:wincmd w<CR>:e! ./<CR>
"C-W,Eでファイルブラウザを縦分割起動
nmap <C-W>E :sp<CR>:wincmd w<CR>:e! ./<CR>

"C-W,C-Aで現在のウインドウのみの表示
nmap <C-W><C-A> :all<CR>

"C-C,C-Rでカーソル語の置き換え
nmap <C-C><C-R> yw:%s:<C-R>0::g<LEFT><LEFT>
"C-C,rでYankした文字列との置き換え
nmap <C-C>r :%s:<C-R>0::g<LEFT><LEFT>
"C-C,gでカーソル語が存在する行の削除
nmap <C-C>g yw:g:<C-R>0:d
"C-C,Gでカーソル語が存在する行以外の削除
nmap <C-C>G yw:v:<C-R>0:d
",celで空白行の削除
nmap ,cel :%s:^$\n:<CR>
",cclでコメント行の削除
nmap ,ccl :%s:^\("\\|#\\\|\*\).*$\n:<CR>
",cdで現在編集中のファイルのあるディレクトリに変更
nmap ,cd :cd %:h<CR>

"コマンドモード時にカーソル移動するのに便利
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Delete>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

"<ESC>二回ででハイライトをOFFにする
nmap <ESC><ESC> :noh<CR>

"Insertmodeで<C-C>でESCと同義
inoremap <C-C> <ESC>

"<S+TAB>でexpandtabをトグル
function Tab_switch()
    if &expandtab =='1'
        set noexpandtab
    else
        set expandtab
    endif
endfunction
nmap <S-TAB> :call Tab_switch()<CR>

"<ESC>wでnowrapをトグル
function Wrap_switch()
    if &wrap =='1'
        set nowrap
    else
        set wrap
    endif
endfunction
nmap <ESC>w :call Wrap_switch()<CR>

"-------MENU-------
"SSHを通してファイルオープン
menu User.Open.SCP.NonSprit :e! scp:///<LEFT>
menu User.Open.SCP.VSprit :vsp<CR>:wincmd w<CR>:e! scp:///<LEFT>
menu User.Open.SCP.Sprit :sp<CR>:wincmd w<CR>:e! scp:///<LEFT>
"分割してファイルブラウザを起動
menu User.Open.Explolr.NonSprit :vsp<CR>:wincmd w<CR>:e! ./<CR>
menu User.Open.Explolr.VSprit :vsp<CR>:wincmd w<CR>:e! ./<CR>
menu User.Open.Explolr.Sprit :sp<CR>:wincmd w<CR>:e! ./<CR>
"各種VIMの記録情報を表示する
menu User.Buffur.RegisterList :dis<CR>
menu User.Buffur.BuffurList :ls<CR>
menu User.Buffur.HistoryList :his<CR>
menu User.Buffur.MarkList :marks<CR>
menu User.Buffur.JumpList :jumps<CR>
"エンコードを指定して再読み込み
menu User.Encode.reload.UTF :e ++enc=utf-8<CR>
menu User.Encode.reload.SJIS :e ++enc=cp932<CR>
menu User.Encode.reload.EUC :e ++enc=euc-jp<CR>
menu User.Encode.reload.ISO :e ++enc=iso-2022-jp<CR>
"保存エンコードを指定
menu User.Encode.convert.UTF :set fenc=utf-8<CR>
menu User.Encode.convert.SJIS :set fenc=cp932<CR>
menu User.Encode.convert.EUC :set fenc=euc-jp<CR>
menu User.Encode.convert.ISO :set fenc=iso-2022-jp<CR>
"フォーマットを指定して再読み込み
menu User.Format.Unix :e ++ff=unix<CR>
menu User.Format.Dos :e ++ff=dos<CR>
menu User.Format.Mac :e ++ff=mac<CR>
"行番号をファイルに挿入
menu User.Global.No :%!awk '{print NR, $0}'<CR>
"TABをSPACEに変換する
menu User.Global.Space :set expandtab<CR>:retab<CR>
"空白行を削除する
menu User.Global.Delete :g/^$/d<CR>
"カーソル上の単語を全体から検索し、別ウインドウで表示
menu User.Cursor.Serch.Show [I
menu User.Cursor.Serch.Top [i
menu User.Cursor.Serch.Junp [<tab>
"カーソル上のファイルのオープン
menu User.Cursor.FileOpen gf
"コピー、ペーストモード
menu User.Cursor.Paste :call Indent()<CR>
"全体置き換えモード
menu User.Cursor.Replace :%s/
"C-C,C-Rと同様
menu User.Cursor.Delete yw:%v:<C-R>0

"CUI時にメニューをMeta-lで表示する
set wildcharm=<TAB>
if has('gui')
    nmap <M-l> :emenu <TAB>
else
    nmap <ESC>l :emenu <TAB>
endif

"-------GUI--------
"ワイルドメニューを使う
set wildmenu
set wildmode=longest,list,full

"OSのクリップボードを使用する
set clipboard+=unnamed

"ターミナルでマウスを使用できるようにする
if has ("mouse")
    set mouse=a
    set guioptions+=a
    set ttymouse=xterm2
endif

if has('gui')
    "ツールバーを消す
    set guioptions=egLta
    "既に開いているGVIMがあるときはそのVIMを前面にもってくる
    runtime macros/editexisting.vim
    "gp gyで+レジスタに入出力
    nmap gd "+d
    nmap gy "+y
    nmap gp "+p
    nmap gP "+P
endif

"-------AutoCmd------
"if has('unix')
"   "CVSのコミットはSJISで行う
"   autocmd BufRead /tmp/cvs* :set fileencoding=cp932
"   "Muttから開いた編集はiso-2022-jpで行う
"   autocmd BufRead ~/.mutt/tmp/* :set fileencoding=utf-8
"   "w3mのフォームは改行コードDOSで編集
"   autocmd BufRead ~/.w3m/w3mtmp* :set fileformat=dos
"   "どのような言語でもペースト時自動インデントしない
"   "autocmd BufRead * :set paste
"endif

"<------VIM7以降--------
"Tab操作
if v:version >= 700
    "15までタブを開く
    set tabpagemax=15
    "タブラインを常に表示する
    "set showtabline=2
    if has('unix')
        nmap <ESC>t :tabnew<CR>
        nmap <ESC>e :tabnew ./<CR>
        nmap <ESC>n :tabn<CR>
        nmap <ESC>p :tabp<CR>
        nmap <ESC>o :tabo<CR>
        nmap <ESC>d :tabd
        if has('gui')
            nmap <M-t> :tabnew<CR>
            nmap <M-e> :tabnew ./<CR>
            nmap <M-n> :tabn<CR>
            nmap <M-p> :tabp<CR>
            nmap <M-o> :tabo<CR>
            nmap <M-d> :tabd
        endif
    elseif has('win32')
        nmap <M-t> :tabnew<CR>
        nmap <M-e> :tabnew ./<CR>
        nmap <M-n> :tabn<CR>
        nmap <M-p> :tabp<CR>
        nmap <M-o> :tabo<CR>
        nmap <M-d> :tabd
    endif
endif

"開いているバッファのディレクトリに移動
"if v:version >= 700
"   set autochdir
"endif

"Vimを終了しても undo 履歴を復元する
"http://vim-users.jp/2010/07/hack162/
"if has('persistent_undo')
"   set undodir=./.vimundo,~/.vimundo
"  set undofile
"endif

"Makeやgrepでcwindowを自動でひらくようにする
if v:version >= 700
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    autocmd QuickfixCmdPost l* lopen
    "M-gでGrepする
    if has('unix')
        nmap <Esc>g :vimgrep  %<LEFT><LEFT>
        nmap <Esc>f :cn<CR>
        nmap <Esc>b :cp<CR>
    elseif has('win32')
        nmap <M-g> :vimgrep  %<LEFT><LEFT>
        "M-P,Nで候補移動
        nmap <M-f> :cn<CR>
        nmap <M-b> :cp<CR>
    endif
endif

"-------VIM7以降------->

"-------VIM8以降------->
if v:version >= 800
    "絵文字を全角として扱う
    set emoji
    "ファイル末尾に <EOL> を必ずつける
    set fixendofline
    "ターミナルで GUI カラーを使う
    set termguicolors
endif
"<------VIM8以降--------

"カーソル位置を復元
"autocmd BufWinLeave ?* silent mkview
"autocmd BufWinEnter ?* silent loadview
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

"HEXエディタとしてvimを使う
if has('unix')
    augroup Binary
        au!
        au BufReadPre  *.bin let &bin=1
        au BufReadPost *.bin if &bin | silent %!xxd -g 1
        au BufReadPost *.bin set ft=xxd | endif
        au BufWritePre *.bin if &bin | %!xxd -r
        au BufWritePre *.bin endif
        au BufWritePost *.bin if &bin | silent %!xxd -g 1
        au BufWritePost *.bin set nomod | endif
    augroup END
endif


"C-C,C-Vでターミナルからコピーできる表示形式にする(関数使用)
if has('unix')
    function Indent_switch()
        if &nu =='1'
            set noai
            set nolist
            set nonu
            set paste
            set nocursorline
        else
            set ai
            set list
            set nu
            set nopaste
            set cursorline
        endif
    endfunction
    nmap <C-C><C-V> :call Indent_switch()<CR>
endif

",nnで絶対行に表示切り替え
if has('unix')
    function Relnum_switch()
        if &relativenumber =='1'
            set norelativenumber
        else
            set relativenumber
        endif
    endfunction
    nmap ,nn :call Relnum_switch()<CR>
endif

"SSH越しにファイルを編集する
if has('unix')
    function Scp_edit(svr)
        vsp
        wincmd w
        let sv = "e scp://" . a:svr . "/../"
        exec sv
    endfunction
    nmap ,ssh :call Scp_edit("")<LEFT><LEFT>
endif

"挿入モードで",date",',time'で日付、時刻挿入
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>

"sudoを忘れて権限のないファイルを編集した時\sudoで保存
nmap ,sudo :w !sudo tee %<CR>

"<C-C><C-d>で現在のバッファと保存前のファイルをdiffする
nmap <C-C><C-D> :w !diff -u % -<CR>

"<C-C><C-g>で現在のファイルをgit diffする
nmap <C-C><C-G> :!git diff --  %<CR>

"<C-C><C-D>でvimdiffを使用して現在のバッファと元ファイルを比較する
command DiffOrigcmp vert new | set bt=nofile | r # | -1d_ | diffthis | wincmd p | diffthis
nmap <C-C>d :DiffOrig<CR>

"未保存のbuffer同士の差分を取る
command Clone rightb vnew | put =getbufline('#',1,'$') | 1d_
command CloneDiff rightb vnew | put =getbufline('#',1,'$') | 1d_ | windo diffthis | wincmd w
nmap <C-C><C-B> :CloneDiff<CR>

"-----Windowsのみ有効------
if has('win32')
    "フォント設定
    set guifont=MS_Gothic:h9:cSHIFTJIS
    "パスのセパレータを変更(\->/)
    set shellslash
    "ウインドウポジション、サイズの設定
    winpos 9 6
    set lines=73
    set columns=110
    "スペースの入ったファイル名も扱えるようにする
    set isfname+=32
    "ファイル保存ダイアログの初期ディレクトリをバッファのあるディレクトリにする
    set browsedir=buffer
    "IME入力状態を規定にする(skkを使っているとき用)
    set iminsert=2
    set imsearch=0
    "起動時デスクトップに移動
    if isdirectory( $HOME . "/Desktop" )
        cd $HOME/Desktop
    elseif isdirectory( $HOME . "/デスクトップ" )
        cd $HOME/デスクトップ
    endif
endif

"-----Macのみ有効------
if has('gui_macvim')
    "ウインドウポジション、サイズの設定
    winpos 837 22
    set isfname+=32
    set lines=83
    set columns=167
    set guifont=Menlo\ Regular:h9
    set guifontwide=Menlo\ Regular:h9
    set linespace=2
    "set guifont=Ricty\ Regular\ for\ Powerline:h11
    "set guifontwide=Ricty\ Regular\ for\ Powerline:h11
    "set imdisable
    "set iminsert=2
    "set imsearch=0
endif

"拡張属性を自動付与
if has('mac')
    autocmd BufWritePost *.txt
        \ if &fenc=='utf-8' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'UTF-8;134217984' \"%\"" |
        \ elseif &fenc=='euc-jp' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'EUC-JP;2361' \"%\"" |
        \ elseif &fenc=='iso-2022-jp' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'ISO-2022-JP;2080' \"%\"" |
        \ elseif &fenc=='cp932' |
        \ exec "silent !xattr -w com.apple.TextEncoding 'SHIFT_JIS;2561' \"%\"" |
        \ endif
endif

"-------Plugin--------
"eskk.vim
if has('unix') && isdirectory($HOME . '/.vim/plugged/eskk.vim')
    let g:eskk#directory = "~/vim/skk"
    let g:eskk#dictionary = { 'path': "~/.vim/skk/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
    let g:eskk#large_dictionary = { 'path': "~/.vim/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'utf-8', }
endif

"eskk.vim
if has('unix') && isdirectory($HOME . '/.vim/plugged/skk.vim')
    let skk_jisyo = "~/.vim/skk/.skk-jisyo"
    let skk_large_jisyo = "~/.vim/skk/SKK-JISYO.L"
endif

"Fuf系
"http://vim.g.hatena.ne.jp/keyword/fuzzyfinder.vim
"if isdirectory($HOME . '/.vim/plugged/FuzzyFinder')
"   let g:fuf_modesDisable = ['mrucmd']
"   nmap fb :FufBuffer<CR>
"   nmap fF :FufFile<CR>
"   nmap ff :FufMruFile<CR>
"   nmap fl :FufChangeList<CR>
"endif

"Plug
if isdirectory($HOME . '/.vim/plugged')
call plug#begin('~/.vim/plugged')
    "Plug 'tpope/vim-fugitive'
    "Visual block mode時に$で問題有り
    "Plug 'gregsexton/gitv'
    "Plug 'alpaca-tc/alpaca_powertabline'
    "Plug 'Lokaltog/powerline'
    "Plug 'vim-scripts/L9' | Plug 'vim-scripts/FuzzyFinder'
    Plug 'tpope/vim-rails' , { 'for': 'ruby' }
    Plug 'vim-jp/vimdoc-ja'
    "Plug 'tsaleh/vim-align'
    "Plug 'h1mesuke/vim-alignta'
    Plug 'junegunn/vim-easy-align'
    "Plug 'tyru/skk.vim'
    "Plug 'tyru/eskk.vim'
    Plug 'vim-scripts/DrawIt'
    Plug 'flazz/vim-colorschemes'
    "Plug 'vim-scripts/guicolorscheme.vim'
    Plug 'godlygeek/csapprox'
    Plug 'othree/eregex.vim'
    "Plug 'nathanaelkane/vim-indent-guides'
    "Plug 'vim-scripts/diffchar.vim'
    "Plug 'editorconfig/editorconfig-vim'
    Plug 'mattn/emmet-vim', { 'for': 'html' }
    Plug 'vim-scripts/closetag.vim', { 'for': 'html' }
    Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'
    "Plug 'jwhitley/vim-matchit'
    "Plug 'vim-scripts/YankRing.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
  "Plug 'easymotion/vim-easymotion'
    "Plug 'mg979/vim-visual-multi'
    "Plug 'terryma/vim-multiple-cursors'
    call plug#end()
endif

""http://haya14busa.com/mastering-vim-easymotion/
"if isdirectory($HOME . '/.vim/plugged/vim-easymotion')
"   " =======================================
"   " Boost your productivity with EasyMotion
"   " =======================================
"   " Disable default mappings
"   " If you are true vimmer, you should explicitly map keys by yourself.
"   " Do not rely on default bidings.
"   let g:EasyMotion_do_mapping = 0
"   " Or map prefix key at least(Default: <Leader><Leader>)
"   " map <Leader> <Plug>(easymotion-prefix)
"   " =======================================
"   " Find Motions
"   " =======================================
"   " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
"   " `s{char}{char}{target}`
"   nmap s <Plug>(easymotion-s2)
"   xmap s <Plug>(easymotion-s2)
"   omap z <Plug>(easymotion-s2)
"   " Of course, you can map to any key you want such as `<Space>`
"   " map <Space>(easymotion-s2)
"   " Turn on case sensitive feature
"   let g:EasyMotion_smartcase = 1
"   " =======================================
"   " Line Motions
"   " =======================================
"   " `JK` Motions: Extend line motions
"   map <Leader>j <Plug>(easymotion-j)
"   map <Leader>k <Plug>(easymotion-k)
"   " keep cursor column with `JK` motions
"   let g:EasyMotion_startofline = 0
"   " =======================================
"   " General Configuration
"   " =======================================
"   let g:EasyMotion_keys = 'hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"   " Jump to first match with enter & space
"   let g:EasyMotion_enter_jump_first = 1
"   let g:EasyMotion_space_jump_first = 1
"   " =======================================
"   " Search Motions
"   " =======================================
"   " Extend search motions with vital-over command line interface
"   " Incremental highlight of all the matches
"   " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
"   " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
"   " :h easymotion-command-line
"   nmap g/ <Plug>(easymotion-sn)
"   xmap g/ <Plug>(easymotion-sn)
"   omap g/ <Plug>(easymotion-tn)
"endif

"fzf系
"https://github.com/junegunn/fzf.vim
if isdirectory($HOME . '/.vim/plugged/fzf.vim')
    let g:fzf_buffers_jump = 1
    let g:fzf_commits_log_options = '--no-show-signature --oneline --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    nmap <Leader>fz :FZF<CR>
    nmap <Leader>Fb :Buffers<CR>
    nmap <Leader>fl :Lines<CR>
    nmap <Leader>ff :History<CR>
    nmap <Leader>fs :History/<CR>
    nmap <Leader>gc :BCommits<CR>
    nmap <Leader>gC :Commits<CR>
    nmap <Leader>gf :GFiles<CR>
    nmap <Leader>gs :GFiles?<CR>
    nmap <Leader>fc :Commands<CR>
    nmap <Leader>fm :Marks<CR>
    nmap <Leader>fw :Windows<CR>
    nmap <Leader>fa :Ag
    nmap <Leader>fL :Locate
endif

"https://github.com/junegunn/vim-easy-align
if isdirectory($HOME . '/.vim/plugged/vim-easy-align')
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
endif

""http://stackoverflow.com/questions/15010271/change-location-of-vim-yankring-history-file#15010272
"if isdirectory($HOME . '/.vim/plugged/YankRing.vim')
"   let g:yankring_history_dir = $HOME.'/.vim'
"endif

"http://blog.ruedap.com/2011/02/02/vim-ruby-regexp-plugin-eregex
if isdirectory($HOME . '/.vim/plugged/eregex.vim')
    let g:eregex_default_enable = 0
    nnoremap <Leader>/ :call eregex#toggle()<CR>
endif

"http://vim-users.jp/2009/09/hack77/
"if isdirectory($HOME . '/.vim/plugged/vim-align')
"   let g:Align_xstrlen=3
"endif

""Gitv
""http://cohama.hateblo.jp/entry/20130517/1368806202
"if isdirectory($HOME . '/.vim/plugged/gitv')
"nmap ,g :Gitv --all<CR>
"   autocmd FileType git :setlocal foldlevel=99
"   autocmd FileType gitv call s:my_gitv_settings()
"
"   function! s:my_gitv_settings()
"       setlocal iskeyword+=/,-,.
"       nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w>
"       nnoremap <buffer> <Space>di :<C-u>Git diff <C-r><C-w><CR>
"       nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r><C-w>
"       nnoremap <buffer> <Space>R :<C-u>Git revert <C-r><C-w>
"       nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r><C-w>
"       nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r><C-w>
"   endfunction
"
"endif

"badwolf
if filereadable($HOME . '/.vim/plugged/vim-colorschemes/colors/badwolf.vim')
    colorscheme badwolf
else
    colorscheme pablo
endif

"if isdirectory($HOME . '/.vim/plugged/vim-indent-guides')
"   let g:indent_guides_enable_on_vim_startup = 1
"   hi IndentGuidesOdd  ctermbg=black
"   hi IndentGuidesEven ctermbg=darkgrey
"endif

"Tipsメモ
"
"http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/windows.html
"分割
"C-W,s
"縦分割
"C-W,v
"分割ウインドウ移動
"C-W,C-W
"分割ウインドウカーソル移動
"C-W,hjkl
"分割ウインドウ移動
"C-W,HJKL
"いま開いている分割ウインドウ以外を閉じる
"C-W,C-o
"ウインドウを入れ替える"
"C-W,x
"ウインドウサイズ調整
"C-W,+-=
"
"カーソルを一個前の場所(ファイル)に戻す
"C-O
"
"カーソルを一個先の場所(ファイル)に進める
"C-I
"
"カーソル下のファイル名を開く
"gf
"
"現在検索している単語をペースト
"<C-R>/
"
"\di to start DrawIt and
"\ds to stop  DrawIt.
"
"そのままペースト
":a! <Paste>
"
"カレントバッファをBashなどで実行
"w !bash
"
"検索履歴を参照
":<C-F>
"or
"逆から
":?
"履歴を送る
"C-C
"コマンド履歴を参照
"q:
"逆から
"q?
"
"レジスタの中身をコマンドラインへペースト
":<C-R>"
":<C-R><C-W>
"
"レジスタリスト
"0 最後に yank したテキスト
"- 最後の細かい削除
". 最後に挿入したテキスト
"% 現在のファイル名
"# 代替ファイル名
"/ 最後に検索した文字列
": 最後に実行した:
"_ ブラックホール
"= 計算式
"* マウスで選択されたテキスト
"
"指定エンコードで開きなおす
":e ++enc=euc-jp
":e ++ff=unix
"
"上下の行を現在行へコピー
"<C-E> or <C-Y>
"
"uniqやgrepでフィルタ
":%!uniq
":%!grep
"
":eで開くパスの追加
"let &path += "/etc,/var/log,/var/log/httpd"
"
"Bookmark
"http://nanasi.jp/articles/vim/bookmarks_vim.html
"b
"B
"q
"
"DrawItPlugin.vim
"\di
"\ds
"
"インサートモードでインデントする
"<C-T> or <C-D>
"
"EnhCommentify.vim
"\xでコメントアウト/解除
"
"VisualMode再選択
"gv
"
"カーソル上の単語を全体からリストアップ
"[I
"
"大文字<->小文字変換
"gu<select>
"gU<select>
"
"1ライン上方スクロール
"^y
"ウィンドウの先頭から数えて[count]行目から再描画
"z
"現在行をウィンドウの最上位置にして再描画(位置変化無)
"zt
"ウィンドウの高さを{height}にして再描画
"z{height}<CR>
"現在位置を最上にしてウィンドウを再描画(カーソル現在位置)
"z<CR>
"現在位置を中心にしてウィンドウを再描画(カーソル最左非空白へ)
"z.
"現在位置を中心にしてウィンドウを再描画(カーソル現在位置)
"zz
"現在位置を最下にしてウィンドウを再描画(カーソル最左非空白へ)
"z-
"現在位置を最下にしてウィンドウを再描画(カーソル現在位置)
"zb
"wrap off時: [count]文字左にスクロール
"z<right>
""z<right>" と同じ
"zl
"wrap off時: [count]文字右にスクロール
"z<Left>
""z<Left>" と同じ
"zh
"スクリーン幅の半分左スクロール
"zL
"
"カーソルを画面の上、中、下に移動
"H,M,L
"
"直前操作繰り返し
".
"
"現在行の検索
"f<word>
"現在行の検索（後方）
"F<word>
"
"現在行のワード検索
"f<word>
"現在行の検索（後方）
"F<word>
"現在行の次検索
",
"
"検索、置き換え簡単方法
"置き換えたいワードの上にカーソル移動->'*'->cw->入力->n->.->n->.->繰り返し
"
"コントロールコードの入力
"C-V<>
"
"計算結果の入力
"Insterモード->C-R=->2*2*2->Return
"
"コマンドラインでバッファ番号を指定する
"#バッファ番号
"
"多段Undo
"http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/usr_32.html
"Undoで前のツリーへ戻る
"g-
"Redoで次のツリーへ戻る
"g+
"
"10分前に戻る
":earlier 10s
"
"一分後に進む
":later 1m
"
"コマンドライン操作
"http://www.kaoriya.net/vimdoc_j/cmdline.txt
"C-R....
"
"名前のない登録、最後の削除やヤンクを含む。
"'"'
"カレントファイル名
"'%'
"代替ファイル名
"'#'
"最後の検索パターン
"'/'
"クリップボードの内容
"'*'
"最後のコマンドライン
"':'
"最後の小さな削除(行単位未満)
"'-'
"最後に挿入されたテキスト
"'.'
"式の登録: 式を入力するよう要求される
"'='
"
"ファイル名補完
"CTRL-X CTRL-F
"行全補完
"CTRL-X CTRL-L
"マクロ定義 (インクルードファイルの中も探す)
"CTRL-X CTRL-D
"カレントファイルとインクルードファイ補完
"CTRL-X CTRL-I
"辞補完
"CTRL-X CTRL-K
"同義語辞書 (シソーラス)
"CTRL-X CTRL-T
"タ補完
"CTRL-X CTRL-]
"Vim のコマンドライ補完
"CTRL-X CTRL-V
"
"Window縦分割/横分割切替
"C-W,H
"C-W,J
"
"暗号化を解除する
":X
"
"空白を挿入しないでjoinする
"gJ
"
"最初の検索パターンが現れたところからもう一段検索する
"http://www.kaoriya.net/vimdoc_j/pattern.txt
":/patarn1/;/patarn2
"
"カーソル位置の単語をManpageで検索
"K
"
"カーソル位置の情報を詳細に表示
"g,C-G
"
"コマンドライン総合
"http://www.ac.cyberhome.ne.jp/~yakahaira/vimdoc/cmdline.html
"
"Fold関係
"foldenable をトグルで on off する
"zi
"fold を閉じる(close)
"zc
"fold を再帰的に閉じる(close)
"zC
"fold を開く(open)
"zo
"fold を再帰的に開く(open)
"zO
"foldlevel をインクリメント、 すなわちすべてのfoldを1level開く
"zr
"foldlevel を最大値にする、すなわちすべてのfoldを開く
"zR
"foldlevel をデクリメント、すんわちすべてのfoldを1level閉じる
"zm
"foldlevel を0にする、すなわちすべてのfoldを閉じる
"zM
"fold をカーソルから4行分設定する
"zf4j
"`a fold をカーソルからaのマーク位置まで設定する
"z
"設定された fold を削除
"zd
"設定された fold を再帰的に削除
"zD
"
"全文をソート
":%!sort
"
"バッファ全体に置き替えを適用
":bufdo %s/aaa/bbb/g
"
"バッファ全体に置き替えを適用して保存
":bufdo %s/aaa/bbb/g | wa!
"
"改行位置で整形
"gq
"
"sudoを忘れて権限のないファイルを編集した時
":w !sudo tee %
"
"カーソルの下の単語をさくっと拾って置換で使う
":%s//New York/g とかやると New York に置換
":%g//dすれば Massachusetts を含む行を削除
"%v//dすれば Massachusetts を含む行だけ残すことができる。
"
"Undo関連
"undolist Undo履歴を参照
"g-     古いテキストの状態戻る
"g+     新しいテキストの状態に戻る
":earlier {N}s   {N}秒前の状態に戻ります
":earlier {N}m  {N}分前の状態に戻ります
":earlier {N}h  {N}時間前の状態に戻ります
":later {N}s    {N}秒後の状態に戻ります
":later {N}m    {N}分後の状態に戻ります
":later {N}h    {N}時間後の状態に戻ります
"
"Massachusetts の上で # を押して、 :%s//New York/g とかやると New York に置換
":%g//dすれば Massachusetts を含む行を削除
"%v//dすれば Massachusetts を含む行だけ残すことができる。
"
"文書中の全てのタブをスペースに変換
":set expandtab
":%retab
"
"文書中の全てのスペースをタブに変換
":set noexpandtab
":%retab!
"
"自動的に改行するようにする
"60文字の場合。 :set textwidth=60
"ただし、これだとスペースなどでしか改行されない。日本語では不便。
"
"日本語を textwidth 桁で折り返したい
"gq
"
"Align系
"<Leader>tsp    空白文字で分割して整形。各フィールドは左揃え。
"<Leader>Tsp    空白文字で分割して整形。各フィールドは右揃え。
"<Leader>tsq    空白文字で分割して整形。ダブルクォートで囲まれたフィールドをサポート。各フィールドは左揃え。
"<Leader>tab    TSVの整形。タブ文字で分割して整形。タブ文字は半角スペースに変換される。
"<Leader>t{セパレータ} 指定したセパレータで分割して整形。各フィールドは左揃え。
"<Leader>T{セパレータ} 指定したセパレータで分割して整形。各フィールドは右揃え。
"<Leader>tml    行末のバックスラッシュの位置の整形。シェルスクリプト用。
"<Leader>Htd    HTMLのテーブルの整形。
"<Leader>tt LaTexのテーブルの整形。
"
"surround系
"http://blog.scimpr.com/2012/09/08/surround-vimチュートリアルをためす/
"Change Surroucol("$")nd
"cs"'
"
"Change Surround x to Tag
"cs'<q>
"
"Change Surround Tag to x
"cst"
"
"Delete Surround
"ds"
"
"You Surround x
"ysiw]
"
"空白つきのカッコで囲む
"cs]{
"
"行全体を囲む
"yss)
"
"削除する
"ds{ds)
"
"You Surround x with Tag
"ysiw<pre>
"
"vim-easy-align
"https://github.com/junegunn/vim-easy-align
"
"texile table
"gaip*|
"
"Live
"gaip<C-P>*|<CR><CR>......|
"
"Mergin
"gaip<C-P>*|<C-R> or <C-L>|
"
"Alignment options in interactive mode
"CTRL-F filter  Input string ([gv]/.*/?)
"CTRL-I indentation shallow, deep, none, keep
"CTRL-L left_margin Input number or string
"CTRL-R right_margin    Input number or string
"CTRL-D delimiter_align left, center, right
"CTRL-U ignore_unmatched    0, 1
"CTRL-G ignore_groups   [], ['String'], ['Comment'], ['String', 'Comment']
"CTRL-A align   Input string (/[lrc]+\*{0,2}/)
"<Left> stick_to_left   { 'stick_to_left': 1, 'left_margin': 0 }
"<Right>    stick_to_left   { 'stick_to_left': 0, 'left_margin': 1 }
"<Down> *_margin    { 'left_margin': 0, 'right_margin': 0 }"
"
"Vimでヤンクした内容を複数行にペーストする
"Ctrl+v -> } -> I Ctrl+r -> " -> ESC
"
"その他
"http://www.kaoriya.net/testdir/command_list.txt
"http://www.c.csce.kyushu-u.ac.jp/kb/wiki/index.php?%A5%BD%A5%D5%A5%C8%A5%A6%A5%A8%A5%A2%2FVim%2FFAQ

