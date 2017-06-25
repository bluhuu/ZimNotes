" vim-jsbeautify
map <M-b> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <M-b> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <M-b> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <M-b> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <M-b> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <M-b> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <M-b> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <M-b> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <M-b> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <M-b> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <M-b> :call RangeCSSBeautify()<cr>
