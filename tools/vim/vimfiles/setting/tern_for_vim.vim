" ----------------------------------------------------------------------------
" tern_for_vim
" ----------------------------------------------------------------------------
autocmd FileType javascript setlocal omnifunc=tern#Complete
" 鼠标停留在方法内时显示参数提示
let g:tern_show_argument_hints = 'on_hold'
" 补全时显示函数类型定义
let g:tern_show_signature_in_pum = 1
" 跳转到浏览器
autocmd FileType javascript nnoremap <leader>tb :TernDocBrowse<cr>
" 显示变量定义
autocmd FileType javascript nnoremap <leader>tt :TernType<cr>
" 跳转到定义处
autocmd FileType javascript nnoremap <leader>tf :TernDef<cr>
" 显示文档
autocmd FileType javascript nnoremap <leader>td :TernDoc<cr>
" 预览窗口显示定义处代码
autocmd FileType javascript nnoremap <leader>tp :TernDefPreview<cr>
" 变量重命名
autocmd FileType javascript nnoremap <leader>tr :TernRename<cr>
" location 列表显示全部引用行
autocmd FileType javascript nnoremap <leader>ts :TernRefs<cr>
