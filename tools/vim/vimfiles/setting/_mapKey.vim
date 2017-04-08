"--------------------------自定义快捷键---------------------
imap jj <esc>
imap <C-i> <esc>
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <M-left> <C-w>H
nmap <M-down> <C-w>J
nmap <M-up> <C-w>K
nmap <M-right> <C-w>L
nmap <C-right> :vertical resize +10<cr>
nmap <C-left> :vertical resize -10<cr>
nmap <C-up> :resize +10<cr>
nmap <C-down> :resize -10<cr>
nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
" select all
nmap <Leader>sa ggVG
nmap <Leader>i :noh<cr>
nmap <leader>vs :vsplit<cr>
nmap <leader>sv :vsplit<cr>
nmap <leader>sp :split<cr>
nmap <leader><cr> :noh<cr>

" select block
nnoremap <leader>v V`}
" Quickly save the current file
nnoremap <leader>w :w
" nmap <leader>e :e!<cr>
nmap <leader>dd :edit %:p:h/
nmap <leader>df :diffthis<CR>
nmap <leader>dn :enew<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Quickly edit/reload the vimrc file
" nmap <silent> <leader>ev :e $MYVIMRC<CR>

noremap <F1> <Esc>"
" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>
" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>
" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
set pastetoggle=<F7>            "    when in insert mode, press <F7> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
" 搜索相关
" 进入搜索Use sane regexes"
nmap z/ <Plug>(incsearch-fuzzy-/)
nmap z? <Plug>(incsearch-fuzzy-?)
nmap zg/ <Plug>(incsearch-fuzzy-stay)
" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %
" remap U to <C-r> for easier redo
nnoremap U <C-r>

" 绑定插入模式下的方向键
imap <C-b> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-f> <Right>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

" 保存时自动将tab转换为相应长度的空格
" 此行禁止开启，否则会导致撤销到最新时保存后，无法重做！！！
" autocmd BufWritePre * :%retab!

" Tab configuration
nmap <leader>tn :tabnew %:p:h<cr>
nmap <leader>te :tabedit
nmap <leader>tc :tabclose<cr>
nmap <leader>tm :tabmove

" 设置为搜索时不要回卷
" set nowrapscan

nmap <F8> :bd<CR>
nmap <C-F8> :%bd<CR>
nmap <leader>ch :!start C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe %:p<CR>
nmap <leader>gs :!start C:\Program Files\Git\git-bash.exe<CR>
nmap <leader>gl :Git log --pretty=format:"\%cn - \%h - \%ar \%s"<cr>

nmap <leader>ss :set scrollbind<CR>
nmap <leader>sn :set noscrollbind<CR>

"设置切换Buffer快捷键"
nmap <leader>1 :bfirst<cr>
nmap <leader>2 :b2<cr>
nmap <leader>3 :b3<cr>
nmap <leader>4 :b4<cr>
nmap <leader>5 :b5<cr>
nmap <leader>6 :b6<cr>
nmap <leader>7 :b7<cr>
nmap <leader>8 :b8<cr>
nmap <leader>9 :b9<cr>
nmap <leader>0 :blast<cr>
nmap <leader>x :b#<cr>
nnoremap <S-down> :tabn<cr>
nnoremap <S-up> :tabp<cr>
"设置切换tabs快捷键
nnoremap <C-n> :bnext<cr>
nnoremap <C-p> :bprev<cr>
"菜单栏隐藏与显示动态切换
map <silent> <C-F1> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
nmap gcc <leader>c<Space>
xmap gcc <leader>c<Space>
