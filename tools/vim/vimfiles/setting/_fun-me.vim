map <leader>zc :call ToggleFold()<cr>
nmap <leader>zz :call Zoom()<CR>
map <leader><F8> :call DeleteAllBuffersInWindow()<CR>
map <C-F12> <ESC>:call OpenFileLocation()<CR>
" nnoremap <F2> :call HideNumber()<CR>
"autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
set statusline=\ %h%1*%m%r%w%0*\ [%Y]\ [%{&ff}]\ [%{&fenc}:%{&enc}]\ [%05.5b-%04.4B]
set statusline+=\ \ %r%{CurDir()}%h\ \ \ Line:\ %l/%L=%p%%\ %c
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}

" ---ToggleFold--------------------------------------------
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun
" ---Zoom--------------------------------------------
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
" ---DeleteAllBuffersInWindow--------------------------------------------
fun! DeleteAllBuffersInWindow()
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif
    let s:curBufNr = bufnr("%")
    exe "bn"
    let s:nextBufNr = bufnr("%")
    while s:nextBufNr != s:curBufNr
        exe "bn"
        exe "bdel ".s:nextBufNr
        let s:nextBufNr = bufnr("%")
    endwhile
endfun
" ---HideNumber----------------------------------
" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
" ---相对行号: 行号变成相对，可以用 nj/nk 进行跳转切换 ----
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
" ---保存文件时删除多余空格---------------------------
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
" ---定义函数AutoSetFileHead，自动插入文件头----------------
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc
" ---当前位置---------------------------------
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction
" ---neocomplete 与 multiple cursors 冲突解决
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction
function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
function OpenFileLocation()
    if ( expand("%") != "" )
        execute "!start explorer /select, %"
    else
        execute "!start explorer /select, %:p:h"
    endif
endfunction

" npm i -g postcss-cli autoprefixer
vnoremap <F7> : <c-u>call PrefixVisualMyCSS()<cr>
nnoremap <C-F7> : <c-u>call PrefixMyCSS()<cr>
nnoremap <F7> : <c-u>call PrefixMeCSS()<cr>
command! Prefix call PrefixMyCSS()

function! PrefixVisualMyCSS()
    echo "Add CSS vendor prefixes to visually selected block of code"
    echo "Hit ENTER or you can add Autoprefixer CLI Options"
    call inputsave()
    let Options = input('Enter options:')
    call inputrestore()
        silent exec "'<,'>! postcss --use autoprefixer " . escape(expand(Options), '%')
        exe
            %s/\r\+$//e
        exe
endfunction

function! PrefixMyCSS()
    echo "Add vendor prefixes to CSS rules"
    echo "Hit ENTER or you can add Autoprefixer CLI Options"
    call inputsave()
    let Options = input('Enter options:')
    call inputrestore()
        silent exec "%! postcss --use autoprefixer " . escape(expand(Options), '%')
        exe
            %s/\r\+$//e
        exe
endfunction

function! PrefixMeCSS()
    call inputrestore()
        silent exec "!postcss % --use autoprefixer -o %"
endfunction
