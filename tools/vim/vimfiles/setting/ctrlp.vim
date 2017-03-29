let g:ctrlp_map = '<c-u>'
let g:ctrlp_cmd = 'CtrlP'
nmap <c-b> :CtrlPBuffer<CR>
nmap <c-e> :CtrlPMRU<CR>
nmap <M-r> :CtrlPBufTag<cr>
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](node_modules|target|dist|extjs)|(\.(git|hg|svn|rvm|node_modules|DS_Storegit|optimized|compiled))$',
\ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
\ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
