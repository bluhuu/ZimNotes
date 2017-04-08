set nocompatible
filetype off
call plug#begin('~/vimfiles/plugged')
Plug 'Shougo/neocomplete.vim'       "echo has('lua')
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'
Plug 'beautify-web/js-beautify'
Plug 'maksimr/vim-jsbeautify'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dkprice/vim-easygrep'
Plug 'drmikehenry/vim-fontsize'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'danro/rename.vim'
Plug 'gregsexton/gitv'
Plug 'gregsexton/matchtag'
Plug 'hail2u/vim-css3-syntax'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'itspriddle/vim-stripper'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'hushicai/tagbar-javascript.vim'
Plug 'marijnh/tern_for_vim'
Plug 'mattn/emmet-vim'
Plug 'matze/vim-move'
Plug 'sjl/gundo.vim'
Plug 'othree/csscomplete.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'mortonfox/nerdtree-clip'
Plug 'sirver/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'vim-expand-region'
Plug 'vim-scripts/L9'
Plug 'w0rp/ale'
Plug 'wesq3/vim-windowswap'
Plug 'yggdroot/indentline'
Plug 'tpope/vim-obsession'
Plug 'mattesgroeger/vim-bookmarks'
Plug 'jelera/vim-javascript-syntax'
Plug 'crusoexia/vim-javascript-lib'
Plug 'algotech/ultisnips-javascript'
Plug 'scrooloose/nerdcommenter'
call plug#end()
"PlugInstall [name ...] [#threads]	Install plugins
"PlugUpdate [name ...] [#threads]	Install or update plugins
"PlugClean[!]	Remove unused directories (bang version will clean without prompt)
"PlugUpgrade	Upgrade vim-plug itself
"PlugStatus	Check the status of plugins
"PlugDiff	Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the "plugins
filetype plugin indent on

let mapleader = ";"
let g:mapleader = ";"
" 引入插件的设置
source $mypath/_custome.vim
" source $mypath/ctrlp-funky.vim
source $mypath/ale.vim
source $mypath/gundo.vim
source $mypath/molokai.vim
source $mypath/neocomplete.vim
source $mypath/nerdcommenter.vim
source $mypath/NerdTree.vim
source $mypath/tern_for_vim.vim
source $mypath/vim-jsbeautify.vim
source $mypath/tagbar.vim
source $mypath/ultisnips.vim
source $mypath/vim-bookmarks.vim
source $mypath/vim-easymotion.vim
source $mypath/vim-expand-region.vim
source $mypath/vim-multiple-cursors.vim
source $mypath/ctrlp.vim
source $mypath/_fun-me.vim
source $mypath/_mapKey.vim
" npm i -g jshint csslint js-beautify esctags postcss-cli autoprefixer
