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
