let iCanHazVundle=1
" let $HOME = "C:/Users/Administrator"
let vundle_readme=expand('$HOME/vimfiles/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    silent !mkdir -p vimfiles/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git vimfiles/bundle/Vundle.vim
    let iCanHazVundle=0
endif
cd D:\bluhuu\ZimNotes
"""""""" 插件管理Vundle""""""""
"关闭兼容模式
set nocompatible
filetype off
set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
call vundle#begin('$HOME/vimfiles/bundle/')
Plugin 'VundleVim/Vundle.vim'
" -------------------------------插件列表----------------------------------
" Plugin 'Mark'
Plugin 'Shougo/neocomplete.vim'
Plugin 'ai/autoprefixer'
Plugin 'airblade/vim-gitgutter'
Plugin 'alvan/vim-closetag'
Plugin 'ap/vim-css-color'
Plugin 'beautify-web/js-beautify'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'drmikehenry/vim-fontsize'
Plugin 'easymotion/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'gregsexton/gitv'
Plugin 'gregsexton/matchtag'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'honza/vim-snippets'
Plugin 'itspriddle/vim-stripper'
Plugin 'jiangmiao/auto-pairs'
Plugin 'leshill/vim-json'
Plugin 'majutsushi/tagbar'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'marijnh/tern_for_vim'
Plugin 'mattn/emmet-vim'
Plugin 'matze/vim-move'
Plugin 'sjl/gundo.vim'
Plugin 'othree/csscomplete.vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'mortonfox/nerdtree-clip'
Plugin 'sirver/ultisnips'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'vim-autoprefixer'
Plugin 'vim-expand-region'
Plugin 'vim-scripts/L9'
Plugin 'w0rp/ale'
Plugin 'wesq3/vim-windowswap'
Plugin 'yggdroot/indentline'
Plugin 'hushicai/tagbar-javascript.vim' "npm install -g esctags
Plugin 'tpope/vim-obsession'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'crusoexia/vim-javascript-lib'
Plugin 'algotech/ultisnips-javascript'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'othree/javascript-libraries-syntax.vim' 注释的也亮
" Plugin 'grvcoelho/vim-javascript-snippets'
if iCanHazVundle == 0
    :PluginInstall
endif
call vundle#end()
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
set runtimepath^=$HOME/vimfiles/bundle/ag.vim
