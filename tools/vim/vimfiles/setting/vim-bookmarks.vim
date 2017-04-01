let g:bookmark_save_per_working_dir = 1 "Save bookmarks per working dir, the folder you opened vim from
let g:bookmark_auto_save = 1 "Enables/disables automatic saving for bookmarks
let g:bookmark_manage_per_buffer = 1 "Save bookmarks when leaving a buffer, load when entering one
let g:bookmark_auto_save_file = $HOME .'/.vim-bookmarks' "Sets file for auto saving (ignored when bookmark_save_per_working_dir is enabled)
let g:bookmark_auto_close = 0 "Automatically close bookmarks split when jumping to a bookmark
let g:bookmark_highlight_lines = 1 "Enables/disables line highlighting
let g:bookmark_show_warning = 1 "Enables/disables warning when clearing all bookmarks
let g:bookmark_show_toggle_warning = 0 "Enables/disables warning when toggling to clear a bookmark with annotation
let g:bookmark_center = 1 "Enables/disables line centering when jumping to bookmark
let g:bookmark_location_list = 0 "Use the location list to show all bookmarks
let g:bookmark_disable_ctrlp = 0 "Disable ctrlp interface when show all bookmarks
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'

let g:bookmark_no_default_key_mappings = 1 "disable all default key bindings
nmap <C-F2> <Plug>BookmarkToggle
nmap <Leader><F2> <Plug>BookmarkAnnotate
nmap <M-F2> <Plug>BookmarkShowAll
nmap <F2> <Plug>BookmarkNext
nmap <S-F2> <Plug>BookmarkPrev
" nmap <Leader>x <Plug>BookmarkClear
" nmap <Leader>x <Plug>BookmarkClearAll
" nmap <Leader>kk <Plug>BookmarkMoveUp
" nmap <Leader>jj <Plug>BookmarkMoveDown
