"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8 会对《M-*》产生影响，要放在最前面
set fenc=utf-8 encoding=utf-8
" 解决consle输出乱码
language message utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,utf-16,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ffs=unix,dos,mac ff=unix
set helplang=cn
set langmenu=zh_CN
let $LANG = 'zh_CN.UTF-8'
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"防止特殊符号无法正常显示
" set ambiwidth=double
"set enc=2byte-gb18030
" 设置终端编码为gvim内部编码encoding
set termencoding=utf-8

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

"模仿windows快捷键 Ctrl+A全选、Ctrl+C复制、Ctrl+V粘贴
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
"设置鼠标运行模式为WINDOWS模式
behave mswin

" 开启语法高亮
syntax on

" au! BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
"==========================================
" General Settings 基础设置
"==========================================
"窗口大小与位置
winpos 100 100
set cmdheight=1 lines=40 columns=130
" history存储容量
set history=2000
set updatecount=819222      "输入这么多个字符以后，把交换文件写入磁盘
set undolevels=819222       "可以撤销的最大改变次数
" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread
set autowriteall
" 启动的时候不显示那个援助乌干达儿童的提示
"set shortmess=atI

" 备份,到另一个位置. 防止误删, 目前是取消备份
"set nobackup                "没有备份
set backupext=.bak
set backupdir=c:\\temp
set directory=c:\\temp
set undodir=c:\\temp

" 取消备份。 视情况自己改
"set nobackup
" 关闭交换文件
"set noswapfile

" TODO: remove this, use gundo
" create undo file
" if has('persistent_undo')
  " " How many undos
  " set undolevels=1000
  " " number of lines to save for undo
  " set undoreload=10000
  " " So is persistent undo ...
  " "set undofile
  " set noundofile
  " " set undodir=/tmp/vimundo/
" endif

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn

" 突出显示当前列
set nocursorcolumn
" 突出显示当前行
set cursorline


" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=


" 鼠标暂不启用, 键盘党....
" set mouse-=a
" 启用鼠标
set mouse=a
" Hide the mouse cursor while typing
" set mousehide


" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

" change the terminal's title
" set title
" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
" vim进行编辑时，如果命令错误，会发出一个响声，该设置去掉响声
set vb t_vb=
set tm=500

" Remember info about open buffers on close
"set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=3
" 水平滚动时滚动的最少列数
set sidescroll=1
" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
" set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number
" 取消换行
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

set clipboard+=unnamed      "与windows共享剪贴板

" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
" 如果非零，指定宽度的列在窗口的一侧显示，指示折叠的打开和关闭。最大值为12
set fdc=2
" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent
set linebreak
set iskeyword+=_,$,@,%,#,-      "带有如下符号的单词不要被换行分割
set textwidth=180
" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
" set relativenumber number
" au FocusLost * :set norelativenumber number
" au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
" autocmd InsertEnter * :set norelativenumber number
" autocmd InsertLeave * :set relativenumber

" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif



"==========================================
" others 其它设置
"==========================================
" vimrc文件修改之后自动加载, windows
" autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
" autocmd! bufwritepost .vimrc source %

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class

" 离开插入模式后自动关闭预览窗口
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
" autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
" autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
" autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
" autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>


" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste
let g:last_active_tab = 1
"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
" autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
" autocmd FileType ruby,javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
" autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
" autocmd BufRead,BufNewFile *.part set filetype=html
" disable showmatch when use > in php
au BufWinEnter *.php set mps-=<:>



" 设置可以高亮的关键字
" if has("autocmd")
  " if v:version > 701
    " autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    " autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  " endif
" endif

"==========================================
" Theme Settings  主题设置
"==========================================

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Consolas:h11
    if has("win32")
        set guifont=DejaVuSansMono\ NF:h11 gfw=新宋体:h11
    endif
    set guioptions-=T           "工具条
    set guioptions+=e           "可用来改变标签文本
    set guioptions-=r           "右滚动条
    set guioptions-=L           " Removes left hand scroll bar
    set guioptions-=m           "菜单栏
    set guioptions+=c           "简单的选择使用控制台对话框而不是弹出式对话框
    set showtabline=1           "本选项的值指定何时显示带有标签页标签的行
    set showmode                " always show what mode we're currently editing in
    set guitablabel=%M\ %t
    set linespace=2
    set noimd
    set t_Co=256
endif

set foldopen-=search        " don't open folds when you search into them
set foldopen-=undo          " don't open folds when you undo stuff
set foldlevel=99

" theme主题
set background=dark
set t_Co=256

" colorscheme solarized
colorscheme molokai
" colorscheme desert

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

set tags+=.tags
" 每次保存自动生成tags
" 如启动报错，请先安装ctags
" 跳转快捷键：<ctrl-]>跳转 <ctrl-t>返回
au BufWritePost *.c,*.cpp,*.h,*.php,*.json,*.erl,*.sh,*.html,*.css,*.conf silent! !(ps -ef|grep ctags|grep -v grep|awk '{print $2}'|xargs -I{} kill -9 {}; rm -f .ctags1; ctags -Rf .tags1 --exclude='*.js' && mv -f .tags1 .tags) &> /dev/null &
set ai si ci
set timeout timeoutlen=1500 ttimeoutlen=100

" 自定义语法
au BufRead,BufNewFile *.wxml set filetype=html
au BufRead,BufNewFile *.wxss set filetype=css
