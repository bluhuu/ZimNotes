let g:airline_theme="molokai"
set laststatus=2

" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1

" 开启tabline方便查看Buffer
 let g:airline#extensions#tabline#enabled = 1
" tabline中filename
 let g:airline#extensions#tabline#fnamemod = ':t'
 " tabline中当前buffer两端的分隔字符
 " let g:airline#extensions#tabline#left_sep = ' '
 " tabline中未激活buffer两端的分隔字符
 " let g:airline#extensions#tabline#left_alt_sep = '|'
 " tabline中buffer显示编号
 let g:airline#extensions#tabline#buffer_nr_show = 1

 " 关闭状态显示空白符号计数,这个对我用处不大"
 let g:airline#extensions#whitespace#enabled = 0
 let g:airline#extensions#whitespace#symbol = '!'

 "设置切换Buffer快捷键"
 nnoremap <C-n> :bnext<cr>
 nnoremap <C-p> :bprev<cr>
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
 nmap <leader>d :bd<cr>
 nmap <leader>x :b#<cr>
 nmap <S-up> :tabp<cr>
 nmap <S-down> :tabn<cr>
